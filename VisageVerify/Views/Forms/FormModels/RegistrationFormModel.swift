//
//  FormModel.swift
//  VisageVerify
//
//  Created by Nikita Ochkin on 18.08.2024.
//

import Foundation
import Combine
import Firebase
import FirebaseAuth
import FirebaseFirestore

struct User {
    var realName: String = ""
    var username: String = ""
    var email:    String = ""
    var password: String = ""
    var biometry: String = ""
}

// FormModel class conforms to ObservableObject,
// meaning instances of this class can be observed for changes.
class RegistrationFormModel: ObservableObject {
    
    // These variables are marked with @Published,
    // so any change will notify observers.
    
    @Published var user: User = .init()
    // is equivalent to:
    // @Published var user: User = User()
    
    @Published var checkPassword = ""
    
    @Published var allGood = false
    
    @Published var invalidRealName      = ""
    @Published var invalidUsername      = ""
    @Published var invalidEmail         = ""
    @Published var invalidPassword      = ""
    @Published var invalidCheckPassword = ""
    
    @Published var errorMessage: String? {
        // Print `errorMessage` if `errorMessage` is changed.
        didSet {
            if let errorMessage {
                print(errorMessage)
            }
        }
    }
    
    // Initialize firestore.
    private var db = Firestore.firestore()
    
    // AnyCancellable is a data type that can hold any subscription.
    // Nothing more to explain.
    private var subscriptions: Set<AnyCancellable> = .init()
    // is equivalent to:
    // private var subscriptions: Set<AnyCancellable> = Set<AnyCancellable>()
    
    init() {
        
        // A publisher that emits true if user.realName is not empty, false otherwise.
        let realNameValidation = $user
            .map({ $0.realName.count > 1 })
            .receive(on: RunLoop.main) // Ensures updates are made on the main thread.
            .eraseToAnyPublisher()
        
        // A publisher that emits true if user.username is not empty and not present in the database, false otherwise.
        let usernameValidation = $user
                                    .flatMap ({ [weak self] user -> AnyPublisher<Bool, Never> in
                                        guard let self = self else {
                                            return Just(false).eraseToAnyPublisher()
                                        }
                                        
                                        return user.username.isEmpty
                                            ? Just(false).eraseToAnyPublisher()
                                            : self.doesValueExist(collectionName: "userData", 
                                                                  key:            "username",
                                                                  value:          user.username,
                                                                  isExist:        false)
                                            .eraseToAnyPublisher()
                                    })
                                    .receive(on: RunLoop.main) // Ensures updates are made on the main thread.
        
        // A publisher that emits true if user.email is not empty and is a valid email, false otherwise.
        let emailValidation = $user
                                .map({ !$0.email.isEmpty && $0.email.isValidEmail })
                                .receive(on: RunLoop.main) // Ensures updates are made on the main thread.
                                .eraseToAnyPublisher()
        
        // A publisher that emits true if user.password is not empty, false otherwise.
        let passwordValidation = $user
                                    .map({ !$0.password.isEmpty && $0.password.isValidPassword })
                                    .receive(on: RunLoop.main) // Ensures updates are made on the main thread.
                                    .eraseToAnyPublisher()
        
        // A publisher that emits true if checkPassword is not empty, false otherwise.
        let checkPasswordValidation = $checkPassword
                                            .map({ !$0.isEmpty })
                                            .receive(on: RunLoop.main) // Ensures updates are made on the main thread.
                                            .eraseToAnyPublisher()
        
        // A publisher that emits true if user.password and checkPassword are the same, false otherwise.
        let matchPasswordsValidation = $user.combineLatest($checkPassword)
                                            .map({ $0.password == $1 })
                                            .receive(on: RunLoop.main) // Ensures updates are made on the main thread.
                                            .eraseToAnyPublisher()
        
        Publishers.CombineLatest(realNameValidation, 
                                 usernameValidation)
                  .combineLatest(emailValidation)
                  .combineLatest(passwordValidation)
                  .combineLatest(checkPasswordValidation)
                  .combineLatest(matchPasswordsValidation)
                  .map({ [$0.0.0.0.0, $0.0.0.0.1, $0.0.0.1, $0.0.1, $0.1, $1] }) // Transforms the tuples from all the CombineLatest
                                                                                 // into an array of n Booleans.
                  .map({ $0.allSatisfy{ $0 } }) // Checks if all elements in the array are true.
                  .receive(on: RunLoop.main) // Ensures updates are made on the main thread.
                  .assign(to: &$allGood)        // asigns the result to allGood.
        
        // Updates invalidRealName with an error message if the realName is less than 2 characters.
        $user
            .map({ $0.realName.isEmpty || $0.realName.count > 1 ? "" : "Name must be >1 characters." })
            .receive(on: RunLoop.main) // Ensures updates are made on the main thread.
            .assign(to: &$invalidRealName)
        
        // Updates invalidUsername with an error message if the username is already in database or empty.
        $user
            .flatMap ({ [weak self] user in
                self?.doesValueExist(collectionName: "userData",
                                     key:            "username",
                                     value:          user.username,
                                     isExist:        false)
                .map ({ isFree -> String in
                    return user.username.isEmpty || isFree ? "" : "Username is taken."
                }).eraseToAnyPublisher() ?? Just("Something went wrong").eraseToAnyPublisher()
            })
            .assign(to: &$invalidUsername)
        
        // Updates invalidEmail with an error message if the email is invalid or empty.
        $user
            .map({ $0.email.isEmpty || $0.email.isValidEmail ? "" : "Enter valid email address." })
            .receive(on: RunLoop.main) // Ensures updates are made on the main thread.
            .assign(to: &$invalidEmail)
        
        // Updates invalidPassword with an error message if the password is invalid.
        $user
            .map({ $0.password.isEmpty || $0.password.isValidPassword ? "" : "Password must consist of minimum eight characters, at least one uppercase letter, one lowercase letter, one number and one special character." })
            .receive(on: RunLoop.main) // Ensures updates are made on the main thread.
            .assign(to: &$invalidPassword)
        
        // Updates invalidCheckPassword with an error message if the passwords do not match or
        // if at least one of them is empty.
        $user.combineLatest($checkPassword)
            // .filter({ !$0.0.password.isEmpty && !$0.1.isEmpty })
            .map({ $0.1.isEmpty || ($0.0.password == $0.1) ? "" : "Passwords must match." })
            .receive(on: RunLoop.main) // Ensures updates are made on the main thread.
            .assign(to: &$invalidCheckPassword)
    }
    
