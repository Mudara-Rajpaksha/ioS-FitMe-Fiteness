//
//  ProfileViewModel.swift
//  FitMe
//
//  Created by Gairuka Bandara on 2024-11-11.
//

import Foundation
import SwiftUI
import FirebaseFirestore

class ProfileViewModel: ObservableObject {
    @Published var isEditingName = false
    @Published var currentName = ""
    @Published var profileName:  String? = UserDefaults.standard.string(forKey: "profileName")
    
    @Published var isEditingImage = false
    @Published var profileImage:  String? = UserDefaults.standard.string(forKey: "profileImage")
    @Published var selectedImage: String? = UserDefaults.standard.string(forKey: "profileImage")

    var images = ["man","man-2","man-3","man-4","man-5","woman","woman-2","woman-3","woman-4","woman-5","woman-6","woman-7"]
    
    func prensntEditName() {
        isEditingName = true
        isEditingImage = false

    }
    
    func presentEditImage() {
        isEditingName = false
        isEditingImage = true
    }
    
    func dismissEdit() {
        isEditingName = false
        isEditingImage = false
    }
    
    func setNewName() {
        profileName = currentName
            UserDefaults.standard.set(currentName, forKey: "profileName")
        self.dismissEdit()
    }
    
    func selectedImage(image: String) {
        
    }
    
    func didSelectNewImage(name: String) {
        selectedImage = name
    }
    
    func setNewImage() {
        profileImage = selectedImage
        UserDefaults.standard.set(selectedImage, forKey: "profileImage")
        self.dismissEdit()
    }
    
    func presentEmailApp() {
        let emailSubject = "FitMe App - Contact Us"
        let emailRecipient = "fitmeofficial@gmail.com"
        
        let encodedSubject = emailSubject.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let encodedRecipient = emailRecipient.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        let urlString = "mailto:\(encodedRecipient)?subject=\(encodedSubject)"
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        } else {
            return
        }
    }
}
