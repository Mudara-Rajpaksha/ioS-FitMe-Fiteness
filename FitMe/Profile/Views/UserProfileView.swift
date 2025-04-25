//
//  ProfileView.swift
//  FitMe
//
//  Created by Gairuka Bandara on 2024-11-11.
//

import SwiftUI

struct UserProfileView: View {
    

    @StateObject var viewModel = ProfileViewModel()
    
    var body: some View {
        VStack{
            HStack(spacing: 16){
                Image(viewModel.profileImage ?? "man")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .padding(.all, 8)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(.gray.opacity(0.25))
                    )
                    .onTapGesture {
                        withAnimation {
                            viewModel.presentEditImage()
                        }
                    }
                
                VStack(alignment: .leading) {
                    Text("Good morning")
                        .font(.largeTitle)
                        .foregroundColor(.gray)
                        .minimumScaleFactor(0.5)
                    Text(viewModel.profileName ?? "Name")
                        .font(.title)
                }
            }
            
            if viewModel.isEditingName {
                TextField("Name...", text: $viewModel.currentName)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke()
                    )
                HStack {
                    UserProfileEditButton(title: "Cancel", backgroundColor: .gray.opacity(0.1)) {
                        withAnimation {
                            viewModel.dismissEdit()
                        }
                    }
                    .foregroundColor(.red)
                    
                    UserProfileEditButton(title: "Done", backgroundColor: .primary) {
                        if !viewModel.currentName.isEmpty {
                            viewModel.setNewName()
                        }
                    }
                    .foregroundColor(.white)
//                    Button {
//                        isEditingName = false
//                    } label: {
//                        Text("Cancel")
//                            .padding()
//                            .frame(maxWidth: 200)
//                            .foregroundColor(.red)
//                            .background(
//                                RoundedRectangle(cornerRadius: 10)
//                                    .fill(.gray.opacity(0.1))
//                            )
//                    }
//                    Button {
//                        
//                    } label: {
//                        Text("Done")
//                            .padding()
//                            .frame(maxWidth: 200)
//                            .foregroundColor(.white)
//                            .background(
//                                RoundedRectangle(cornerRadius: 10)
//                                    .fill(.black)
//                            )
//                    }
                }
            }
            
            if viewModel.isEditingImage {
                ScrollView(.horizontal){
                    HStack{
                        ForEach(viewModel.images, id: \.self) { image in
                            Button {
                                withAnimation{
                                    viewModel.didSelectNewImage(name: image)
                                }
                            } label: {
                                VStack{
                                    Image(image)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 100, height: 100)
                                        
                                    if viewModel.selectedImage == image {
                                        Circle()
                                            .frame(width: 16, height: 16)
                                            .foregroundColor(.primary)
                                    }
                                }
                                .padding()
                            }
                        }
                    }
                }
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.gray.opacity(0.15))
                )
                UserProfileEditButton(title: "Done", backgroundColor: .primary) {
                        withAnimation {
                            viewModel.setNewImage()
                        }
                }
                .foregroundColor(.white)
                .padding(.bottom)
            }
            
            VStack{
                FitMeProfileButton(title: "Edit Name", image: "square.and.pencil"){
                    withAnimation {
                        viewModel.prensntEditName()
                    }
                }
                FitMeProfileButton(title: "Edit Image", image: "square.and.pencil"){
                    withAnimation {
                        viewModel.presentEditImage()
                    }
                }
                
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.gray.opacity(0.15))
                )
                
                VStack{
                    FitMeProfileButton(title: "Contact Us", image: "envelope"){
                        viewModel.presentEmailApp()
                    }
                    
//                    FitMeProfileButton(title: "Privacy Policy", image: "document"){
//                        print("privacy")
//                    }
//                    FitMeProfileButton(title: "Terms of Services", image: "document.badge.arrow.up"){
//                        print("terms")
//                    }
                    
                    Link(destination: URL(string: "https://github.com/DakshinaInduwara/FitMe_iOS-App/blob/main/Privacy.md")!) {
                        HStack{
                            Image(systemName: "doc")
                            Text("Privacy Policy")
                        }
                        .foregroundColor(.primary)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
                    Link(destination: URL(string: "https://github.com/DakshinaInduwara/FitMe_iOS-App/blob/main/Terms.md")!) {
                        HStack{
                            Image(systemName: "doc")
                            Text("Terms & Conditions")
                        }
                        .foregroundColor(.primary)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
            }
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(.gray.opacity(0.15))
            )
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
//        .onAppear {
//            selectedImage = profileImage
//        }
    }
}

#Preview {
    UserProfileView()
}
