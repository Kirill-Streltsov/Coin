//
//  Currencies.swift
//  Coin
//
//  Created by Kirill Streltsov on 01.01.24.
//

import Foundation

// Several currencies to choose from. We could also download them with the metadata, but it looks like an overkill imo
enum Currency: String, CaseIterable, Identifiable {
    case EUR = "EUR"
    case USD = "USD"
    case JPY = "JPY"
    case GPB = "GPB"
    case AUD = "AUD"

    var id: Self {
        self
    }
}
