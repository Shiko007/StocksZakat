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
                loadUserPortfolioBalanceSheets()
            }
        }
    }
    
    var loadedBalanceSheets : Bool = false {
        didSet{
            if(loadedBalanceSheets == true){
                loadingAppCounter += 1
                loadPortfolioStocksData()
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
    
    var loadingAppCounter : Int = 0 {
        didSet{
            if((symbolsLoadedFlag == true) && (userStoredProtfolioLoaded == true) && (loadedBalanceSheets == true) && (loadedStockData == true)){
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
        nextViewController.availableStocksSymbols = self.availableStocksSymbols.sorted()
        nextViewController.portfolio = portfolio
        nextViewController.userStocksCoreDataItems = userStocksCoreDataItems
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadStockSymbols()
        loadStoredUserStockItems()
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
            loadedStockDataCounter += 1
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
                    stockDataInst.zakatPerStock = round(((Double(stockDataInst.marketCap - stockDataInst.totalNonCurrentAssets) / Double(stockDataInst.marketCap)) * 100) * 1000) / 1000
                    portfolio[stockSymbol] = stockDataInst
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
                case .success(let balanceSheet):
                    if(balanceSheet.isEmpty != true){
                        stockDataInst.balanceSheetFillingDate = balanceSheet[0].fillingDate ?? ""
                        stockDataInst.totalCurrentAssets = balanceSheet[0].totalCurrentAssets ?? 0
                        stockDataInst.totalNonCurrentAssets = balanceSheet[0].totalNonCurrentAssets ?? 0
                    }
                    portfolio[stockSymbol] = stockDataInst
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
}
