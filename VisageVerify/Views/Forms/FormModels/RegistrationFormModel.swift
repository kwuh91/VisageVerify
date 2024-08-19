//
//  FormModel.swift
//  VisageVerify
//
//  Created by Nikita Ochkin on 18.08.2024.
//

import Foundation
import Combine

// FormModel class conforms to ObservableObject,
// meaning instances of this class can be observed for changes.
class RegistrationFormModel: ObservableObject {
    
    // These variables are marked with @Published,
    // so any change will notify observers.
    @Published var mail   = ""
    @Published var pass   = ""
    @Published var retype = ""
    
    @Published var canSend     = false
    @Published var invalidMail = ""
    @Published var invalidPass = ""

    // AnyCancellable is a data type that can hold any subscription. 
    // Nothing more to explain.
    private var subscriptions: Set<AnyCancellable> = .init()
    // is equivalent to:
    // private var subscriptions: Set<AnyCancellable> = Set<AnyCancellable>()
    
    init() {
        
        // A publisher that emits true if mail is not empty and is a valid email, false otherwise.
        let mailValidation = $mail
                                .map({ !$0.isEmpty && $0.isValidEmail })
                                .eraseToAnyPublisher()
        // A publisher that emits true if pass is not empty, false otherwise.
        let passValidation = $pass
                                .map({ !$0.isEmpty })
                                .eraseToAnyPublisher()
        // A publisher that emits true if retype is not empty, false otherwise.
        let retypeValidation = $retype
                                .map({ !$0.isEmpty })
                                .eraseToAnyPublisher()
        // A publisher that emits true if pass and retype are the same, false otherwise.
        let matchValidation = $pass.combineLatest($retype)
                                .map({ $0 == $1 })
                                .eraseToAnyPublisher()
        
        Publishers.CombineLatest4(mailValidation, passValidation, retypeValidation, matchValidation)
            .map({ [$0.0, $0.1, $0.2, $0.3] }) // Transforms the tuple from CombineLatest4 into an array of four Booleans.
            .map({ $0.allSatisfy{ $0 } })      // Checks if all elements in the array are true.
            .assign(to: &$canSend)             // asigns the result to canSend
        
        // Updates invalidMail with an error message if the email is invalid or empty.
        $mail
            .map({ $0.isEmpty || $0.isValidEmail ? "" : "enter valid mail address" })
            .assign(to: &$invalidMail)
        
        // Updates invalidPass with an error message if the passwords do not match or
        // if at least one of them is empty.
        $pass.combineLatest($retype)
            .filter({ !$0.0.isEmpty && !$0.1.isEmpty })
            .map({ $0.0 == $0.1 ? "" : "must match password" })
            .assign(to: &$invalidPass)
    }
    
}

extension String {
    
    var isValidEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
     }
    
}
