import SwiftUI


struct HomeView: View {
    @StateObject var viewModel = HomeViewModel()
    @EnvironmentObject var healthKit: Health
    @AppStorage("isUserLoggedIn") private var isUserLoggedIn: Bool = false
    
    
    var body: some View {
        VStack(spacing: 20) {
            NavigationStack {
                ScrollView(showsIndicators: false){
                    VStack(alignment: .leading) {
                        HStack {
                        Text("Home")
                            .font(.largeTitle)
                            .padding()
                            .bold()
                            
                        Spacer()
                            
                            NavigationLink(destination: LocationTrackerView()) {
                                Image(systemName: "map.fill")
                                    .foregroundColor(Color.black.opacity(0.7))
                                    .font(.system(size: 24))
                                    
                            }
                        }
                        .padding(.horizontal)
                        HStack {
                            Spacer()
                            
                            VStack {
                                VStack(alignment: .leading, spacing: 8){
                                    Text("Calories")
                                        .font(.callout)
                                        .bold()
                                        .foregroundColor(.red)
                                    
                                    Text("\(viewModel.calories)")
                                        .bold()
                                }
                                .padding(.bottom)
                                VStack(alignment: .leading, spacing: 8){
                                    Text("Active")
                                        .font(.callout)
                                        .bold()
                                        .foregroundColor(.green)
                                    
                                    Text("\(viewModel.exercise)")
                                        .bold()
                                }
                                .padding(.bottom)
                                VStack(alignment: .leading, spacing: 8){
                                    Text("Stand")
                                        .font(.callout)
                                        .bold()
                                        .foregroundColor(.blue)
                                    
                                    Text("\(viewModel.stand)")
                                        .bold()
                                }
                            }
                            Spacer()
                            
                            ZStack {
                                ProgressCircleView(progress: $viewModel.calories, goal: 600, color: .red)
                                ProgressCircleView(progress: $viewModel.exercise, goal: 60, color: .green)
                                    .padding(.all, 20)
                                ProgressCircleView(progress: $viewModel.stand, goal: 12, color: .blue)
                                    .padding(.all, 40)
                            }
                            .padding(.horizontal)
                            Spacer()
                        }
                        .padding(.horizontal)
                        
                        HStack {
                            Text("Fitness Activity")
                                .font(.title2)
                            Spacer()
                            //                        Button {
                            //                            print("show more")
                            //                        } label: {
                            //                            Text("Show more")
                            //                                .padding(.all, 10)
                            //                                .foregroundColor(.white)
                            //                                .background(Color.blue)
                            //                                .cornerRadius(20)
                            //                        }
                        }
                        .padding(.horizontal)
                        
                        if !viewModel.activities.isEmpty {
                            LazyVGrid(columns: Array(repeating: GridItem(spacing: 20), count: 2)) {
                                ForEach(viewModel.activities, id: \.title) { activity in
                                    ActivityCard(activity: activity)
                                }
                            }
                            VStack(alignment: .leading) {
                                HStack {
                                    Text("Recent Workouts")
                                        .font(.title2)
                                    Spacer()
                                    
                                    NavigationLink {
                                        WorkoutsView()
                                    } label: {
                                        Text("Show more")
                                            .padding(.all, 10)
                                            .foregroundColor(.white)
                                            .background(Color.blue)
                                            .cornerRadius(20)
                                    }
                                }
                                .padding(.horizontal)
                                .padding(.top)
                                //ScrollView(showsIndicators: false){
                                LazyVStack {
                                    ForEach(viewModel.workouts, id: \.id) { workout in
                                        WorkoutCard(workout: workout)
                                    }
                                }
                            }
                        }
                        //                    LazyVGrid(columns: Array(repeating: GridItem(spacing: 20), count: 2)){
                        //                        ForEach(viewModel.mockActivites, id: \.id) { activity in
                        //                            ActivityCard(activity: activity)
                    }
                }
                .padding(.horizontal)
            }
        }
    }
    
    
    //        VStack {
    //            Text("Home").font(.title).padding()
    //            LazyVGrid(columns: Array(repeating: GridItem(spacing: 5), count: 1)) {
    //                // Display step count
    //                if let stepAction = healthKit.actions["steps"] {
    //                    ActionCard(action: stepAction)
    //                }
    //
    //                // Display calorie count
    //                if let calorieAction = healthKit.actions["calories"] {
    //                    ActionCard(action: calorieAction)
    //                }
    //
    //                // Display running distance
    //                if let runningAction = healthKit.actions["running"] {
    //                    ActionCard(action: runningAction)
    //                }
    //            }
    //            .padding()
    //        }
    //        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    //        .onAppear {
    //            // Fetch health data when the view appears
    //            healthKit.getSteps()
    //            healthKit.getCalories()
    //            healthKit.getRunningDistance()
    //        }
    
    }
    
    #Preview {
        HomeView()
            .environmentObject(Health())  // Injecting Health object into the preview
    }

