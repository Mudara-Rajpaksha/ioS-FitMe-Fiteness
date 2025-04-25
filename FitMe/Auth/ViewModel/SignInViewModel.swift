//
//  SignInViewModel.swift
//  FitMe
//
//  Created by Yesh Adithya on 2025-04-13.
//

import Foundation
import SwiftUI
import FirebaseAuth
import FirebaseFirestore

class SignInViewModel: ObservableObject {
    // Login Properties
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var showPasword: Bool = false
    
    // Register Properties
    @Published var registerUser: Bool = false
    @Published var re_Enter_password: String = ""
    @Published var showReEnterPasword: Bool = false
    
    @Published var showToast: Bool = false
    @Published var showErrorMessage: String = ""
    
    //Login Status
    @AppStorage("isUserLoggedIn") private var isUserLoggedIn: Bool = false
    let defaults = UserDefaults.standard
    let ref = Firestore.firestore()
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
    
    func verify(){
        guard isValidEmail(email) else {
            self.showErrorMessage = "Please enter a valid email."
            return
        }
        
        if registerUser {
            if self.email != "" && self.password != "" {
                if self.password == self.re_Enter_password {
                    createNewAccount()
                }else{
                    self.showErrorMessage = "Password mismatch"
                    self.showToast.toggle()
                }
            } else {
                self.showErrorMessage = "Please Fill the all the Fields properly"
                self.showToast.toggle()
            }
        }else{
            if self.email != "" && self.password != "" {
                loginWithEmail()
            } else {
                self.showErrorMessage = "Please Fill the all the Fields properly"
                self.showToast.toggle()
            }
        }

    }
    
    func loginWithEmail(){
        Auth.auth().signIn(withEmail: self.email, password: self.password) { (res , err)  in
            if err != nil {
                self.showToast.toggle()
                self.showErrorMessage = err!.localizedDescription
            }else{
                
                fetchUser() { userDetails in
                    withAnimation {
                        self.defaults.setValue(userDetails.email, forKey: "userEmail")
                        self.isUserLoggedIn = true
                    }

                }

            }
        }
    }
    
    func createNewAccount(){
        Auth.auth().createUser(withEmail: self.email, password: self.password) { (res , err)  in
            if err != nil {
                self.showToast.toggle()
                self.showErrorMessage = err!.localizedDescription
            }else{
                let uid = res?.user.uid
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                let dateString = dateFormatter.string(from: Date())
                
                
                self.ref.collection("Users").document(uid!).setData([
                    "uid" : uid as Any,
                    "email" : self.email,
                    "dateCreated" : dateString
                    
                ]) { (err) in
                    if err != nil {
                        self.showToast.toggle()
                        self.showErrorMessage =  err!.localizedDescription
                    }else{
                        self.showToast.toggle()
                        self.showErrorMessage = "Registered Successfully"
                        self.email = ""
                        self.password = ""
                        self.re_Enter_password = ""
                    }
                }
            }
        }
    }
    
    func logout(){
        do {
            try Auth.auth().signOut()
            withAnimation {
                isUserLoggedIn = false
            }
            print("User logged out successfully.")
            // Navigate to the login screen or perform any other action after logout
        } catch let signOutError as NSError {
            print("Error signing out: \(signOutError.localizedDescription)")
        }

    }
    
    func fetchUserDetails(completion: @escaping (UserProfile?) -> Void) {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        let db = Firestore.firestore()
        
        db.collection("Users").document(userID).getDocument { snapshot, error in
            if let error = error {
                print("Error fetching user details: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            if let data = snapshot?.data() {
                do {
                    let user = try snapshot?.data(as: UserProfile.self)
                    completion(user)
                } catch {
                    print("Error decoding user details: \(error.localizedDescription)")
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        }
    }

    
    func updateUserDetails(user: UserProfile, completion: @escaping (Bool) -> Void) {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        let db = Firestore.firestore()
        
        do {
            try db.collection("Users").document(userID).setData(from: user) { error in
                if let error = error {
                    print("Error updating user details: \(error.localizedDescription)")
                    completion(false)
                } else {
                    completion(true)
                }
            }
        } catch {
            print("Error encoding user details: \(error.localizedDescription)")
            completion(false)
        }
    }
}
