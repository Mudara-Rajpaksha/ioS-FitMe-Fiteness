//
//  ChartsViewModel.swift
//  FitMe
//
//  Created by Gairuka Bandara on 2024-11-08.
//

import Foundation

class ChartViewModel: ObservableObject {
    var mockWeekChartData = [
        DailyStepModel(date: Date(), count: 12345),
        DailyStepModel(date: Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date(), count: 76524),
        DailyStepModel(date: Calendar.current.date(byAdding: .day, value: -2, to: Date()) ?? Date(), count: 56732),
        DailyStepModel(date: Calendar.current.date(byAdding: .day, value: -3, to: Date()) ?? Date(), count: 20000),
        DailyStepModel(date: Calendar.current.date(byAdding: .day, value: -4, to: Date()) ?? Date(), count: 99975),
        DailyStepModel(date: Calendar.current.date(byAdding: .day, value: -5, to: Date()) ?? Date(), count: 78638),
        DailyStepModel(date: Calendar.current.date(byAdding: .day, value: -6, to: Date()) ?? Date(), count: 45627),
    ]
    
    var mockYTDChartData = [
        MonthlyStepModel(date: Date(), count: 12345),
        MonthlyStepModel(date: Calendar.current.date(byAdding: .month, value: -1, to: Date()) ?? Date(), count: 76524),
        MonthlyStepModel(date: Calendar.current.date(byAdding: .month, value: -2, to: Date()) ?? Date(), count: 56732),
        MonthlyStepModel(date: Calendar.current.date(byAdding: .month, value: -3, to: Date()) ?? Date(), count: 20000),
        MonthlyStepModel(date: Calendar.current.date(byAdding: .month, value: -4, to: Date()) ?? Date(), count: 99975),
        MonthlyStepModel(date: Calendar.current.date(byAdding: .month, value: -5, to: Date()) ?? Date(), count: 78328),
        MonthlyStepModel(date: Calendar.current.date(byAdding: .month, value: -6, to: Date()) ?? Date(), count: 37892),
        MonthlyStepModel(date: Calendar.current.date(byAdding: .month, value: -7, to: Date()) ?? Date(), count: 87776),
    ]
    
    var mockOneMonthdata = [
        DailyStepModel(date: Date(), count: 3442),
        DailyStepModel(date: Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date(), count: 4221),
        DailyStepModel(date: Calendar.current.date(byAdding: .day, value: -2, to: Date()) ?? Date(), count: 2342),
        DailyStepModel(date: Calendar.current.date(byAdding: .day, value: -3, to: Date()) ?? Date(), count: 2323),
        DailyStepModel(date: Calendar.current.date(byAdding: .day, value: -4, to: Date()) ?? Date(), count: 8243),
        DailyStepModel(date: Calendar.current.date(byAdding: .day, value: -5, to: Date()) ?? Date(), count: 8285),
        DailyStepModel(date: Calendar.current.date(byAdding: .day, value: -6, to: Date()) ?? Date(), count: 7714),
        DailyStepModel(date: Calendar.current.date(byAdding: .day, value: -7, to: Date()) ?? Date(), count: 2901),
        DailyStepModel(date: Calendar.current.date(byAdding: .day, value: -8, to: Date()) ?? Date(), count: 8522),
        DailyStepModel(date: Calendar.current.date(byAdding: .day, value: -9, to: Date()) ?? Date(), count: 8944),
        DailyStepModel(date: Calendar.current.date(byAdding: .day, value: -10, to: Date()) ?? Date(), count: 3198),
        DailyStepModel(date: Calendar.current.date(byAdding: .day, value: -11, to: Date()) ?? Date(), count: 9559),
        DailyStepModel(date: Calendar.current.date(byAdding: .day, value: -12, to: Date()) ?? Date(), count: 9222),
        DailyStepModel(date: Calendar.current.date(byAdding: .day, value: -13, to: Date()) ?? Date(), count: 7534),
        DailyStepModel(date: Calendar.current.date(byAdding: .day, value: -14, to: Date()) ?? Date(), count: 5905),
        DailyStepModel(date: Calendar.current.date(byAdding: .day, value: -15, to: Date()) ?? Date(), count: 7553),
        DailyStepModel(date: Calendar.current.date(byAdding: .day, value: -16, to: Date()) ?? Date(), count: 2813),
        DailyStepModel(date: Calendar.current.date(byAdding: .day, value: -17, to: Date()) ?? Date(), count: 7861),
        DailyStepModel(date: Calendar.current.date(byAdding: .day, value: -18, to: Date()) ?? Date(), count: 7313),
        DailyStepModel(date: Calendar.current.date(byAdding: .day, value: -19, to: Date()) ?? Date(), count: 7669),
        DailyStepModel(date: Calendar.current.date(byAdding: .day, value: -20, to: Date()) ?? Date(), count: 8424),
        DailyStepModel(date: Calendar.current.date(byAdding: .day, value: -21, to: Date()) ?? Date(), count: 9907),
        DailyStepModel(date: Calendar.current.date(byAdding: .day, value: -22, to: Date()) ?? Date(), count: 8521),
        DailyStepModel(date: Calendar.current.date(byAdding: .day, value: -23, to: Date()) ?? Date(), count: 5471),
        DailyStepModel(date: Calendar.current.date(byAdding: .day, value: -24, to: Date()) ?? Date(), count: 9227),
        DailyStepModel(date: Calendar.current.date(byAdding: .day, value: -25, to: Date()) ?? Date(), count: 9794),
        DailyStepModel(date: Calendar.current.date(byAdding: .day, value: -26, to: Date()) ?? Date(), count: 6543),
        DailyStepModel(date: Calendar.current.date(byAdding: .day, value: -27, to: Date()) ?? Date(), count: 2688),
        DailyStepModel(date: Calendar.current.date(byAdding: .day, value: -28, to: Date()) ?? Date(), count: 9187),
        DailyStepModel(date: Calendar.current.date(byAdding: .day, value: -29, to: Date()) ?? Date(), count: 4136)
    ]
    
