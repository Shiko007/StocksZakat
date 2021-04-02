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
