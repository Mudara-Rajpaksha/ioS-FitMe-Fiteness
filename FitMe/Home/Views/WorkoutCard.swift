//
//  WorkoutCard.swift
//  FitMe
//
//  Created by Gairuka Bandara on 2024-11-05.
//

import SwiftUI


struct WorkoutCard: View {
    @State var workout: Workout
    var body: some View {
        HStack {
            Image(systemName: workout.image)
                .resizable()
                .scaledToFit()
                .frame(width: 48, height: 48)
                .foregroundColor(workout.tinColor)
                .padding()
                .background(.gray.opacity(0.3))
                .cornerRadius(10)
            
            VStack (spacing: 16){
                HStack {
                    Text(workout.title)
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                        .font(.title3)
                        .bold()
                    Spacer()
                    Text(workout.duration)
                }
                HStack {
                    Text(workout.date)
                    Spacer()
                    Text(workout.calories)
                }
                
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    WorkoutCard(workout: Workout(id: 0, title: "Running", image: "figure.run", tinColor: .cyan, duration: "20 mins", date: "Nov 5", calories: "300 kcal"))
}
