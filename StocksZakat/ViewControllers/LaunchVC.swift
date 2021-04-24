//
//  LaunchVC.swift
//  StocksZakat
//
//  Created by Sherif Yasser on 30.03.21.
//

import UIKit

class LaunchVC : UIViewController {
    var availableStocksSymbols : [String] = []
    var userStocksCoreDataItems : [UserStocksItem] = []
    var currencyExchangeRates : currencies?
    var portfolio : [String:stockData] = [:]
    var symbolsLoadedFlag : Bool = false {
        didSet{
            if(symbolsLoadedFlag == true){
                loadingAppCounter += 1
            }
        }
    }
    var symbolsLoadedRegionsCounter : Int = 0{
        didSet{
            if(symbolsLoadedRegionsCounter == StocksConfiguration().supportedStockRegions.count){
                symbolsLoadedFlag = true
            }
        }
    }
    var userStoredProtfolioLoaded : Bool = false {
        didSet{
            if(userStoredProtfolioLoaded == true){
                loadingAppCounter += 1
                loadPortfolioStocksData()
            }
        }
    }
    
    var loadedBalanceSheets : Bool = false {
        didSet{
            if(loadedBalanceSheets == true){
                loadingAppCounter += 1
            }
        }
    }
    
    var loadedBalanceSheetsCounter : Int = 0{
        didSet{
            if(loadedBalanceSheetsCounter == portfolio.count){
                loadedBalanceSheets = true
            }
        }
    }
    
    var loadedStockData : Bool = false {
        didSet{
            if(loadedStockData == true){
                loadingAppCounter += 1
                loadUserPortfolioBalanceSheets()
            }
        }
    }
    
    var loadedStockDataCounter : Int = 0{
        didSet{
            if(loadedStockDataCounter == portfolio.count){
                loadedStockData = true
            }
        }
    }
    
    var loadedCurrencyRates : Bool = false {
        didSet{
            if loadedCurrencyRates == true{
                loadingAppCounter += 1
            }
        }
    }
    
    var loadingAppCounter : Int = 0 {
        didSet{
            if((symbolsLoadedFlag == true) && (userStoredProtfolioLoaded == true) && (loadedBalanceSheets == true) && (loadedStockData == true) && (loadedCurrencyRates == true)){
                appLoaded = true
            }
        }
    }
    
