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
    var loadedBalanceSheetsCounter = 0 {
        didSet{
            if(loadedBalanceSheetsCounter == portfolio.count){
                updateNewStockData()
            }
        }
    }
    var loadedStocksDataCounter = 0{
        didSet{
            if(loadedStocksDataCounter == portfolio.count){
                loadedBalanceSheetsCounter = 0
                loadedStocksDataCounter = 0
                if(zakatTable != nil){
                    zakatTable.reloadData()
                }
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
                var zakatableAssets : Double = 0
                var zakatPerStock : Double = 0
                portfolio[stockSymbol]?.marketCap = stockPrice.quoteResponse.result![0].marketCap!
                portfolio[stockSymbol]?.price = stockPrice.quoteResponse.result![0].regularMarketPrice!
                zakatableAssets = Double(portfolio[stockSymbol]!.marketCap - portfolio[stockSymbol]!.totalNonCurrentAssets)
                zakatPerStock = round(Double((zakatableAssets / Double(portfolio[stockSymbol]!.marketCap)) * 100) * 1000) / 1000
                portfolio[stockSymbol]?.zakatPerStock = zakatPerStock
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
                    let balanceSheetData = stockData.context?.dispatcher?.stores?.QuoteSummaryStore?.balanceSheetHistoryQuarterly?.balanceSheetStatements?[0]
                    stockDataInst.balanceSheetFillingDate = balanceSheetData?.endDate?.fmt ?? ""
                    stockDataInst.totalCurrentAssets = balanceSheetData?.totalCurrentAssets?.raw ?? 0
                    stockDataInst.totalNonCurrentAssets = (((balanceSheetData?.totalAssets?.raw) ?? 0) - ((balanceSheetData?.totalCurrentAssets?.raw) ?? 0))
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