    @Published var OneWeekAverage = 1243
    @Published var OneWeekTotal = 8723
    
    @Published var mockOneMonthData = [DailyStepModel]()
    @Published var OneMonthAverage = 0
    @Published var OneMonthTotal = 0
    
    @Published var mockThreeMonthData = [DailyStepModel]()
    @Published var threeMonthAverage = 0
    @Published var threeMonthtotal = 0
    
    @Published var ytdChartData = [MonthlyStepModel]()
    @Published var ytdAverage = 0
    @Published var ytdTotal = 0
    
    @Published var oneYearChartData = [MonthlyStepModel]()
    @Published var oneYearAverage = 0
    @Published var oneYearTotal = 0
    
    let healthManager = HealthManager.shared
    
    init() {
        let mockOneMonth = mockDataForDays(days: 30)
        let mockThreeMonth = mockDataForDays(days: 90)
        DispatchQueue.main.async {
            self.mockOneMonthdata = mockOneMonth
            self.mockThreeMonthData = mockThreeMonth
        }
        fetchYTDAndOneYearChartData()
    }
    
    func mockDataForDays(days: Int) -> [DailyStepModel] {
        var mockData = [DailyStepModel]()
        for day in 0..<days {
            let currentDate = Calendar.current.date(byAdding: .day, value: -day, to: Date()) ?? Date()
            let randomStepCount = Int.random(in: 5000...15000)
            let dailyStepData = DailyStepModel(date: currentDate, count: Int(randomStepCount))
            mockData.append(dailyStepData)
        }
        return mockData
    }
    
    func fetchYTDAndOneYearChartData() {
        healthManager.fetchYTDAndOneYearData { result in
            switch result {
            case .success(let result):
                DispatchQueue.main.async {
                    self.ytdChartData = result.ytd
                    self.oneYearChartData = result.oneYear
                    self.ytdTotal = self.ytdChartData.reduce(0, { $0 + $1.count})
                    self.oneYearTotal = self.oneYearChartData.reduce(0, { $0 + $1.count})
                    self.ytdAverage = self.ytdTotal / Calendar.current.component(.month, from: Date())
                    self.oneYearAverage = self.oneYearTotal / 12
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
}
