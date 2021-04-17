//
//  JSONParse.swift
//  StocksZakat
//
//  Created by Sherif Yasser on 29.03.21.
//

import Foundation

class JSONParser {
    func parseBalanceSheet(data : String?) -> balanceSheetContext?{
        var jsonData:balanceSheetContext?
        let decoder = JSONDecoder()
        do {
            jsonData = try decoder.decode(balanceSheetContext.self, from: Data(String(data!).utf8))
            return jsonData
        }
        catch{
            print("Error While Reading and Parsing Balance Sheet JSON")
        }
        return jsonData
    }
    
    func parseSymbolList(data : Data?) -> [stockSymbols]?{
        var jsonData:[stockSymbols]?
        let decoder = JSONDecoder()
        do{
            jsonData = try decoder.decode([stockSymbols].self, from: data!)
            return jsonData
        }
        catch{
            print("Error While Reading and Parsing Stocks Symbols JSON")
        }
        return jsonData
    }
    
    func parseStocksInfo(data : Data?) -> stockInfoResponse?{
        var jsonData:stockInfoResponse?
        let decoder = JSONDecoder()
        do{
            jsonData = try decoder.decode(stockInfoResponse.self, from: data!)
            return jsonData
        }
        catch{
            print("Error While Reading and Parsing Stock Price JSON")
        }
        return jsonData
    }
}
