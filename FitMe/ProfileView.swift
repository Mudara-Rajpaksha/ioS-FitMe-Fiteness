import SwiftUI

struct ProfileView: View {
    @State private var username: String = UserDefaults.standard.string(forKey: "username") ?? ""
    @State private var age: String = UserDefaults.standard.string(forKey: "age") ?? ""
    @State private var weight: String = UserDefaults.standard.string(forKey: "weight") ?? "" + " Kg"
    @State private var height: String = UserDefaults.standard.string(forKey: "height") ?? " " + " Cm"
    
    var body: some View {
        NavigationView {
            VStack {
                // Profile Picture
                VStack {
                    Image("profile_picture") // Replace with your profile image asset
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.blue, lineWidth: 4))
                        .shadow(radius: 10)
                    
                    Text(username)
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.top, 8)
                }
                
                // User Information
                Form {
                    Section(header: Text("User Information")) {
                        HStack {
                            Image(systemName: "person.fill")
                            Text("Name")
                            TextField("Name", text: $username)
                                .multilineTextAlignment(.trailing)
                        }
                        HStack {
                            Image(systemName: "calendar")
                            Text("Age")
                            TextField("Age", text: $age)
                                .multilineTextAlignment(.trailing)
                                .keyboardType(.numberPad)
                        }
                        HStack {
                            Image(systemName: "scalemass")
                            Text("Weight")
                            TextField("Weight", text: $weight)
                                .multilineTextAlignment(.trailing)
                        }
                        HStack {
                            Image(systemName: "ruler")
                            Text("Height")
                            TextField("Height", text: $height)
                                .multilineTextAlignment(.trailing)
                        }
                        
                        Button(action: saveProfile) {
                            Text("Save Changes")
                                .foregroundColor(.blue)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue.opacity(0.1))
                                .cornerRadius(8)
                        }
                    }
                    
                }
            }
            .navigationTitle("Profile")
            .padding()
        }
    }
    
    // Function to save user profile details and dismiss keyboard
    private func saveProfile() {
        // Save data to UserDefaults
        UserDefaults.standard.set(username, forKey: "username")
        UserDefaults.standard.set(age, forKey: "age")
        UserDefaults.standard.set(weight, forKey: "weight")
        UserDefaults.standard.set(height, forKey: "height")
        
        // Dismiss the keyboard
        dismissKeyboard()
        
        print("Profile saved: Name - \(username), Age - \(age), Weight - \(weight), Height - \(height)")
    }
    
    // Function to dismiss the keyboard
    private func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

#Preview {
    ProfileView()
}
