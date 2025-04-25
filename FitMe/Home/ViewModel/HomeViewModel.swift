//
//  HomeViewModel.swift
//  FitMe
//
//  Created by Gairuka Bandara on 2024-11-06.
//

import Foundation
class HomeViewModel: ObservableObject {
    
    let healthManager = HealthManager.shared
    
    @Published var calories: Int = 0
    @Published var exercise: Int = 0
    @Published var stand: Int = 0
    @Published var activities = [Activity]()
    
    @Published var workouts = [
        Workout(id: 0, title: "Running", image: "figure.run", tinColor: .cyan, duration: "20 mins", date: "Nov 5", calories: "300 kcal"),
        Workout(id: 1, title: "Strength Training", image: "figure.run", tinColor: .red, duration: "30 mins", date: "Nov 2", calories: "240 kcal"),
        Workout(id: 2, title: "Walking", image: "figure.run", tinColor: .blue, duration: "23 mins", date: "Nov 4", calories: "522 kcal"),
        Workout(id: 3, title: "Climbing", image: "figure.run", tinColor: .yellow, duration: "35 mins", date: "Nov 5", calories: "431 kcal")
    ]
    
    var mockActivites = [
        Activity(title: "Daily steps", subtitle: "Goal 12,000", image: "figure.walk", tinColor: .green, amount: "9812"),
        Activity(title: "Daily steps", subtitle: "Goal 12,000", image: "figure.walk", tinColor: .red, amount: "9812"),
        Activity(title: "Daily steps", subtitle: "Goal 12,000", image: "figure.run", tinColor: .blue, amount: "9812"),
        Activity(title: "Daily steps", subtitle: "Goal 12,000", image: "figure.walk", tinColor: .purple, amount: "9812"),
        Activity(title: "Daily steps", subtitle: "Goal 12,000", image: "figure.run", tinColor: .yellow, amount: "9812"),
        Activity(title: "Daily steps", subtitle: "Goal 12,000", image: "figure.run", tinColor: .orange, amount: "9812")
    ]
    
    var mockWorkouts = [
        Workout(id: 0, title: "Running", image: "figure.run", tinColor: .cyan, duration: "20 mins", date: "Nov 5", calories: "300 kcal"),
        Workout(id: 1, title: "Strength Training", image: "figure.run", tinColor: .red, duration: "30 mins", date: "Nov 2", calories: "240 kcal"),
        Workout(id: 2, title: "Walking", image: "figure.run", tinColor: .blue, duration: "23 mins", date: "Nov 4", calories: "522 kcal"),
        Workout(id: 3, title: "Climbing", image: "figure.run", tinColor: .yellow, duration: "35 mins", date: "Nov 5", calories: "431 kcal")
    ]
    
    init(){
        Task {
            do{
                try await healthManager.requestHealthAccess()
                fetchTodayCalories()
                fetchTodayExerciseTime()
                fetchTodayStandHours()
                fetchTodaySteps()
                fetchCurrentWeekActivities()

            } catch{
                print(error.localizedDescription)
            }
        }
        
    }
    
    func fetchTodayCalories(){
        healthManager.fetchTodayCaloriesBurned { result in
            switch result {
            case .success(let calories):
                DispatchQueue.main.async {
                    self.calories = Int(calories)
                    let activity = Activity(title: "Calories Burned", subtitle: "todayflame", image: "flame", tinColor: .red, amount: calories.formattedNumberString())
                    self.activities.append(activity)
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    func fetchTodayExerciseTime(){
        healthManager.fetchTodayExerciseTime{ result in
            switch result {
            case .success(let exercise):
                DispatchQueue.main.async {
                    self.exercise = Int(exercise)
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    func fetchTodayStandHours(){
        healthManager.fetchTodayStandHours { result in
                switch result {
                case .success(let hours):
                    DispatchQueue.main.async {
                        self.stand = hours
                    }
                case .failure(let failure):
                    print(failure.localizedDescription)
            }
        }
    }
    //Fitness Activity
    func fetchTodaySteps(){
        healthManager.fetchTodaySteps { result in
            switch result {
            case .success(let activity):
                DispatchQueue.main.async {
                    self.activities.append(activity)
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    func fetchCurrentWeekActivities(){
        healthManager.fetchCurrentWeekWorkoutStats { result in
            switch result {
            case .success(let activities):
                DispatchQueue.main.async {
                    self.activities.append(contentsOf: activities)
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    // Recent Workouts
    func fetchRecentWorkouts(){
        healthManager.fetchWorkoutForMonth(month: Date()) { result in
            switch result {
            case .success(let workouts):
                DispatchQueue.main.async {
                    self.workouts = Array(workouts.prefix(4))
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
}
