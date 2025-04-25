//
//  FitMeProfileButton.swift
//  FitMe
//
//  Created by Gairuka Bandara on 2024-11-11.
//

import SwiftUI

struct FitMeProfileButton: View {
    @State var title: String
    var image: String
    var action: (() -> Void)
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack{
                Image(systemName: image)
                Text(title)
            }
            .foregroundColor(.primary)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    FitMeProfileButton(title: "Edit Image", image: "square.and.pencil"){
        
    }
}
