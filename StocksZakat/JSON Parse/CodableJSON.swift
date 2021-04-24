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

struct currencies : Codable{
    var usd : currency?
    var eur : currency?
    var gbp : currency?
    var jpy : currency?
    var chf : currency?
    var aud : currency?
    var cad : currency?
    var nad : currency?
    var syp : currency?
    var mru : currency?
    var wst : currency?
    var mur : currency?
    var isk : currency?
    var pkr : currency?
    var kgs : currency?
    var nio : currency?
    var pab : currency?
    var xcd : currency?
    var ang : currency?
    var dop : currency?
    var bam : currency?
    var dzd : currency?
    var pln : currency?
    var brl : currency?
    var gip : currency?
    var tmt : currency?
    var svc : currency?
    var awg : currency?
    var zmw : currency?
    var yer : currency?
    var bnd : currency?
    var sgd : currency?
    var ils : currency?
    var tnd : currency?
    var irr : currency?
    var stn : currency?
    var djf : currency?
    var all : currency?
    var mvr : currency?
    var cop : currency?
    var xaf : currency?
    var omr : currency?
    var rsd : currency?
    var fjd : currency?
    var cdf : currency?
    var szl : currency?
    var kes : currency?
    var inr : currency?
    var bbd : currency?
    var vnd : currency?
    var mad : currency?
    var pyg : currency?
    var lrd : currency?
    var sdg : currency?
    var ern : currency?
    var ugx : currency?
    var myr : currency?
    var ron : currency?
    var pen : currency?
    var kzt : currency?
    var crc : currency?
    var ttd : currency?
    var htg : currency?
    var mop : currency?
    var vuv : currency?
    var nok : currency?
    var TRY : currency?
    var bdt : currency?
    var tjs : currency?
    var mga : currency?
    var ves : currency?
    var cve : currency?
    var mwk : currency?
    var gtq : currency?
    var bwp : currency?
    var rub : currency?
    var idr : currency?
    var bhd : currency?
    var uah : currency?
    var mkd : currency?
    var xpf : currency?
    var mmk : currency?
    var lkr : currency?
    var clp : currency?
    var sek : currency?
    var php : currency?
    var mro : currency?
    var lbp : currency?
    var bzd : currency?
    var kmf : currency?
    var sll : currency?
    var scr : currency?
    var dkk : currency?
    var aed : currency?
    var twd : currency?
    var jod : currency?
    var ars : currency?
    var jmd : currency?
    var ssp : currency?
    var mzn : currency?
    var tzs : currency?
    var cny : currency?
    var kwd : currency?
    var huf : currency?
    var ngn : currency?
    var amd : currency?
    var bob : currency?
    var srd : currency?
    var ghs : currency?
    var top : currency?
    var mnt : currency?
    var nzd : currency?
    var hrk : currency?
    var byn : currency?
    var mdl : currency?
    var afn : currency?
    var etb : currency?
    var sbd : currency?
    var lak : currency?
    var cup : currency?
    var sar : currency?
    var hkd : currency?
    var qar : currency?
    var uzs : currency?
    var gmd : currency?
    var bif : currency?
    var aoa : currency?
    var khr : currency?
    var zar : currency?
    var mxn : currency?
    var lyd : currency?
    var iqd : currency?
    var bsd : currency?
    var gnf : currency?
    var hnl : currency?
    var npr : currency?
    var czk : currency?
    var thb : currency?
    var xof : currency?
    var egp : currency?
    var gel : currency?
    var gyd : currency?
    var rwf : currency?
    var lsl : currency?
    var sos : currency?
    var krw : currency?
    var bgn : currency?
    var pgk : currency?
    var azn : currency?
    var uyu : currency?
}

struct currency : Codable {
    var code : String?
    var alphaCode : String?
    var numericCode : String?
    var name : String?
    var rate : Double?
    var date : String?
    var inverseRate : Double?
}
