//
//  StocksData.swift
//  StocksZakat
//
//  Created by Sherif Yasser on 28.03.21.
//

import UIKit

class StocksData {
    enum NetworkError: Error {
        case badURL , requestFailed , unknown
    }
    func getCompanyBalanceSheet(company: String , completion: @escaping (Result<[balanceSheetElements],NetworkError>) -> Void){
        guard let apiURL = URL(string: StocksConfiguration().apiURLPrefix + company + StocksConfiguration().apiPeriod + StocksConfiguration().apiNumberOfRetreivedData + StocksConfiguration().apiKey) else {
            completion(.failure(.badURL))
            return
        }
        URLSession.shared.dataTask(with: apiURL){ data , response , error in
            DispatchQueue.main.async {
                if let data = data{
                    completion(.success(JSONParser().parseBalanceSheet(data: data)!))
                } else if error != nil{
                    completion(.failure(.requestFailed))
                }
                else {
                    completion(.failure(.unknown))
                }
            }
        }.resume()
    }
//    func getCompanyBalanceSheet(company: String, completion: @escaping (Result<[balanceSheetElements], NetworkError>) -> void){
//        let fullURLString = StocksConfiguration().apiURLPrefix + company + StocksConfiguration().apiPeriod + StocksConfiguration().apiNumberOfRetreivedData + StocksConfiguration().apiKey
//        if let apiURL = URL(string: fullURLString){
//            let session = URLSession.shared
//            let dataTask = session.dataTask(with: apiURL){ (data , response , error) in
//                if error == nil && data != nil{
//                    print(JSONParser().parseBalanceSheet(data: data))
//                }
//            }
//            dataTask.resume()
//        }
//    }
}
