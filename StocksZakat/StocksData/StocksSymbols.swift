//
//  StocksSymbols.swift
//  StocksZakat
//
//  Created by Sherif Yasser on 30.03.21.
//

import Foundation

class StocksSymbols{
    enum NetworkError: Error {
        case badURL , requestFailed , unknown
    }
    
    func getAllAvailableStocksSymbols(exchangeMarket: String , completion: @escaping (Result<[stockSymbols],NetworkError>) -> Void){
        guard let apiURL = URL(string: StocksConfiguration().symbolsAPIPrefix + StocksConfiguration().symbolsAPIExchangeMarket + exchangeMarket + StocksConfiguration().symbolsAPIKey) else {
            completion(.failure(.badURL))
            return
        }
        URLSession.shared.dataTask(with: apiURL){ data , response , error in
            DispatchQueue.main.async {
                if let data = data{
                    print(data)
                    completion(.success(JSONParser().parseSymbolList(data: data)!))
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
