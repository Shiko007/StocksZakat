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
            print("Error While Reading and Parsing JSON")
        }
        return jsonData
    }
}
