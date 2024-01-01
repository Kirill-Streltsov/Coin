//
//  APIManager.swift
//  Coin
//
//  Created by Kirill Streltsov on 01.01.24.
//

import Foundation

class APIManager {
    
    let API_KEY = "2DF2CFBC-D864-4390-BBB1-CD6265B51E18"
    let jsonDecoder = JSONDecoder()
    
    // Singleton
    static let instance = APIManager()
    
    private init() {
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    func getCoinData(currency: Currency, _ completion: @escaping ([Rate]) -> Void) {
        
        let urlString = "https://rest.coinapi.io/v1/exchangerate/BTC/\(currency.rawValue)/history?period_id=1DAY"
        
        guard let url = URL(string: urlString) else { return }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue(API_KEY, forHTTPHeaderField: "X-CoinAPI-Key")
        
        URLSession.shared.dataTask(with: urlRequest) { [weak self] data, response, error in
            
            guard let self = self else { return }
            
            if let data = data {
                do {
                    let coinData = try jsonDecoder.decode([Rate].self, from: data)
                    saveDataToFileSystem(data)
                    completion(coinData)
                } catch let jsonError {
                    print("Failed while decoding JSON: \(jsonError)")
                }
            }
            if error != nil {
                let loadingErrorDescription = String(describing: error)
                print("Failed while loading data from the web: \(loadingErrorDescription)")
            }
        }
        .resume()
        
    }
    
    func saveDataToFileSystem(_ data: Data) {
        
        let documentsDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = documentsDirectoryURL.appendingPathComponent("data.json")
        
        do {
            try data.write(to: fileURL)
            print("Data saved successfully: \(fileURL)")
        } catch {
            print("Could not save data: \(error)")
        }
    }
    
    func getRateInfoFromFileSystem() -> [Rate]? {
        
        let documentsDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = documentsDirectoryURL.appendingPathComponent("data.json")
        
        do {
            let data = try Data(contentsOf: fileURL)
            do {
                let coinData = try jsonDecoder.decode([Rate].self, from: data)
                return coinData
            } catch let jsonError {
                print("Failed while decoding JSON: \(jsonError)")
                return nil
            }
            
        } catch {
            print("Could not read data: \(error)")
            return nil
        }
    }
    
}
