//
//  UserProfile.swift
//  FitMe
//
//  Created by Yesh Adithya on 2025-04-13.
//

import Foundation
import FirebaseFirestore

struct UserProfile: Codable {
    @DocumentID var id: String?
    var name: String?
    var email: String
    var phone: String?
    var address: String?
}
