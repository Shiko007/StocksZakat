//
//  StocksConfiguration.swift
//  StocksZakat
//
//  Created by Sherif Yasser on 29.03.21.
//

import Foundation

class StocksConfiguration {
    let supportedStockRegions = ["US","DE"]
    
    /* All Available Regions ["AS","AT","AX","BA","BC","BD","BE","BK","BO","BR","CN","CO","CR","DB","DE","DU","F","HE","HK","HM","IC","IR","IS","JK","JO","KL","KQ","KS","L","LN","LS","MC","ME","MI","MU","MX","NE","NL","NS","NZ","OL","PA","PM","PR","QA","RG","SA","SG","SI","SN","SR","SS","ST","SW","SZ","T","TA","TL","TO","TW","US","V","VI","VN","VS","WA","HA","SX","TG","SC"]*/
    
    let apiURLPrefix:String = "https://fmpcloud.io/api/v3/balance-sheet-statement/"
    let apiPeriod:String = "?period=" + GenericConfiguration().balaceSheetPeriod
    let apiNumberOfRetreivedData:String = "&limit=" + String(GenericConfiguration().balaceSheetlimitOfRetreivedData)
    let apiKey:String = "&apikey=" + GenericConfiguration().balanceSheetApiKey
    
    let symbolsAPIPrefix:String = "https://finnhub.io/api/v1/stock/symbol?"
    let symbolsAPIExchangeMarket:String = "exchange="
    let symbolsAPIKey:String = "&token=" + GenericConfiguration().symbolsApiKey
}
