import SwiftUI

struct SettingsView: View {
    @State private var stepGoal: String = UserDefaults.standard.string(forKey: "stepGoal") ?? "10000"
    @State private var calorieGoal: String = UserDefaults.standard.string(forKey: "calorieGoal") ?? "500"
    @State private var runningGoal: String = UserDefaults.standard.string(forKey: "runningGoal") ?? "5"
    
    @AppStorage("isUserLoggedIn") private var isUserLoggedIn: Bool = true

    var body: some View {
        NavigationView {
            Form {
                Text("Settings")
                
                Section(header: Text("Set Your Goals")) {
                    HStack {
                        Image(systemName: "figure.walk")
                        Text("Steps Goal")
                        TextField("Steps Goal", text: $stepGoal)
                            .multilineTextAlignment(.trailing)
                            .keyboardType(.numberPad)
                    }
                    
                    HStack {
                        Image(systemName: "flame.fill")
                        Text("Calories Goal")
                        TextField("Calories Goal", text: $calorieGoal)
                            .multilineTextAlignment(.trailing)
                            .keyboardType(.numberPad)
                    }
                    
                    HStack {
                        Image(systemName: "figure.run")
                        Text("Running Goal (km)")
                        TextField("Running Goal", text: $runningGoal)
                            .multilineTextAlignment(.trailing)
                            .keyboardType(.numberPad)
                    }
                }
                
                Section {
                    Button(action: saveGoals) {
                        Text("Save Goals")
                            .foregroundColor(.blue)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue.opacity(0.1))
                            .cornerRadius(8)
                    }
                }
                
                // Logout Button Section
                Section {
                    Button(action: logout) {
                        Text("Logout")
                            .foregroundColor(.red)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red.opacity(0.1))
                            .cornerRadius(8)
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }

    // Save Goals function
    private func saveGoals() {
        UserDefaults.standard.set(stepGoal, forKey: "stepGoal")
        UserDefaults.standard.set(calorieGoal, forKey: "calorieGoal")
        UserDefaults.standard.set(runningGoal, forKey: "runningGoal")
        print("Goals saved: Steps: \(stepGoal), Calories: \(calorieGoal), Running: \(runningGoal)")

        // Dismiss the keyboard
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }

    // Logout function
    private func logout() {
        isUserLoggedIn = false // This will show SignInView on logout
        print("User logged out")
    }
}

#Preview {
    SettingsView()
}
