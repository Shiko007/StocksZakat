//
//  ZakatVC.swift
//  StocksZakat
//
//  Created by Sherif Yasser on 28.03.21.
//

import UIKit

class ZakatVC : UIViewController {


    @IBOutlet weak var zakatTable: UITableView!
    var isViewLoadedAlready : Bool = false
    var portfolio : [String:stockData] = [:]{
        didSet{
            if(isViewLoadedAlready == true){
                updateNewStockData()
            }
            if(zakatTable != nil){
                zakatTable.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.prefersLargeTitles = true
        isViewLoadedAlready = true
    }
    
    func loadStockData(stockSymbol : String){
        StocksData().getStockInfo(stocksSymbols: stockSymbol){ [self] result in
            switch result{
            case .success(let stockPrice):
                var zakatableAssets : Double = 0
                portfolio[stockSymbol]?.marketCap = stockPrice.quoteResponse.result![0].marketCap!
                portfolio[stockSymbol]?.price = stockPrice.quoteResponse.result![0].regularMarketPrice!
                zakatableAssets = Double(portfolio[stockSymbol]!.marketCap - portfolio[stockSymbol]!.totalNonCurrentAssets)
                portfolio[stockSymbol]?.zakatPerStock = round(Double((zakatableAssets / Double(portfolio[stockSymbol]!.marketCap)) * 100) * 1000) / 1000
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
    
    func updateNewStockData(){

        for (stock,_) in portfolio {
            if(portfolio[stock] != nil && portfolio[stock]?.price == 0){
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
