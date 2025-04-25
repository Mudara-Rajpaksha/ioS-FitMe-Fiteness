//
//  ContentView.swift
//  Health-Tracker
//
//  Created by Gairuka Bandara on 2024-10-22.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("isUserLoggedIn") private var isUserLoggedIn: Bool = false
    
    var body: some View {
        if isUserLoggedIn {
                    TabBarView() // Show HomeView after successful login
                } else {
                    SignInView() // Show SignInView if not logged in
                }
//        VStack {
//            Image(systemName: "globe")
//                .imageScale(.large)
//                .foregroundStyle(.tint)
//            Text("Hello, world!")
//        }
//        .padding()
    }
}

#Preview {
    ContentView()
}
