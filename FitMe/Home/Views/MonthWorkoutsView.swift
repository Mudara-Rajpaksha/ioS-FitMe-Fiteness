//
//  MonthWorkoutsView.swift
//  FitMe
//
//  Created by Gairuka Bandara on 2024-11-12.
//

import SwiftUI

class MonthWorkoutsViewModel: ObservableObject {
    @Published var workouts = [Workout]()
    @Published var currentMonthWorkouts = [Workout]()
}

struct MonthWorkoutsView: View {
    @StateObject var viewModel = MonthWorkoutsViewModel()
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    
                } label: {
                    Image(systemName: "arrowshape.left.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 32, height: 32)
                }
                
                Spacer()

                Text("November 2024")
                    .font(.title)
                
                Spacer()
                
                Button {
                    
                } label: {
                    Image(systemName: "arrowshape.right.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 32, height: 32)
                }
                Spacer()
            }
            
            ForEach(viewModel.currentMonthWorkouts, id: \.self) { workout in
                WorkoutCard(workout: workout)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding()
    }
}

#Preview {
    MonthWorkoutsView()
}
