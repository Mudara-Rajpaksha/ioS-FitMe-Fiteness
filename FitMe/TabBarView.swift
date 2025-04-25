//
//  TabView.swift
//  Health-Tracker
//
//  Created by Gairuka Bandara on 2024-10-24.
//

import SwiftUI

struct TabBarView: View {
    @EnvironmentObject var healthKit: Health
    @State var selectedTab = "Home"
    
    var body: some View {
        TabView(selection: $selectedTab){
            HomeView()
                .tag("Home")
                .tabItem{
                    Image(systemName:"house")
                    Text("Home")
                }
                //.environmentObject(healthKit)
            
            ChartsView()
                .tag("Charts")
                .tabItem{
                    Image(systemName:"chart.line.uptrend.xyaxis")
                    Text("Charts")
                }
            
            UserProfileView()
                .tag("Profile")
                .tabItem{
                    Image(systemName:"person.crop.circle")
                    Text("Profile")
                }
            
            NotificationView()
                .tag("Notification")
                .tabItem{
                    Image(systemName:"bell.badge")
                    Text("Notifications")
                }
            
            LeaderboardView()
                .tag("Leaderboard")
                .tabItem{
                    Image(systemName:"list.bullet")
                    Text("Leaderboard")
                }
            
            SettingsView()
                .tag("Settings")
                .tabItem{
                    Image(systemName:"gear")
                    Text("Settings")
                }
        }
    }
}

#Preview {
    TabBarView()
        .environmentObject(Health())
}