    // Register user in db, using email and password.
    // Then store all the additional user data in Firestore.
    func registerUser() {
        // Using [weak self] to avoid a retain cycle
        Auth.auth().createUser(withEmail: user.email, password: user.password) { [weak self] authResult, error in
            // Setting `errorMessage` if registration fails.
            if let error {
                self?.errorMessage = "Registration failed: \(error.localizedDescription)"
                return
            }
            
            // Setting `errorMessage` if user ID is not found.
            guard let userID = authResult?.user.uid else {
                self?.errorMessage = "User ID not found."
                return
            }
            
            // Storing additional user data in Firestore.
            self?.storeUserData(userID: userID)
        }
    }
    
    // TODO: loginUser
    
    // Function for storing additional user data in Firestore.
    private func storeUserData(userID: String) {
        let userData: [String: Any] = [
            "realName": user.realName,
            "username": user.username,
            "email"   : user.email,
            "biometry": user.biometry
        ]
        
        db.collection("userData").document(userID).setData(userData) { [weak self] error in
            if let error {
                self?.errorMessage = "Failed to store user data: \(error.localizedDescription)"
            } else {
                self?.errorMessage = "User registered successfully."
            }
        }
    }
    
    // Function to check if value is/isn't in database
    private func doesValueExist(collectionName: String,
                                key:            String,
                                value:          String,
                                isExist:        Bool) -> Future<Bool, Never> {
        return Future { promise in
            Task {
                do {
                    let snapshot = try await self.db.collection(collectionName)
                                                        .whereField(key, isEqualTo: value)
                                                        .getDocuments()
                    if isExist {
                        promise(.success(!snapshot.isEmpty))
                    } else {
                        await MainActor.run {
                            promise(.success(snapshot.isEmpty))
                        }
                    }
                    
                } catch {
                    self.errorMessage = "Failed to check value: \(error.localizedDescription)"
                    
                    if isExist {
                        promise(.success(false))
                    } else {
                        promise(.success(true))
                    }
                }
            }
        }
    }

}

extension String {
    
    var isValidEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
     }
    
    var isValidPassword: Bool {
        // Minimum eight characters, at least one uppercase letter,
        // one lowercase letter, one number and one special character.
        let passwordRegEx = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$"
        let passwordTest = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        return passwordTest.evaluate(with: self)
    }
}
// password must consist of minimum eight character
// >= 8 characters, >= 1 uppercase letter
