//
//  Rate.swift
//  Coin
//
//  Created by Kirill Streltsov on 01.01.24.
//

import Foundation

struct Rate: Decodable, Identifiable {
    
    let timePeriodStart: String
    let timePeriodEnd: String
    let timeOpen: String
    let timeClose: String
    let rateOpen: Double
    let rateHigh: Double
    let rateLow: Double
    let rateClose: Double
    var id: UUID {
        UUID()
    }
}
