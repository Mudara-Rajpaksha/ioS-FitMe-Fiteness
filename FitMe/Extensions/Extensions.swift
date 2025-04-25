//
//  Extensions.swift
//  FitMe
//
//  Created by Yesh Adithya on 2025-04-18.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

let ref = Firestore.firestore()

func fetchUser(completion: @escaping (UserModel) -> ()){
    let uid = Auth.auth().currentUser!.uid
    ref.collection("Users").document(uid).getDocument{ (doc, err) in
        guard let user = doc else { return }
    
        let email = user.data()?["email"] as! String
         
        DispatchQueue.main.async {
            completion(UserModel(email: email))
        }
    }
}
