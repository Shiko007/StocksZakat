//
//  JSONParse.swift
//  StocksZakat
//
//  Created by Sherif Yasser on 29.03.21.
//

import Foundation

class JSONParser {
    func parseBalanceSheet(data : Data?) -> [balanceSheetElements]?{
        var jsonData:[balanceSheetElements]?
        let decoder = JSONDecoder()
        do {
            jsonData = try decoder.decode([balanceSheetElements].self, from: data!)
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
    
    func parseStockPrice(data : Data?) -> stockPrice?{
        var jsonData:stockPrice?
        let decoder = JSONDecoder()
        do{
            jsonData = try decoder.decode(stockPrice.self, from: data!)
            return jsonData
        }
        catch{
            print("Error While Reading and Parsing Stock Price JSON")
        }
        return jsonData
    }
}
