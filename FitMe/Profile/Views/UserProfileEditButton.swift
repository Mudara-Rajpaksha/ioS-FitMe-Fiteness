//
//  UserProfileEditButton.swift
//  FitMe
//
//  Created by Gairuka Bandara on 2024-11-11.
//

import SwiftUI

struct UserProfileEditButton: View {
    @State var title: String
    @State var backgroundColor: Color
    var action: (() -> Void)
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(title)
                .padding()
                .frame(maxWidth: 200)
                .foregroundColor(.blue)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(backgroundColor)
                )
        }
    }
}

#Preview {
    UserProfileEditButton(title: "", backgroundColor: .red) {}
}
