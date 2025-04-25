import SwiftUI
import UserNotifications

struct NotificationView: View {
    var body: some View {
        Text("Notificatoin Panel")
            .onAppear {
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                    if granted {
                        print("Notification permission granted")
                    } else if let error = error {
                        print("Error requesting notification permission: \(error.localizedDescription)")
                    }
                }
            }
    }
}

func scheduleNotification(forGoal type: String, current: Double, goal: Double) {
    guard current >= goal else { return }
    
    let content = UNMutableNotificationContent()
    content.title = "\(type) Goal Reached!"
    content.body = "Congratulations! You've reached your \(type.lowercased()) goal of \(goal.formatDouble()) \(type == "Step" ? "steps" : "calories")!"
    content.sound = .default
    
    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: nil)
    UNUserNotificationCenter.current().add(request) { error in
        if let error = error {
            print("Error adding notification: \(error.localizedDescription)")
        }
    }
}
