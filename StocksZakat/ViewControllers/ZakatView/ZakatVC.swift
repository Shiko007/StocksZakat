//
//  ZakatVC.swift
//  StocksZakat
//
//  Created by Sherif Yasser on 28.03.21.
//

import UIKit

class ZakatVC : UIViewController {

    
    @IBOutlet weak var zakatTable: UITableView!
    var isViewAlreadyLoaded : Bool = false
    var updatingStocksData : Bool = false
    var currencyExchangeRates : currencies?
    var loadedBalanceSheetsCounter = 0 {
        didSet{
            if(loadedBalanceSheetsCounter == portfolio.count){
                handlePortfolioUpdate()
            }
        }
    }
    var loadedStocksDataCounter = 0{
        didSet{
            if(loadedStocksDataCounter == portfolio.count){
                updateBalanceSheetData()
            }
        }
    }
    var portfolio : [String:stockData] = [:]{
        didSet{
            if(zakatTable != nil){
                zakatTable.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.prefersLargeTitles = true
        isViewAlreadyLoaded = true
    }
    
    func loadStockData(stockSymbol : String){
        StocksData().getStockInfo(stocksSymbols: stockSymbol){ [self] result in
            switch result{
            case .success(let stockPrice):
                portfolio[stockSymbol]?.marketCap = stockPrice.quoteResponse.result![0].marketCap!
                portfolio[stockSymbol]?.price = stockPrice.quoteResponse.result![0].regularMarketPrice!
                portfolio[stockSymbol]?.currency = stockPrice.quoteResponse.result?[0].financialCurrency ?? ""
                loadedStocksDataCounter += 1
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
    
    func loadBalanceSheet(stockSymbol : String){
        if var stockDataInst = portfolio[stockSymbol]{
            StocksData().getCompanyBalanceSheet(company: stockSymbol){ [self]result in
                switch result{
                case .success(let stockData):
                    var zakatableAssets : Double = 0
                    var zakatPerStock : Double = 0
                    let balanceSheetData = stockData.context?.dispatcher?.stores?.QuoteSummaryStore?.balanceSheetHistoryQuarterly?.balanceSheetStatements?[0]
                    stockDataInst.balanceSheetFillingDate = balanceSheetData?.endDate?.fmt ?? ""
                    stockDataInst.totalCurrentAssets = balanceSheetData?.totalCurrentAssets?.raw ?? 0
                    stockDataInst.totalNonCurrentAssets = (((balanceSheetData?.totalAssets?.raw) ?? 0) - ((balanceSheetData?.totalCurrentAssets?.raw) ?? 0))
                    if(stockDataInst.currency.lowercased() != GenericConfiguration().preferedCurrency){
                        let conversionRate = CurrencyExchange().getCurrencyConversionRate(currenciesTable: currencyExchangeRates!, fromCurrency: stockDataInst.currency.lowercased())
                        stockDataInst.totalCurrentAssets = Int(Double(stockDataInst.totalCurrentAssets) * conversionRate)
                        stockDataInst.totalNonCurrentAssets = Int(Double(stockDataInst.totalNonCurrentAssets) * conversionRate)
                    }
                    zakatableAssets = Double(portfolio[stockSymbol]!.marketCap - stockDataInst.totalNonCurrentAssets)
                    if(zakatableAssets > 0){
                        zakatPerStock = round(Double((zakatableAssets / Double(stockDataInst.marketCap)) * 100) * 1000) / 1000
                    }
                    else{
                        zakatPerStock = 0
                    }
                    stockDataInst.zakatPerStock = zakatPerStock
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
    func updateBalanceSheetData(){
        for (stock,_) in portfolio {
            if(portfolio[stock] != nil){
                loadBalanceSheet(stockSymbol: stock)
            }
        }
    }
    func updateNewStockData(){
        for (stock,_) in portfolio {
            if(portfolio[stock] != nil){
                loadStockData(stockSymbol: stock)
            }
        }
    }
    
    func handlePortfolioUpdate(){
        let totalVC = self.tabBarController?.viewControllers![2].children[0] as! TotalVC
        totalVC.portfolio = portfolio
        loadedBalanceSheetsCounter = 0
        loadedStocksDataCounter = 0
        if(zakatTable != nil){
            zakatTable.reloadData()
        }
    }
}

extension ZakatVC : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return portfolio.count
   }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userPortfolioZakatTableReuseIdentifier") as! ZakatTableCell
        let portfolioKey = Array(portfolio.keys)[indexPath.row]
        let userOwnedStocks = portfolio[portfolioKey]?.userOwned ?? 0
        let zakatPerStock = portfolio[portfolioKey]?.zakatPerStock ?? 0
        let stockPrice = portfolio[portfolioKey]?.price ?? 0
        cell.stockSymbolLabel.text = String(portfolioKey)
        cell.youOwnLabel.text = String(userOwnedStocks)
        cell.zakatPerStockLabel.text = String(zakatPerStock) + "%"
        cell.userZakatLabel.text = String(Int(round((zakatPerStock / 100) * (userOwnedStocks * stockPrice))))
        cell.stockPriceLabel.text = String(stockPrice)
        return cell
   }
}
