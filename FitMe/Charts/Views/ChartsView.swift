//
//  ChartsView.swift
//  FitMe
//
//  Created by Gairuka Bandara on 2024-11-07.
//

import SwiftUI
import Charts


struct ChartsView: View {
    @StateObject var viewModel = ChartViewModel()
    @State var selectedChart : ChartOptions = .oneWeek
    var body: some View {
        VStack{
            Text("Charts")
                .font(.largeTitle)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            
            ZStack {
                switch selectedChart {
                case .oneWeek:
                    VStack {
                        ChartDataView(average: viewModel.OneWeekAverage, total: viewModel.OneWeekTotal)
                        Chart {
                            ForEach(viewModel.mockWeekChartData) { data in
                                BarMark(x: .value(data.date.formatted(), data.date, unit: .day), y: .value("Steps",data.count))
                            }
                        }
                    }
                case .oneMonth:
                    VStack {
                        ChartDataView(average: viewModel.OneMonthAverage, total: viewModel.OneMonthTotal)
                        Chart {
                            ForEach(viewModel.mockOneMonthdata) { data in
                                BarMark(x: .value(data.date.formatted(), data.date, unit: .day), y: .value("Steps",data.count))
                            }
                        }
                    }
                case .threeMonths:
                    VStack {
                        ChartDataView(average: viewModel.threeMonthAverage, total: viewModel.threeMonthtotal)
                        Chart {
                            ForEach(viewModel.mockThreeMonthData) { data in
                                BarMark(x: .value(data.date.formatted(), data.date, unit: .day), y: .value("Steps",data.count))
                            }
                        }
                    }
                case .yearToDate:
                    VStack {
                        ChartDataView(average: viewModel.ytdAverage, total: viewModel.ytdTotal)
                        Chart {
                            ForEach(viewModel.ytdChartData) { data in
                                BarMark(x: .value(data.date.formatted(), data.date, unit: .month), y: .value("Steps",data.count))
                            }
                        }
                    }
                case .oneYear:
                    VStack {
                        ChartDataView(average: viewModel.oneYearAverage, total: viewModel.oneYearTotal)
                        Chart {
                            ForEach(viewModel.oneYearChartData) { data in
                                BarMark(x: .value(data.date.formatted(), data.date, unit: .month), y: .value("Steps",data.count))
                            }
                        }
                    }
                }
            }
            .foregroundColor(.pink)
            .frame(maxHeight: 450)
            .padding(.horizontal)
            
            HStack{
                ForEach(ChartOptions.allCases, id:\.rawValue) { option in
                    Button(option.rawValue) {
                        withAnimation {
                            selectedChart = option
                        }
                    }
                    .padding()
                    .foregroundColor(selectedChart == option ? .white : .pink)
                    .background(selectedChart == option ? .pink : .clear)
                    .cornerRadius(10)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}

#Preview {
    ChartsView()
}
