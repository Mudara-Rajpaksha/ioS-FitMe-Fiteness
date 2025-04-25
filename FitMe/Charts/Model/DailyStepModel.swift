//
//  DailyStepModel.swift
//  FitMe
//
//  Created by Gairuka Bandara on 2024-11-08.
//

import Foundation

struct DailyStepModel: Identifiable {
    let id = UUID()
    let date: Date
    let count: Int
}
