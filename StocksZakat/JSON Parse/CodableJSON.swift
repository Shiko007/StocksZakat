//
//  CodableJSON.swift
//  StocksZakat
//
//  Created by Sherif Yasser on 29.03.21.
//

import Foundation

struct balanceSheetElements : Codable {
    var date:String?
    var symbol:String?
    var reportedCurrency:String?
    var fillingDate:String?
    var acceptedDate:String?
    var period:String?
    var cashAndCashEquivalents:Int?
    var shortTermInvestments:Int?
    var cashAndShortTermInvestments:Int?
    var netReceivables:Int?
    var inventory:Int?
    var otherCurrentAssets:Int?
    var totalCurrentAssets:Int?
    var propertyPlantEquipmentNet:Int?
    var goodwill:Double?
    var intangibleAssets:Double?
    var goodwillAndIntangibleAssets:Double?
    var longTermInvestments:Int?
    var taxAssets:Double?
    var otherNonCurrentAssets:Int?
    var totalNonCurrentAssets:Int?
    var otherAssets:Double?
    var totalAssets:Int?
    var accountPayables:Int?
    var shortTermDebt:Int?
    var taxPayables:Double?
    var deferredRevenue:Int?
    var otherCurrentLiabilities:Int?
    var totalCurrentLiabilities:Int?
    var longTermDebt:Int?
    var deferredRevenueNonCurrent:Double?
    var deferredTaxLiabilitiesNonCurrent:Double?
    var otherNonCurrentLiabilities:Int?
    var totalNonCurrentLiabilities:Int?
    var otherLiabilities:Double?
    var totalLiabilities:Int?
    var commonStock:Int?
    var retainedEarnings:Int?
    var accumulatedOtherComprehensiveIncomeLoss:Int?
    var othertotalStockholdersEquity:Double?
    var totalStockholdersEquity:Int?
    var totalLiabilitiesAndStockholdersEquity:Int?
    var totalInvestments:Int?
    var totalDebt:Int?
    var netDebt:Int?
    var link:String?
    var finalLink:String?
}

struct stockSymbols : Codable {
    var currency : String?
    var description : String?
    var displaySymbol : String?
    var figi : String?
    var mic : String?
    var symbol : String?
    var type : String?
}

struct stockInfo : Codable {
    var language : String?
    var region : String?
    var quoteType : String?
    var quoteSourceName : String?
    var triggerable : Bool?
    var currency : String?
    var firstTradeDateMilliseconds : Int?
    var priceHint : Int?
    var postMarketChangePercent : Double?
    var postMarketTime : Int?
    var postMarketPrice : Double?
    var postMarketChange : Double?
    var regularMarketChange : Double?
    var regularMarketChangePercent : Double?
    var regularMarketTime : Int?
    var regularMarketPrice : Double?
    var regularMarketDayHigh : Double?
    var regularMarketDayRange : String?
    var regularMarketDayLow : Double?
    var regularMarketVolume : Int?
    var regularMarketPreviousClose : Double?
    var bid : Double?
    var ask : Double?
    var bidSize : Int?
    var askSize : Int?
    var fullExchangeName : String?
    var financialCurrency : String?
    var regularMarketOpen : Double?
    var averageDailyVolume3Month : Int?
    var averageDailyVolume10Day : Int?
    var fiftyTwoWeekLowChange : Double?
    var fiftyTwoWeekLowChangePercent : Double?
    var fiftyTwoWeekRange : String?
    var fiftyTwoWeekHighChange : Double?
    var fiftyTwoWeekHighChangePercent : Double?
    var fiftyTwoWeekLow : Double?
    var fiftyTwoWeekHigh : Double?
    var dividendDate : Int?
    var earningsTimestamp : Int?
    var earningsTimestampStart : Int?
    var earningsTimestampEnd : Int?
    var trailingAnnualDividendRate : Double?
    var trailingPE : Double?
    var trailingAnnualDividendYield : Double?
    var epsTrailingTwelveMonths : Double?
    var epsForward : Double?
    var epsCurrentYear : Double?
    var priceEpsCurrentYear : Double?
    var sharesOutstanding : Int?
    var bookValue : Double?
    var fiftyDayAverage : Double?
    var fiftyDayAverageChange : Double?
    var fiftyDayAverageChangePercent : Double?
    var twoHundredDayAverage : Double?
    var twoHundredDayAverageChange : Double?
    var twoHundredDayAverageChangePercent : Double?
    var marketCap : Int?
    var forwardPE : Double?
    var priceToBook : Double?
    var sourceInterval : Int?
    var exchangeDataDelayedBy : Int?
    var averageAnalystRating : String?
    var exchange : String?
    var shortName : String?
    var longName : String?
    var marketState : String?
    var messageBoardId : String?
    var exchangeTimezoneName : String?
    var exchangeTimezoneShortName : String?
    var gmtOffSetMilliseconds : Int?
    var market : String?
    var esgPopulated : Bool?
    var tradeable : Bool?
    var displayName : String?
    var symbol : String?
}

struct stockInfoResult : Codable {
    var result : [stockInfo]?
    var error : String?
}

struct stockInfoResponse : Codable {
    var quoteResponse : stockInfoResult
}
