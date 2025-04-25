import Foundation
import HealthKit
import UserNotifications // Import UserNotifications

extension Date {
    static var start: Date {
        Calendar.current.startOfDay(for: Date()) // Start of the day
    }
}

extension Double {
    // Format double with commas and no decimal places
    func formatDouble() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal  // Use decimal style to get commas
        formatter.maximumFractionDigits = 0  // No decimal places
        formatter.minimumFractionDigits = 0
        
        return formatter.string(from: NSNumber(value: self)) ?? "\(self)"  // Fallback in case of error
    }
}

class Health: ObservableObject {
    let HStore = HKHealthStore()
    
    @Published var actions: [String: Action] = [:]
    init() {
        let stepCount = HKQuantityType.quantityType(forIdentifier: .stepCount)!
        let activeEnergy = HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned)!
        let HTypes: Set = [stepCount, activeEnergy]
        
        Task {
            do {
                try await HStore.requestAuthorization(toShare: [], read: HTypes)
            } catch {
                print("ERROR: Unable to fetch HealthKit Authorization")
            }
        }
    }
//    init() {
//        // Request authorization for notifications
//        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
//            if let error = error {
//                print("Notification permission error: \(error.localizedDescription)")
//            } else if !granted {
//                print("Notification permission not granted.")
//            }
//        }
//        
//        // HealthKit types
//        guard let stepCount = HKQuantityType.quantityType(forIdentifier: .stepCount),
//              let activeEnergy = HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned) else {
//            print("Error: Unable to create HealthKit types.")
//            return
//        }
//        
//        let HTypes: Set = [stepCount, activeEnergy]
//        
//        Task {
//            do {
//                try await HStore.requestAuthorization(toShare: [], read: HTypes)
//            } catch {
//                print("ERROR: Unable to fetch HealthKit Authorization: \(error.localizedDescription)")
//            }
//        }
//    }
    
    // Function to get the step count
    func getSteps() {
        guard let stepCount = HKQuantityType.quantityType(forIdentifier: .stepCount) else {
            print("Error: Unable to create stepCount type")
            return
        }
        let period = HKQuery.predicateForSamples(withStart: .start, end: Date(), options: .strictStartDate)
        
        let query = HKStatisticsQuery(quantityType: stepCount, quantitySamplePredicate: period, options: .cumulativeSum) { _, result, error in
            var steps: Double = 0
            
            if let result = result, let sum = result.sumQuantity() {
                steps = sum.doubleValue(for: HKUnit.count())  // Get step count
            } else if let error = error {
                print("Error fetching steps: \(error.localizedDescription)")
            }
            
            // Fetch the user's goal from UserDefaults
            let stepGoal = UserDefaults.standard.double(forKey: "stepGoal")  // Fetching as Double
            let action = Action(heading: "Steps", subHeading: "Today", icon: "figure.walk", value: steps.formatDouble(), goal: "Goal \(stepGoal.formatDouble())")
            DispatchQueue.main.async {
                self.actions["steps"] = action
                self.scheduleNotificationIfGoalNotMet(stepCount: steps, goal: stepGoal) // Schedule notification
            }
            
            print(steps.formatDouble())
        }
        
        HStore.execute(query)
    }
    
    private func scheduleNotificationIfGoalNotMet(stepCount: Double, goal: Double) {
        if stepCount < goal {
            let content = UNMutableNotificationContent()
            content.title = "Step Goal Not Reached"
            content.body = "You have only walked \(stepCount.formatDouble()) steps today. Keep moving to reach your goal of \(goal.formatDouble()) steps!"
            content.sound = .default

            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: false) // Notify after 1 minute
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

            UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                    print("Error adding notification: \(error.localizedDescription)")
                }
            }
        }
    }
    
    // Function to get calories burned (active energy)
    func getCalories() {
        guard let activeEnergy = HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned) else {
            print("Error: Unable to create activeEnergy type")
            return
        }
        let period = HKQuery.predicateForSamples(withStart: .start, end: Date(), options: .strictStartDate)
        
        let query = HKStatisticsQuery(quantityType: activeEnergy, quantitySamplePredicate: period, options: .cumulativeSum) { _, result, error in
            var calories: Double = 0
            
            if let result = result, let sum = result.sumQuantity() {
                calories = sum.doubleValue(for: HKUnit.kilocalorie())  // Get calories in kilocalories
            } else if let error = error {
                print("Error fetching calories: \(error.localizedDescription)")
            }
            
            // Fetch the user's goal from UserDefaults
            let calorieGoal = UserDefaults.standard.double(forKey: "calorieGoal") // Fetching as Double
            let action = Action(heading: "Calories", subHeading: "Today", icon: "flame.fill", value: calories.formatDouble(), goal: "Goal \(calorieGoal.formatDouble())")
            DispatchQueue.main.async {
                self.actions["calories"] = action
            }
            
            print(calories.formatDouble())
        }
        
        HStore.execute(query)
    }
    
    // Function to get running distance
    func getRunningDistance() {
        guard let runningDistance = HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning) else {
            print("Error: Unable to create runningDistance type")
            return
        }
        let period = HKQuery.predicateForSamples(withStart: .start, end: Date(), options: .strictStartDate)
        
        let query = HKStatisticsQuery(quantityType: runningDistance, quantitySamplePredicate: period, options: .cumulativeSum) { _, result, error in
            var distance: Double = 0
            
            if let result = result, let sum = result.sumQuantity() {
                distance = sum.doubleValue(for: HKUnit.meter())  // Get distance in meters
            } else if let error = error {
                print("Error fetching running distance: \(error.localizedDescription)")
            }
            
            // Fetch the user's goal from UserDefaults
            let runningGoal = UserDefaults.standard.double(forKey: "runningGoal") // Fetching as Double
            let action = Action(heading: "Running", subHeading: "Today", icon: "figure.run", value: distance.formatDouble(), goal: "Goal \(runningGoal.formatDouble()) km")
            DispatchQueue.main.async {
                self.actions["running"] = action
            }
            
            print(distance.formatDouble())
        }
        
        HStore.execute(query)
    }
}