    var appLoaded : Bool = false{
        didSet{
            if(appLoaded == true){
                self.dismiss(animated: false)
                self.performSegue(withIdentifier: "launchAPP", sender: self)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let tabController: UITabBarController = segue.destination as! UITabBarController
        let navController: UINavigationController = tabController.viewControllers![0] as! UINavigationController
        let nextViewController = navController.viewControllers[0] as! PortfolioVC
        let zakatNavController: UINavigationController = tabController.viewControllers![1] as! UINavigationController
        let zakatViewController = zakatNavController.viewControllers[0] as! ZakatVC
        nextViewController.availableStocksSymbols = self.availableStocksSymbols.sorted()
        nextViewController.portfolio = portfolio
        nextViewController.userStocksCoreDataItems = userStocksCoreDataItems
        nextViewController.currencyExchangeRates = currencyExchangeRates
        zakatViewController.currencyExchangeRates = currencyExchangeRates
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadStockSymbols()
        loadStoredUserStockItems()
        loadCurrencyExchangeRates(currency : GenericConfiguration().preferedCurrency)
    }
    
    func loadStockSymbols(){
        for region in StocksConfiguration().supportedStockRegions {
            StocksData().getAllAvailableStocksSymbols(exchangeMarket: region) { result in
                switch result{
                case .success(let stocksSymbols):
                    for stockSymbol in stocksSymbols{
                        self.availableStocksSymbols.append(stockSymbol.displaySymbol!)
                    }
                    self.symbolsLoadedRegionsCounter += 1
                case .failure(let error):
                    switch error {
                    case .badURL:
                        print("Bad URL!")
                    case .requestFailed:
                        print("Request Failed!")
                    case .unknown:
                        print("Uknown Error!")
                    }
                }
            }
        }
    }
    
    func loadStoredUserStockItems(){
        var stockDataInst = stockData(symbol: "",currency: "", price: 0, marketCap: 0, userOwned: 0, balanceSheetFillingDate: "", totalCurrentAssets: 0, totalNonCurrentAssets: 0, zakatPerStock: 0)
        userStocksCoreDataItems = UserStocksCoreData().loadStoredStocks()
        for userStockItem in userStocksCoreDataItems{
            stockDataInst.symbol = userStockItem.stockSymbol
            stockDataInst.userOwned = userStockItem.stocksCount
            portfolio[userStockItem.stockSymbol] = stockDataInst
        }
        userStoredProtfolioLoaded = true
    }
    
    func loadUserPortfolioBalanceSheets(){
        for (stock,_) in portfolio {
            loadBalanceSheet(stockSymbol: stock)
        }
    }
    
    func loadPortfolioStocksData(){
        for (stock,_) in portfolio{
            loadStockData(stockSymbol: stock)
        }
    }
    
    func loadStockData(stockSymbol : String){
        if var stockDataInst = portfolio[stockSymbol]{
            StocksData().getStockInfo(stocksSymbols: stockSymbol){ [self] result in
                switch result{
                case .success(let stockData):
                    stockDataInst.currency = stockData.quoteResponse.result?[0].financialCurrency ?? ""
                    stockDataInst.marketCap = stockData.quoteResponse.result?[0].marketCap ?? 0
                    stockDataInst.price = stockData.quoteResponse.result?[0].regularMarketPrice ?? 0
                    if(Double(stockDataInst.marketCap - stockDataInst.totalNonCurrentAssets) > 0){
                        stockDataInst.zakatPerStock = round(((Double(stockDataInst.marketCap - stockDataInst.totalNonCurrentAssets) / Double(stockDataInst.marketCap)) * 100) * 1000) / 1000
                    }else{
                        stockDataInst.zakatPerStock = 0
                    }
                    portfolio[stockSymbol] = stockDataInst
                    loadedStockDataCounter += 1
                case .failure(let error):
                    switch error {
                    case .badURL:
                        print("Bad URL!")
                    case .requestFailed:
                        print("Request Failed!")
                    case .unknown:
                        print("Uknown Error!")
                    }
                }
            }
        }
    }
    
    func loadBalanceSheet(stockSymbol : String){
        if var stockDataInst = portfolio[stockSymbol]{
            StocksData().getCompanyBalanceSheet(company: stockSymbol){ [self]result in
                switch result{
                case .success(let stockData):
                    let balanceSheetData = stockData.context?.dispatcher?.stores?.QuoteSummaryStore?.balanceSheetHistoryQuarterly?.balanceSheetStatements?[0]
                    stockDataInst.balanceSheetFillingDate = balanceSheetData?.endDate?.fmt ?? ""
                    stockDataInst.totalCurrentAssets = balanceSheetData?.totalCurrentAssets?.raw ?? 0
                    stockDataInst.totalNonCurrentAssets = (((balanceSheetData?.totalAssets?.raw) ?? 0) - ((balanceSheetData?.totalCurrentAssets?.raw) ?? 0))
                    if(stockDataInst.currency.lowercased() != GenericConfiguration().preferedCurrency){
                        let conversionRate = CurrencyExchange().getCurrencyConversionRate(currenciesTable: currencyExchangeRates!, fromCurrency: stockDataInst.currency.lowercased())
                        stockDataInst.totalCurrentAssets = Int(Double(stockDataInst.totalCurrentAssets) * conversionRate)
                        stockDataInst.totalNonCurrentAssets = Int(Double(stockDataInst.totalNonCurrentAssets) * conversionRate)
                    }
                    if(Double(stockDataInst.marketCap - stockDataInst.totalNonCurrentAssets) > 0){
                        stockDataInst.zakatPerStock = round(((Double(stockDataInst.marketCap - stockDataInst.totalNonCurrentAssets) / Double(stockDataInst.marketCap)) * 100) * 1000) / 1000
                    }else{
                        stockDataInst.zakatPerStock = 0
                    }
                    self.portfolio[stockSymbol] = stockDataInst
                    self.loadedBalanceSheetsCounter += 1
                case .failure(let error):
                    switch error {
                    case .badURL:
                        print("Bad URL!")
                    case .requestFailed:
                        print("Request Failed!")
                    case .unknown:
                        print("Uknown Error!")
                    }
                }
            }
        }
    }
    
    func loadCurrencyExchangeRates(currency: String){
        CurrencyExchange().getCurrencyExchangeRates(currency: currency){ [self] result in
            switch result{
            case .success(let currencyExchangeData):
                currencyExchangeRates = currencyExchangeData
                loadedCurrencyRates = true
            case .failure(let error):
                switch error {
                case .badURL:
                    print("Bad URL!")
                case .requestFailed:
                    print("Request Failed!")
                case .unknown:
                    print("Uknown Error!")
                }
            }
        }
    }
}
