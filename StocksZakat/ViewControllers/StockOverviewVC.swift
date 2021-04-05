//
//  StockOverviewVC.swift
//  StocksZakat
//
//  Created by Sherif Yasser on 31.03.21.
//

import UIKit

class StockOverviewVC : UIViewController {
    var stockSymbol: String = ""
    var stockDataAvailable : Bool = false
    var balanceSheetInfo: balanceSheetElements?
    var balanceSheetNotAvailable: Bool = false
    var portfolioVC : UIViewController?
    var stockAlreadyInPortfolio : Bool = true
    
    @IBOutlet weak var stockSymbolLabel: UILabel!
    
    @IBOutlet weak var reportedCurrencyLabel: UILabel!
    
    @IBOutlet weak var fillingDateLabel: UILabel!
    
    @IBOutlet weak var totalCurrentAssetLabel: UILabel!
    
    @IBOutlet weak var totalNonCurrentAssetLabel: UILabel!
    
    @IBOutlet weak var longTermInvestmentLabel: UILabel!
    
    @IBOutlet weak var AddOrEditButton: UIButton!
    
    @IBAction func AddorEditButtonPressed(_ sender: Any) {
        let updatePortfolioVC = portfolioVC as! PortfolioVC
        if(self.stockDataAvailable == true){
            if(stockAlreadyInPortfolio == false){
                performSegue(withIdentifier: "stockOverviewtoAddorEdit", sender: self)
                AddOrEditButton.isHidden = true
            }
            else{
                UserStocksCoreData().deleteStockItem(item: matchStockItemWith(stockSymbol: stockSymbol))
                updatePortfolioVC.portfolio.removeValue(forKey: stockSymbol)
                self.dismiss(animated: true)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        UpdateViewWithStockInfo()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let stockAddEditView = segue.destination as! StockAddEditVC
        stockAddEditView.portfolioVC = portfolioVC
        stockAddEditView.stockSymbol = stockSymbol
        stockAddEditView.stockOverViewVC = self
    }
    
    func configureAddorRemoveButton(){
        let updatePortfolioVC = portfolioVC as! PortfolioVC
        if(updatePortfolioVC.portfolio[stockSymbol] != nil){
            AddOrEditButton.setTitle("Remove", for: .normal)
            AddOrEditButton.backgroundColor = #colorLiteral(red: 0.6750947833, green: 0, blue: 0, alpha: 1)
            stockAlreadyInPortfolio = true
        }else{
            AddOrEditButton.setTitle("Add", for: .normal)
            AddOrEditButton.backgroundColor = #colorLiteral(red: 0, green: 0.5229981542, blue: 0, alpha: 1)
            stockAlreadyInPortfolio = false
        }
    }
    
    func UpdateViewWithStockInfo(){
        self.stockSymbolLabel.adjustsFontSizeToFitWidth = true
        self.reportedCurrencyLabel.adjustsFontSizeToFitWidth = true
        self.fillingDateLabel.adjustsFontSizeToFitWidth = true
        self.totalCurrentAssetLabel.adjustsFontSizeToFitWidth = true
        self.totalNonCurrentAssetLabel.adjustsFontSizeToFitWidth = true
        self.longTermInvestmentLabel.adjustsFontSizeToFitWidth = true

        balanceSheetNotAvailable = false
        StocksData().getCompanyBalanceSheet(company: stockSymbol){ result in
            switch result{
            case .success(let balanceSheet):
                if(balanceSheet.isEmpty != true){
                    self.balanceSheetInfo = balanceSheet[0]
                    self.stockSymbolLabel.text = balanceSheet[0].symbol
                    self.reportedCurrencyLabel.text = "Report Currency: " + balanceSheet[0].reportedCurrency!
                    self.fillingDateLabel.text = "Filling Date: " + balanceSheet[0].fillingDate!
                    self.totalCurrentAssetLabel.text = "Total Current Assets: " + String(balanceSheet[0].totalCurrentAssets!)
                    self.totalNonCurrentAssetLabel.text = "Total Non-Current Assets: " + String(balanceSheet[0].totalNonCurrentAssets!)
                    self.longTermInvestmentLabel.text = "Long Term Investments: " + String(balanceSheet[0].longTermInvestments!)
                    self.stockDataAvailable = true
                    self.configureAddorRemoveButton()
                }
                else{
                    self.stockSymbolLabel.text = "Unavailable"
                    self.stockDataAvailable = false
                }
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
    
    func matchStockItemWith(stockSymbol: String) -> UserStocksItem{
        let updatePortfolioVC = portfolioVC as! PortfolioVC
        var matchedStockItem : UserStocksItem?
        for userStockItem in updatePortfolioVC.userStocksCoreDataItems{
            if(userStockItem.stockSymbol == stockSymbol){
                matchedStockItem = userStockItem
                break
            }
        }
        return matchedStockItem!
    }
}
