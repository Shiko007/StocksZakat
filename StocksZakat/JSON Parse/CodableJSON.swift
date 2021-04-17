//
//  CodableJSON.swift
//  StocksZakat
//
//  Created by Sherif Yasser on 29.03.21.
//

import Foundation

struct balanceSheetContext : Codable{
    var context : balanceSeetDispatcher?
}
struct balanceSeetDispatcher : Codable{
    var dispatcher : balanceSheetStores?
}
struct balanceSheetStores : Codable{
    var stores : balanceSheetStore?
}
struct balanceSheetStore : Codable{
    var PageStore : balanceSheetPageStore?
    var QuoteSummaryStore : BalanceSheetSummeryStore?
}
struct balanceSheetPageStore : Codable{
    var pageData : balanceSheetPageData
}
struct balanceSheetPageData : Codable{
    var symbol : String?
}
struct BalanceSheetSummeryStore : Codable{
    var balanceSheetHistoryQuarterly : balanceSheetQuarterly?
    var earnings : balanceSheetEarnings?
}
struct balanceSheetEarnings : Codable{
    var maxAge : Int?
    var financialCurrency : String?
}
struct balanceSheetQuarterly : Codable{
    var balanceSheetStatements : [balanceSheetStatment]?
    var maxAge : Int?
}
struct balanceSheetStatment : Codable{
    var totalAssets : balanceSheetAtomic?
    var endDate : balanceSheetAtomic?
    var totalCurrentAssets : balanceSheetAtomic?
}
struct balanceSheetAtomic : Codable{
    var raw : Int?
    var fmt : String?
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
