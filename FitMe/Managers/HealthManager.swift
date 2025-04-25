//
//  HealthManager.swift
//  FitMe
//
//  Created by Gairuka Bandara on 2024-11-06.
//

import Foundation
import HealthKit

extension Date {
    static var startOFDay: Date {
        let calendar = Calendar.current
        return calendar.startOfDay(for: Date())
    }
    static var startOFWeek: Date {
        let calendar = Calendar.current
        var components = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date())
        components.weekday = 2
        return calendar.date(from: components) ?? Date()
    }
    
    func fetchMonthStartAndEndDate() -> (Date, Date){
        let calendar = Calendar.current
        let startDateComponent = calendar.dateComponents([.year, .month], from: calendar.startOfDay(for: self))
        let startDate = calendar.date(from: startDateComponent) ?? self
        let endDate = calendar.date(byAdding: DateComponents(month: 1, day: -1), to: startDate) ?? self
        
        return (startDate, endDate)
    }
    
    func formatWorkoutDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM dd"
        return formatter.string(from: self)
    }
}

extension Double {
    func formattedNumberString() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        
        return formatter.string(from: NSNumber(value: self)) ?? "0"
    }
}

class HealthManager{
    
    static let shared = HealthManager()
    let healthStore = HKHealthStore()
    
    private init(){
        Task{
            do{
                try await requestHealthAccess()
            } catch{
                print(error.localizedDescription)
            }
        }
    }
    func requestHealthAccess() async throws {
        let calories = HKQuantityType(.activeEnergyBurned)
        let exercise = HKQuantityType(.appleExerciseTime)
        let stand = HKCategoryType(.appleStandHour)
        let steps = HKQuantityType(.stepCount)
        let workouts = HKSampleType.workoutType()
        
        let healthTypes: Set = [calories, exercise, stand, steps, workouts]
        try await healthStore.requestAuthorization(toShare: [], read: healthTypes)
    }
    
    
    func fetchTodayCaloriesBurned(completion: @escaping (Result<Double, Error>) -> Void) {
        let calories = HKQuantityType(.activeEnergyBurned)
        let predicate = HKQuery.predicateForSamples(withStart: .startOFDay, end: Date())
        let query = HKStatisticsQuery(quantityType: calories, quantitySamplePredicate: predicate) { _, results, error in
            guard let quantity = results?.sumQuantity(), error == nil else {
            completion(.failure(URLError(.badURL)))
            return
        }
            let calorieCount = quantity.doubleValue(for: .kilocalorie())
            completion(.success(calorieCount))
        }
        healthStore.execute(query)
    }
    
    func fetchTodayExerciseTime(completion: @escaping (Result<Double, Error>) -> Void) {
        let exercise = HKQuantityType(.appleExerciseTime)
        let predicate = HKQuery.predicateForSamples(withStart: .startOFDay, end: Date())
        let query = HKStatisticsQuery(quantityType: exercise, quantitySamplePredicate: predicate) { _, results, error in
            guard let quantity = results?.sumQuantity(), error == nil else {
            completion(.failure(URLError(.badURL)))
            return
        }
            let exerciseTime = quantity.doubleValue(for: .minute())
            completion(.success(exerciseTime))
        }
        healthStore.execute(query)
    }
    
