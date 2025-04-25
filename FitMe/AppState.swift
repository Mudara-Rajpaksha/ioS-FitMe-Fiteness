//
//  AppState.swift
//  FitMe
//
//  Created by Gairuka Bandara on 2024-11-12.
//

import SwiftUI
import FirebaseAuth

class AppState: ObservableObject {
    @Published var isUserLoggedIn: Bool = false
    
    init() {
        // Check if there's an authenticated user
        isUserLoggedIn = Auth.auth().currentUser != nil
    }
}
