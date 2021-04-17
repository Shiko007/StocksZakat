//
//  StocksConfiguration.swift
//  StocksZakat
//
//  Created by Sherif Yasser on 29.03.21.
//

import Foundation

class StocksConfiguration {
    let supportedStockRegions = ["US"]
    
    /* All Available Regions ["AS","AT","AX","BA","BC","BD","BE","BK","BO","BR","CN","CO","CR","DB","DE","DU","F","HE","HK","HM","IC","IR","IS","JK","JO","KL","KQ","KS","L","LN","LS","MC","ME","MI","MU","MX","NE","NL","NS","NZ","OL","PA","PM","PR","QA","RG","SA","SG","SI","SN","SR","SS","ST","SW","SZ","T","TA","TL","TO","TW","US","V","VI","VN","VS","WA","HA","SX","TG","SC"]*/
    
    let symbolsAPIPrefix:String = "https://finnhub.io/api/v1/stock/symbol?"
    let symbolsAPIExchangeMarket:String = "exchange="
    let tokenAPIKey:String = "&token=" + GenericConfiguration().finnhubApiKey
    
    let stockInfoAPIPrefix:String = "https://query1.finance.yahoo.com/v7/finance/quote?symbols="
    
    let stockBalanceSheetPrefix:String = "https://finance.yahoo.com/quote/"
    let stockBalanceSheetSuffix:String = "/balance-sheet"
}