    func fetchTodayStandHours(completion: @escaping (Result<Int, Error>) -> Void) {
        let stand = HKCategoryType(.appleStandHour)
        let predicate = HKQuery.predicateForSamples(withStart: .startOFDay, end: Date())
        let query = HKSampleQuery(sampleType: stand, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { _, results, error in
            guard let samples = results as? [HKCategorySample], error == nil else {
            completion(.failure(URLError(.badURL)))
            return
        }
            print(samples)
            print(samples.map({ $0.value}))
            let standCount = samples.filter({ $0.value == 0 }).count
            completion(.success(standCount))
        }
        healthStore.execute(query)
        
    }
    
    //Fitness Activity
    func fetchTodaySteps(completion: @escaping (Result<Activity, Error>) -> Void){
        let steps = HKQuantityType(.stepCount)
        let predicate = HKQuery.predicateForSamples(withStart: .startOFDay, end: Date())
        let query = HKStatisticsQuery(quantityType: steps, quantitySamplePredicate: predicate) { _, results, error in
            guard let quantity = results?.sumQuantity(), error == nil else {
            completion(.failure(URLError(.badURL)))
            return
        }
            let steps = quantity.doubleValue(for: .count())
            let activity = Activity(title: "Today Steps", subtitle: "Goal: 800", image: "figure.walk", tinColor: .green, amount: steps.formattedNumberString())
            completion(.success(activity))
        }
        healthStore.execute(query)
    }
    func fetchCurrentWeekWorkoutStats(completion: @escaping (Result<[Activity], Error>) -> Void){
        let workouts = HKSampleType.workoutType()
        let predicate = HKQuery.predicateForSamples(withStart: .startOFWeek, end: Date())
        let query = HKSampleQuery(sampleType: workouts, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { [weak self] _,results, error in
            guard let workouts = results as? [HKWorkout], let self = self, error == nil else {
                completion(.failure(URLError(.badURL)))
                return
            }
            var runningCount: Int = 0
            var strengthCount: Int = 0
            var soccerCount: Int = 0
            var basketballCount: Int = 0
            var stairsCount: Int = 0
            var kickboxingCount: Int = 0
            
            for workout in workouts {
                let duration = Int(workout.duration)/60
                if workout.workoutActivityType == .running {
                    runningCount += duration
                } else if workout.workoutActivityType == .traditionalStrengthTraining {
                    strengthCount += duration
                } else if workout.workoutActivityType == .soccer {
                    soccerCount += duration
                } else if workout.workoutActivityType == .basketball {
                    basketballCount += duration
                } else if workout.workoutActivityType == .stairClimbing {
                    stairsCount += duration
                } else if workout.workoutActivityType == .kickboxing {
                    kickboxingCount += duration
                }
            }
            completion(.success(generateActivitiesFromDurations(running: runningCount, strength: strengthCount, soccer: soccerCount, basketball: basketballCount, stairs: stairsCount, kickboxing: kickboxingCount)))
        }
        healthStore.execute(query)
    }
    
    func generateActivitiesFromDurations(running: Int, strength: Int, soccer: Int, basketball: Int, stairs: Int, kickboxing: Int) -> [Activity] {
        return [
            Activity(title: "Running", subtitle: "This week", image: "figure.run", tinColor: .green, amount: "\(running) mins"),
            Activity(title: "Strength Training", subtitle: "This week", image: "dumbbell", tinColor: .green, amount: "\(strength) mins"),
            Activity(title: "Soccer", subtitle: "This week", image: "figure.soccer", tinColor: .green, amount: "\(soccer) mins"),
            Activity(title: "Basketball", subtitle: "This week", image: "figure.basketball", tinColor: .green, amount: "\(basketball) mins"),
            Activity(title: "Stairstepper", subtitle: "This week", image: "figure.stairs", tinColor: .green, amount: "\(stairs) mins"),
            Activity(title: "Kickboxking", subtitle: "This week", image: "figure.kickboxing", tinColor: .green, amount: "\(kickboxing) mins"),
        ]
    }
    
    // Recent Workouts
    func fetchWorkoutForMonth(month: Date, completion: @escaping (Result<[Workout], Error>) -> Void) {
        let workouts = HKSampleType.workoutType()
        let (startDate, endDate) = month.fetchMonthStartAndEndDate()
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate)
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)
        let query = HKSampleQuery(sampleType: workouts, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: [sortDescriptor]) { _, results, error in
            guard let workouts = results as? [HKWorkout], error == nil else {
                completion(.failure(URLError(.badURL)))
                return
            }
            
            
//            let workoutsArray = workouts.map( {Workout(id: nil, title: $0.workoutActivityType.name, image: $0.workoutActivityType.image, tinColor: $0.workoutActivityType.color, duration: "\(Int($0.duration)/60) mins", date: $0.startDate.formatWorkoutDate(), calories: ($0.allStatistics.doubleValue(for: .kilocalorie()).formattedNumberString() ?? "-") + "kcal")})
//            completion(.success(workoutsArray))
            
            let workoutsArray = workouts.map { workout in
                // Get the calories burned from the workout's statistics
                let calories = workout.allStatistics[HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned)!]?
                    .sumQuantity()?
                    .doubleValue(for: HKUnit.kilocalorie()) ?? 0.0
                
                return Workout(
                    id: nil,
                    title: workout.workoutActivityType.name,
                    image: workout.workoutActivityType.image,
                    tinColor: workout.workoutActivityType.color,
                    duration: "\(Int(workout.duration) / 60) mins",
                    date: workout.startDate.formatWorkoutDate(),
                    calories: "\(calories.formattedNumberString()) kcal"
                )
            }
            completion(.success(workoutsArray))

        }
        healthStore.execute(query)
    }
    
    func checkGoalsAndNotify() {
        let stepGoal = Double(UserDefaults.standard.string(forKey: "stepGoal") ?? "10000") ?? 10000
        let calorieGoal = Double(UserDefaults.standard.string(forKey: "calorieGoal") ?? "500") ?? 500

        fetchTodaySteps { result in
            switch result {
            case .success(let activity):
                let steps = Double(activity.amount) ?? 0
                scheduleNotification(forGoal: "Step", current: steps, goal: stepGoal)
            case .failure(let error):
                print("Error fetching steps: \(error.localizedDescription)")
            }
        }

        fetchTodayCaloriesBurned { result in
            switch result {
            case .success(let calories):
                scheduleNotification(forGoal: "Calorie", current: calories, goal: calorieGoal)
            case .failure(let error):
                print("Error fetching calories: \(error.localizedDescription)")
            }
        }
    }
    
}

