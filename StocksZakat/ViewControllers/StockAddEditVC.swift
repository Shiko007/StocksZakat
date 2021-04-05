//
//  StockAddEditVC.swift
//  StocksZakat
//
//  Created by Sherif Yasser on 04.04.21.
//

import UIKit

class StockAddEditVC : UIViewController {

    var portfolioVC : UIViewController?
    var stockOverViewVC : UIViewController?
    var stockNumber: Double = 0
    var stockSymbol: String = ""
    
    @IBOutlet weak var numberOfStocksField: UITextField! {
        didSet{
            numberOfStocksField?.addDoneCancelToolbar(onDone: (target: self, action: #selector(doneButtonTappedForNumberOfStocksField)), onCancel: (target: self , action: #selector(cancelButtonTappedForNumberOfStocksField)))
        }
    }
    
    @IBOutlet weak var addButton: UIButton!
    
    @IBOutlet weak var Cancel: UIButton!
    
    @IBAction func addButtonPressed(_ sender: Any) {
        if(stockNumber != 0){
            let updatePortfolioVC = portfolioVC as! PortfolioVC
            let stockOverView = self.stockOverViewVC as! StockOverviewVC
            updatePortfolioVC.portfolio[stockSymbol] = 0
            UserStocksCoreData().createStockItem(stockSymbol: stockSymbol, stockCount: stockNumber)
            updatePortfolioVC.loadStoredUserStockItems()
            stockOverView.AddOrEditButton.isHidden = false
            stockOverView.configureAddorRemoveButton()
            self.dismiss(animated: true)
        }
    }
    
    @IBAction func cancelPressed(_ sender: Any) {
        let stockOverView = self.stockOverViewVC as! StockOverviewVC
        stockOverView.AddOrEditButton.isHidden = false
        stockOverView.configureAddorRemoveButton()
        self.dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.isModalInPresentation = true
    }
    
    
}

extension StockAddEditVC : UITextFieldDelegate{
    
    @objc func doneButtonTappedForNumberOfStocksField(){
        if(isValidInputInNumberOfStocksField(textField: numberOfStocksField)){
            stockNumber = stringToDouble(text: numberOfStocksField.text ?? "")
            numberOfStocksField.resignFirstResponder()
        }else{
            
        }
    }
    
    @objc func cancelButtonTappedForNumberOfStocksField(){
        numberOfStocksField.text = ""
        numberOfStocksField.resignFirstResponder()
    }
    
    func isValidInputInNumberOfStocksField(textField: UITextField) -> Bool{
        var isValid = false
        if let userStockNumber = textField.text{
            if(userStockNumber.isNumeric){
                if(((!userStockNumber.contains(".")) && (userStockNumber.contains(",")) && (userStockNumber.filter{$0 == ","}.count == 1)) || ((!userStockNumber.contains(",")) && (userStockNumber.contains(".")) && (userStockNumber.filter{$0 == "."}.count == 1)) || ((!userStockNumber.contains(".")) && (!userStockNumber.contains(",")))){
                    isValid = true
                }
            }
        }
        return isValid
    }
    
    func stringToDouble(text: String) -> Double{
        var output : Double = 0
        if(text != ""){
            if(text.contains(",")){
                output = Double(text.replacingOccurrences(of: ",", with: ".")) ?? 0
            }
            else{
                output = Double(text) ?? 0
            }
        }
        return output
    }
}
