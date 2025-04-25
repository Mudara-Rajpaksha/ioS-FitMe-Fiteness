import SwiftUI

struct SignUpView: View {
    @StateObject private var signupVM = SignInViewModel()

    @AppStorage("isUserLoggedIn") private var isUserLoggedIn: Bool = false

    var body: some View {
        VStack(spacing: 20) {
            Text("FitMe Fiteness")
                .font(.largeTitle)
                .bold()
                .italic()
                .foregroundColor(.blue)
            Text("Sign Up")
                .font(.largeTitle)
                .bold()
            
            TextField("Email", text: $signupVM.email)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
            
            SecureField("Password", text: $signupVM.password)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
            
            SecureField("Confirm Password", text: $signupVM.re_Enter_password)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)

            if !signupVM.showErrorMessage.isEmpty {
                Text(signupVM.showErrorMessage)
                    .foregroundColor(.red)
            }

            Button(action: {
                Task {
                    signupVM.verify()
                    signupVM.registerUser = true
                }
            }) {
                Text("Sign Up")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
        }
        .padding()
    }
}
