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
    var isEditingStock : Bool = false
    var inEditingStockItem : UserStocksItem?
    
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
            updatePortfolioVC.portfolio[stockSymbol] = stockNumber
            if(isEditingStock != true){
                UserStocksCoreData().createStockItem(stockSymbol: stockSymbol, stockCount: stockNumber)
            }else{
                if let updateStockItem = inEditingStockItem{
                    UserStocksCoreData().updateItem(item: updateStockItem, stockCount: stockNumber)
                }
            }
            updatePortfolioVC.loadStoredUserStockItems()
            stockOverView.youOwn.text = "You Own: " + String(stockNumber)
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
        configureAddEditButton()
    }
    
    func configureAddEditButton(){
        if(isEditingStock != true){
            addButton.backgroundColor = #colorLiteral(red: 0, green: 0.5229981542, blue: 0, alpha: 1)
            addButton.setTitle("Add", for: .normal)
        }else{
            addButton.backgroundColor = #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1)
            addButton.setTitle("Modify", for: .normal)
        }
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
