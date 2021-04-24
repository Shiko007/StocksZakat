//
//  TotalVC.swift
//  StocksZakat
//
//  Created by Sherif Yasser on 28.03.21.
//

import UIKit

class TotalVC : UIViewController {
    
    var currencyExchangeRates : currencies?
    var portfolio : [String:stockData] = [:]{
        didSet{
            if(viewIsLoaded == true){
                handlePortfolioUpdate()
            }
        }
    }
    var viewIsLoaded : Bool = false
    
    @IBOutlet weak var totalZakatValue: UILabel!
    
    @IBOutlet weak var totalZakatCurrency: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.prefersLargeTitles = true
        viewIsLoaded = true
        handlePortfolioUpdate()
    }
    
    func handlePortfolioUpdate(){
        totalZakatValue.text = String(getTotalZakat())
        totalZakatCurrency.text = GenericConfiguration().preferedCurrency.uppercased()
    }
    
    func getTotalZakat() -> Int{
        var totalZakat : Double = 0
        for (_,data) in portfolio{
            totalZakat = totalZakat + ((data.price * data.userOwned) * (data.zakatPerStock / 100))
        }
        return Int(round(totalZakat * 0.025))
    }
}
