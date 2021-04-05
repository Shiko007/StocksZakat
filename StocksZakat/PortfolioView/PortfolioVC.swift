//
//  ViewController.swift
//  StocksZakat
//
//  Created by Sherif Yasser on 28.03.21.
//

import UIKit

class PortfolioVC : UIViewController {
    
    var userStocksCoreDataItems : [UserStocksItem] = []
    var portfolio : [String:Double] = [:]{
        didSet{
            userPortfolioTable.reloadData()
        }
    }
    var availableStocksSymbols : [String] = []
    var selectedSymbol : String = ""
    
    @IBOutlet weak var userPortfolioTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.prefersLargeTitles = true
//        userPortfolioTable.register(UINib.init(nibName: "PortfolioTableCell", bundle: nil), forCellReuseIdentifier: "userPortfolioTableReuseIdentifier")
        loadStoredUserStockItems()
    }
    
    func loadStoredUserStockItems(){
        userStocksCoreDataItems = UserStocksCoreData().loadStoredStocks()
        for userStockItem in userStocksCoreDataItems{
            portfolio[userStockItem.stockSymbol] = userStockItem.stocksCount
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "portfolioToStocksSegue":
            let nextViewController = segue.destination as! AddStocksVC
            nextViewController.availableStocksSymbols = self.availableStocksSymbols
            nextViewController.portfolioVC = self
        case "portfolioToStockInfoSegue":
            let nextView =  segue.destination as! StockOverviewVC
            nextView.stockSymbol = selectedSymbol
            nextView.portfolioVC = self
        default:
            print("Unknown Segue Identifier")
        }
    }
}

extension PortfolioVC: UITableViewDataSource, UITableViewDelegate {
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return portfolio.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userPortfolioTableReuseIdentifier") as! PortfolioTableCell
        cell.stockSymbol.text = Array(portfolio.keys)[indexPath.row]
        cell.stockCount.text = String(portfolio[Array(portfolio.keys)[indexPath.row]]!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedSymbol = Array(portfolio.keys)[indexPath[1]]
        performSegue(withIdentifier: "portfolioToStockInfoSegue", sender: self)
   }
}
