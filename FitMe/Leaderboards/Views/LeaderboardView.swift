//
//  LeaderboardView.swift
//  FitMe
//
//  Created by Gairuka Bandara on 2024-11-08.
//

import SwiftUI

struct LeaderboardUser: Codable, Identifiable {
    let id: Int
    let createdAt: String
    let username: String
    let count: Int
}

class LeaderboardViewModel: ObservableObject {
    
    var mockData = [
        LeaderboardUser(id: 0, createdAt: "", username: "jason", count: 2134),
        LeaderboardUser(id: 1, createdAt: "", username: "san", count: 2134),
        LeaderboardUser(id: 2, createdAt: "", username: "paul", count: 2134),
        LeaderboardUser(id: 3, createdAt: "", username: "yuiahf", count: 2134),
        LeaderboardUser(id: 4, createdAt: "", username: "avajhv", count: 2134),
        LeaderboardUser(id: 5, createdAt: "", username: "avjdsnvk", count: 2134),
        LeaderboardUser(id: 6, createdAt: "", username: "qbeujf", count: 2134),
        LeaderboardUser(id: 7, createdAt: "", username: "akbdsv", count: 2134),
        LeaderboardUser(id: 8, createdAt: "", username: "jason", count: 2134),
    ]
}

struct LeaderboardView: View {
    @StateObject var viewModel = LeaderboardViewModel()
    @AppStorage("username") var username: String?
    @State var showTerms = true
    
    var body: some View {
        VStack{
            Text("Leaderboard")
                .font(.largeTitle)
                .bold()
            
            HStack{
                Text("Name")
                    .bold()
                Spacer()
                Text("Steps")
                    .bold()
            }
            .padding()
            
            LazyVStack(spacing: 16){
                ForEach(viewModel.mockData){ person in
                    HStack{
                        Text("\(person.id).")
                        Text(person.username)
                        Spacer()
                        Text("\(person.count)")
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                }
            }
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .fullScreenCover(isPresented: $showTerms) {
            TermsView()
        }
    }
}

#Preview {
    LeaderboardView()
}
