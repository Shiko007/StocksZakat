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
    var portfolio : [String:Double] = [:]{
        didSet{
            if(isViewLoadedAlready == true){
                updateNewStockPrice()
            }
            if(zakatTable != nil){
                zakatTable.reloadData()
            }
        }
    }
    var portfolioPrices : [String:Double] = [:]{
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
        isViewLoadedAlready = true
        loadPortfolioStocksPrices()
    }
    
    func loadPortfolioStocksPrices(){
        for key in Array(portfolio.keys){
            loadStockPrice(stockSymbol: String(key))
        }
    }
    
    func loadStockPrice(stockSymbol : String){
        StockPrice().getStockPrice(stockSymbol: stockSymbol){ [self] result in
            switch result{
            case .success(let stockPrice):
                portfolioPrices[stockSymbol] = stockPrice.c ?? 0
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
    
    func updateNewStockPrice(){
        for key in Array(portfolio.keys){
            if(portfolioPrices[key] == nil){
                loadStockPrice(stockSymbol: String(key))
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
        cell.stockSymbolLabel.text = String(portfolioKey)
        cell.youOwnLabel.text = String(portfolio[portfolioKey]!)
        if let stockPrice = portfolioPrices[portfolioKey]{
            cell.stockPriceLabel.text = String(stockPrice)
        }
        return cell
   }
}
