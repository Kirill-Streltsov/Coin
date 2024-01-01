//
//  ExchangeRatesViewModel.swift
//  Coin
//
//  Created by Kirill Streltsov on 01.01.24.
//

import SwiftUI

extension ExchangeRatesView {
    class ViewModel: ObservableObject {
        
        // Storing coinInfo in case we want to increment our info age
        @Published var coinInfo = [Rate]()
        
        // The information that we want to show to the user (with the info age in mind)
        @Published var filteredInfo = [Rate]()
        
        // InfoAge is 14 by default, meaning we are showing the information from the last 2 weeks
        @Published var infoAge = 14
        
        @Published var selectedCurrency = Currency.EUR
        
        @Published var lastUpdate = ""
        
        func getData() {
            APIManager.instance.getCoinData(currency: selectedCurrency) { coinInfo in
                DispatchQueue.main.async {
                    withAnimation {
                        self.lastUpdate = "\(Date.now)"
                        self.coinInfo = coinInfo
                        self.filteredInfo = Array(coinInfo[..<self.infoAge])
                    }
                    print("SUCCESS: \(coinInfo.count)")
                }
            }
        }
        
        func updateAge() {
            filteredInfo = Array(coinInfo[..<self.infoAge])
        }
    }
}