//ChartView Data

extension HealthManager {
    
    struct YearChartDataResult {
        let ytd: [MonthlyStepModel]
        let oneYear: [MonthlyStepModel]
    }
    
    func fetchYTDAndOneYearData(completion: @escaping (Result<YearChartDataResult, Error>) -> Void) {
        let steps = HKQuantityType(.stepCount)
        let calendar = Calendar.current
        
        var oneYearMonaths = [MonthlyStepModel]()
        var ytdMonths = [MonthlyStepModel]()
        
        for i in 0...11 {
            let month = calendar.date(byAdding: .month, value: -i, to: Date()) ?? Date()
            
            let (startOfMonth, endOfMonth) = month.fetchMonthStartAndEndDate()
            let predicate = HKQuery.predicateForSamples(withStart: .startOFDay, end: Date())
            let query = HKStatisticsQuery(quantityType: steps, quantitySamplePredicate: predicate) { _, results,
                error in
                guard let steps = results?.sumQuantity()?.doubleValue(for: .count()), error == nil else {
                completion(.failure(URLError(.badURL)))
                return
            }
                if i == 0 {
                    oneYearMonaths.append(MonthlyStepModel(date: month, count: Int(steps)))
                    ytdMonths.append(MonthlyStepModel(date: month, count: Int(steps)))
                } else {
                    oneYearMonaths.append(MonthlyStepModel(date: month, count: Int(steps)))
                    if calendar.component(.year, from: Date()) == calendar.component(.year, from: month) {
                        ytdMonths.append(MonthlyStepModel(date: month, count: Int(steps)))
                    }
                }
                if i == 11 {
                    completion(.success(YearChartDataResult(ytd: ytdMonths, oneYear: oneYearMonaths)))
                }
            }
            healthStore.execute(query)
        }
    }

}
