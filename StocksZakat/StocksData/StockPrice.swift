//
//  StockPrice.swift
//  StocksZakat
//
//  Created by Sherif Yasser on 10.04.21.
//

import Foundation

class StockPrice{
    enum NetworkError: Error {
        case badURL , requestFailed , unknown
    }
    
    func getStockPrice(stockSymbol: String , completion: @escaping (Result<stockPrice,NetworkError>) -> Void){
        guard let apiURL = URL(string: StocksConfiguration().stockPriceAPIPrefix + stockSymbol + StocksConfiguration().tokenAPIKey) else {
            completion(.failure(.badURL))
            return
        }
        URLSession.shared.dataTask(with: apiURL){ data , response , error in
            DispatchQueue.main.async {
                if let data = data{
                    completion(.success(JSONParser().parseStockPrice(data: data)!))
                } else if error != nil{
                    completion(.failure(.requestFailed))
                }
                else {
                    completion(.failure(.unknown))
                }
            }
        }.resume()
    }
}
