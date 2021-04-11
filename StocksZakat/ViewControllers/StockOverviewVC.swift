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
    var stockDataInst = stockData(symbol: "", currency: "", price: 0, marketCap: 0, userOwned: 0, balanceSheetFillingDate: "", totalCurrentAssets: 0, totalNonCurrentAssets: 0)
    
    @IBOutlet weak var stockSymbolLabel: UILabel!
    
    @IBOutlet weak var reportedCurrencyLabel: UILabel!
    
    @IBOutlet weak var fillingDateLabel: UILabel!
    
    @IBOutlet weak var totalCurrentAssetLabel: UILabel!
    
    @IBOutlet weak var totalNonCurrentAssetLabel: UILabel!
    
    @IBOutlet weak var youOwn: UILabel!
    
    @IBOutlet weak var AddOrEditButton: UIButton!
    
    @IBAction func AddorEditButtonPressed(_ sender: Any) {
        if(self.stockDataAvailable == true){
            performSegue(withIdentifier: "stockOverviewtoAddorEdit", sender: self)
            AddOrEditButton.isHidden = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        UpdateAndDisplayStockInfo()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let stockAddEditView = segue.destination as! StockAddEditVC
        stockAddEditView.portfolioVC = portfolioVC
        stockAddEditView.stockSymbol = stockSymbol
        stockAddEditView.stockOverViewVC = self
        stockAddEditView.isEditingStock = stockAlreadyInPortfolio
        stockAddEditView.stockDataInst = stockDataInst
        if(stockAlreadyInPortfolio == true){
            let portfolioVCInstance = portfolioVC as! PortfolioVC
            stockAddEditView.inEditingStockItem = portfolioVCInstance.matchStockItemWith(stockSymbol: stockSymbol)
        }
    }
    
    func configureAddorRemoveButton(){
        let updatePortfolioVC = portfolioVC as! PortfolioVC
        if(updatePortfolioVC.portfolio[stockSymbol] != nil){
            AddOrEditButton.setTitle("Edit", for: .normal)
            AddOrEditButton.backgroundColor = #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1)
            stockAlreadyInPortfolio = true
        }else{
            AddOrEditButton.setTitle("Add", for: .normal)
            AddOrEditButton.backgroundColor = #colorLiteral(red: 0, green: 0.5229981542, blue: 0, alpha: 1)
            stockAlreadyInPortfolio = false
        }
    }
    
    func UpdateAndDisplayStockInfo(){
        let portfolioVCInstance = portfolioVC as! PortfolioVC
        self.stockSymbolLabel.adjustsFontSizeToFitWidth = true
        self.reportedCurrencyLabel.adjustsFontSizeToFitWidth = true
        self.fillingDateLabel.adjustsFontSizeToFitWidth = true
        self.totalCurrentAssetLabel.adjustsFontSizeToFitWidth = true
        self.totalNonCurrentAssetLabel.adjustsFontSizeToFitWidth = true
        self.youOwn.adjustsFontSizeToFitWidth = true

        balanceSheetNotAvailable = false
        StocksData().getCompanyBalanceSheet(company: stockSymbol){ [self] result in
            switch result{
            case .success(let balanceSheet):
                if(balanceSheet.isEmpty != true){
                    self.balanceSheetInfo = balanceSheet[0]
                    self.stockSymbolLabel.text = balanceSheet[0].symbol
                    self.stockDataInst.symbol = balanceSheet[0].symbol!
                    self.reportedCurrencyLabel.text = "Report Currency: " + balanceSheet[0].reportedCurrency!
                    self.stockDataInst.currency = balanceSheet[0].reportedCurrency!
                    self.fillingDateLabel.text = "Filling Date: " + balanceSheet[0].fillingDate!
                    self.stockDataInst.balanceSheetFillingDate = balanceSheet[0].fillingDate!
                    self.totalCurrentAssetLabel.text = "Total Current Assets: " + String(balanceSheet[0].totalCurrentAssets!)
                    self.stockDataInst.totalCurrentAssets = balanceSheet[0].totalCurrentAssets!
                    self.totalNonCurrentAssetLabel.text = "Total Non-Current Assets: " + String(balanceSheet[0].totalNonCurrentAssets!)
                    self.stockDataInst.totalNonCurrentAssets = balanceSheet[0].totalNonCurrentAssets!
                    self.youOwn.text = "You Own: " + String(portfolioVCInstance.portfolio[stockSymbol]?.userOwned ?? 0)
                    self.stockDataInst.userOwned = portfolioVCInstance.portfolio[stockSymbol]?.userOwned ?? 0
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
}
