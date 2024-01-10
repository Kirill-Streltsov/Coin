//
//  ExchangeRatesViewModel.swift
//  Coin
//
//  Created by Kirill Streltsov on 01.01.24.
//

import SwiftUI

extension ExchangeRatesView {
    class ViewModel: ObservableObject {
        
        // UserDefaults keys:
        let udLastUpdateKey = "lastUpdate"
        let udLastCurrency = "lastCurrency"
        
        // Storing coinInfo in case we want to increment our info age
        private var coinInfo = [Rate]()
        
        // The information that we want to show to the user (with the info age in mind)
        @Published var filteredInfo = [Rate]()
        
        // InfoAge is 14 by default, meaning we are showing the information from the last 2 weeks
        var infoAge = 14
        
        @Published var selectedCurrency = Currency.EUR
        
        var lastUpdate = ""
        
        func getDataFromAPI() {
            APIManager.instance.getCoinData(currency: selectedCurrency) { coinInfo in
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    withAnimation {
                        self.lastUpdate = "\(Date.now)"
                        self.coinInfo = coinInfo
                        self.filteredInfo = Array(coinInfo[..<self.infoAge])
                        self.updateCurrentDate()
                        
                        // Saving the last update and selected currency to UserDefaults for our cache
                        UserDefaults.standard.setValue(self.lastUpdate, forKey: self.udLastUpdateKey)
                        UserDefaults.standard.setValue(self.selectedCurrency.rawValue, forKey: self.udLastCurrency)
                    }
                }
            }
        }
        
        func getDataFromFileSystem() {
            if let cachedRateInfo = APIManager.instance.getRateInfoFromFileSystem() {
                coinInfo = cachedRateInfo
                self.filteredInfo = Array(coinInfo[..<self.infoAge])
            }
            if let lastUpdate = UserDefaults.standard.value(forKey: udLastUpdateKey) as? String {
                self.lastUpdate = lastUpdate
            }
            if let lastCurrency = UserDefaults.standard.value(forKey: udLastCurrency) as? String {
                selectedCurrency = Currency(rawValue: lastCurrency) ?? .EUR
            }
        }
        
        func updateAge() {
            filteredInfo = Array(coinInfo[..<self.infoAge])
        }
        
        func updateCurrentDate() {
            let currentDate = Date()
            let outputDateFormatter = DateFormatter()
            outputDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSS'Z'"
            let dateString = outputDateFormatter.string(from: currentDate)
            
            let currentDateAsString = DateConverter.convertDateString(dateString, shouldBeShort: false)
            if let currentDateAsString = currentDateAsString {
                lastUpdate = currentDateAsString
            }
        }
    }
}

