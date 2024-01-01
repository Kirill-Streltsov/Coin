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
                    if let jsonString = String(data: data, encoding: .utf8) {
                        cacheJsonData(jsonString: jsonString)
                        let coinData = try jsonDecoder.decode([Rate].self, from: data)
                        completion(coinData)
                    }
                } catch let jsonError {
                    print("Failed while decoding JSON: \(jsonError)")
                }
            }
            if let response = response {
                print(response)
            }
            if error != nil {
                let loadingErrorDescription = String(describing: error)
                print("Failed while loading data from the web: \(loadingErrorDescription)")
            }
        }
        .resume()
        
    }
    
    
    //TODO: TEST!!!
    func cacheJsonData(jsonString: String) {
        
        if let documentDirectory = FileManager.default.urls(for: .documentDirectory,
                                                            in: .userDomainMask).first {
            let pathWithFilename = documentDirectory.appendingPathComponent("cachedData.json")
            do {
                try jsonString.write(to: pathWithFilename,
                                     atomically: true,
                                     encoding: .utf8)
            } catch {
                // Handle error
            }
        }
    }
    
    //TODO: TEST!!!
    func getCachedData() {
        if let documentDirectory = FileManager.default.urls(for: .documentDirectory,
                                                            in: .userDomainMask).first {
            do {
                let data = try Data(contentsOf: documentDirectory)
                if let string = String(data: data, encoding: .utf8) {
                    print("File contents: \(string)")
                }
            } catch {
                print("Error reading file: \(error)")
            }
        }
    }
}
