//
//  StocksData.swift
//  StocksZakat
//
//  Created by Sherif Yasser on 28.03.21.
//

import UIKit

struct stockData {
    var symbol : String = ""
    var currency : String = ""
    var price : Double = 0
    var marketCap : Int = 0
    var userOwned : Double = 0
    var balanceSheetFillingDate : String = ""
    var totalCurrentAssets : Int = 0
    var totalNonCurrentAssets : Int = 0
}

class StocksData {
    enum NetworkError: Error {
        case badURL , requestFailed , unknown
    }
    
    func getCompanyBalanceSheet(company: String , completion: @escaping (Result<[balanceSheetElements],NetworkError>) -> Void){
        let defualtElements : [balanceSheetElements] = []
        guard let apiURL = URL(string: StocksConfiguration().apiURLPrefix + company + StocksConfiguration().apiPeriod + StocksConfiguration().apiNumberOfRetreivedData + StocksConfiguration().apiKey) else {
            completion(.failure(.badURL))
            return
        }
        URLSession.shared.dataTask(with: apiURL){ data , response , error in
            DispatchQueue.main.async {
                if let data = data{
                    if(data.count > 256){ //Guard against premium features or unavailable info
                        completion(.success(JSONParser().parseBalanceSheet(data: data)!))
                    }
                    else{
                        completion(.success(defualtElements))
                    }
                } else if error != nil{
                    completion(.failure(.requestFailed))
                }
                else {
                    completion(.failure(.unknown))
                }
            }
        }.resume()
    }
    
    func getAllAvailableStocksSymbols(exchangeMarket: String , completion: @escaping (Result<[stockSymbols],NetworkError>) -> Void){
        guard let apiURL = URL(string: StocksConfiguration().symbolsAPIPrefix + StocksConfiguration().symbolsAPIExchangeMarket + exchangeMarket + StocksConfiguration().tokenAPIKey) else {
            completion(.failure(.badURL))
            return
        }
        URLSession.shared.dataTask(with: apiURL){ data , response , error in
            DispatchQueue.main.async {
                if let data = data{
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
    
    func getStockInfo(stocksSymbols: String , completion: @escaping (Result<stockInfoResponse,NetworkError>) -> Void){
        guard let apiURL = URL(string: StocksConfiguration().stockInfoAPIPrefix + stocksSymbols) else {
            completion(.failure(.badURL))
            return
        }
        URLSession.shared.dataTask(with: apiURL){ data , response , error in
            DispatchQueue.main.async {
                if let data = data{
                    completion(.success(JSONParser().parseStocksInfo(data: data)!))
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
