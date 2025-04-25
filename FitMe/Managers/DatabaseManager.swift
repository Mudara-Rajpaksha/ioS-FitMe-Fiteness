//
//  DatabaseManager.swift
//  FitMe
//
//  Created by Gairuka Bandara on 2024-11-11.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseAuth

struct DatabaseManager: App {
    
    init () {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
