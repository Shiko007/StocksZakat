//
//  StocksConfiguration.swift
//  StocksZakat
//
//  Created by Sherif Yasser on 29.03.21.
//

import Foundation

class StocksConfiguration {
    let apiURLPrefix:String = "https://fmpcloud.io/api/v3/balance-sheet-statement/"
    let apiPeriod:String = "?period=" + GenericConfiguration().balaceSheetPeriod
    let apiNumberOfRetreivedData:String = "&limit=" + String(GenericConfiguration().balaceSheetlimitOfRetreivedData)
    let apiKey:String = "&apikey=" + GenericConfiguration().balanceSheetApiKey
}
