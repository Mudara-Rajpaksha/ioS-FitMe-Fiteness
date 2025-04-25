import SwiftUI

struct SignInView: View {
    @StateObject private var signVM = SignInViewModel()

    @AppStorage("isUserLoggedIn") private var isUserLoggedIn: Bool = false

    var body: some View {
        NavigationView {  // Add NavigationView here
            VStack(spacing: 20) {
                Text("FitMe Fiteness")
                    .font(.largeTitle)
                    .bold()
                    .italic()
                    .foregroundColor(.blue)
                Text("Sign In")
                    .font(.largeTitle)
                    .bold()
                
                TextField("Email", text: $signVM.email)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                
                SecureField("Password", text: $signVM.password)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)

                if !signVM.showErrorMessage.isEmpty {
                    Text(signVM.showErrorMessage)
                        .foregroundColor(.red)
                }


                Button(action: {
                    Task {
                        signVM.verify()
                        signVM.registerUser = false
                    }
                }) {
                    Text("Sign In")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                }


                NavigationLink(destination: SignUpView()) {
                    Text("Don't have an account? Sign Up")
                        .foregroundColor(.blue)
                        .bold()
                }
            }
            .padding()
            .navigationBarHidden(true) // Hide the default navigation bar if needed
        }
    }
}
