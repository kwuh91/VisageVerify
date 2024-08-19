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
    // TODO: var realName: String = ""
    // TODO: var username: String = ""
    var email:    String = ""
    var password: String = ""
    // TODO: var biometry: ???
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
    
    @Published var allGood         = false
    @Published var invalidEmail    = ""
    @Published var invalidPassword = ""

    @Published var errorMessage: String? {
        // Print `errorMessage` if `errorMessage` is changed.
        didSet {
            if let errorMessage {
                print("Error Message: \(errorMessage)")
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
        
        // A publisher that emits true if user.email is not empty and is a valid email, false otherwise.
        let emailValidation = $user
                                .map({ !$0.email.isEmpty && $0.email.isValidEmail })
                                // TODO: .receive(on: RunLoop.main) // Ensures updates are made on the main thread.
                                .eraseToAnyPublisher()
        // A publisher that emits true if user.password is not empty, false otherwise.
        let passwordValidation = $user
                                    .map({ !$0.password.isEmpty })
                                    // .receive(on: RunLoop.main) // Ensures updates are made on the main thread.
                                    .eraseToAnyPublisher()
        // A publisher that emits true if checkPassword is not empty, false otherwise.
        let checkPasswordValidation = $checkPassword
                                        .map({ !$0.isEmpty })
                                        // .receive(on: RunLoop.main) // Ensures updates are made on the main thread.
                                        .eraseToAnyPublisher()
        // A publisher that emits true if user.password and checkPassword are the same, false otherwise.
        let matchPasswordsValidation = $user.combineLatest($checkPassword)
                                            .map({ $0.password == $1 })
                                            // .receive(on: RunLoop.main) // Ensures updates are made on the main thread.
                                            .eraseToAnyPublisher()
        
        Publishers.CombineLatest4(emailValidation,
                                  passwordValidation,
                                  checkPasswordValidation,
                                  matchPasswordsValidation)
            .map({ [$0.0, $0.1, $0.2, $0.3] }) // Transforms the tuple from CombineLatest4 into an array of four Booleans.
            .map({ $0.allSatisfy{ $0 } })      // Checks if all elements in the array are true.
            // .receive(on: RunLoop.main)      // Ensures updates are made on the main thread.
            .assign(to: &$allGood)             // asigns the result to allGood.
        
        // Updates invalidEmail with an error message if the email is invalid or empty.
        $user
            .map({ $0.email.isEmpty || $0.email.isValidEmail ? "" : "enter valid mail address" })
            // .receive(on: RunLoop.main) // Ensures updates are made on the main thread.
            .assign(to: &$invalidEmail)
        
        // Updates invalidPassword with an error message if the passwords do not match or
        // if at least one of them is empty.
        $user.combineLatest($checkPassword)
            .filter({ !$0.0.password.isEmpty && !$0.1.isEmpty })
            .map({ $0.0.password == $0.1 ? "" : "must match password" })
            // .receive(on: RunLoop.main) // Ensures updates are made on the main thread.
            .assign(to: &$invalidPassword)
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
    
    // Function for storing additional user data in Firestore.
    private func storeUserData(userID: String) {
        let userData: [String: Any] = [
            // "realName": user.realName,
            // "username": user.username,
            "email": user.email
            // "biometry": user.biometry
        ]
        
        db.collection("userData").document(userID).setData(userData) { [weak self] error in
            if let error {
                self?.errorMessage = "Failed to store user data: \(error.localizedDescription)"
            } else {
                self?.errorMessage = "User registered successfully."
            }
        }
    }
    
    // loginUser
}

extension String {
    
    var isValidEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
     }
    
}
