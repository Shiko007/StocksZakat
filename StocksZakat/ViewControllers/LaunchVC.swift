//
//  LaunchVC.swift
//  StocksZakat
//
//  Created by Sherif Yasser on 30.03.21.
//

import UIKit

class LaunchVC : UIViewController {
    //let nextViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "PortfolioVC")
    var availableStocksSymbols : [String] = []
    var symbolsLoadedFlag : Bool = false {
        didSet{
            if(symbolsLoadedFlag == true){
                self.dismiss(animated: false)
                self.performSegue(withIdentifier: "launchAPP", sender: self)
            }
        }
    }
    var symbolsLoadedRegionsCounter : Int = 0{
        didSet{
            if(symbolsLoadedRegionsCounter == StocksConfiguration().supportedStockRegions.count){
                symbolsLoadedFlag = true
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let tabController: UITabBarController = segue.destination as! UITabBarController
        let navController: UINavigationController = tabController.viewControllers![0] as! UINavigationController
        let nextViewController = navController.viewControllers[0] as! PortfolioVC
        nextViewController.availableStocksSymbols = self.availableStocksSymbols.sorted()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadStockSymbols()
    }
    
    func loadStockSymbols(){
        for region in StocksConfiguration().supportedStockRegions {
            StocksSymbols().getAllAvailableStocksSymbols(exchangeMarket: region) { result in
                switch result{
                case .success(let stocksSymbols):
                    for stockSymbol in stocksSymbols{
                        self.availableStocksSymbols.append(stockSymbol.displaySymbol!)
                    }
                    self.symbolsLoadedRegionsCounter += 1
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
}
