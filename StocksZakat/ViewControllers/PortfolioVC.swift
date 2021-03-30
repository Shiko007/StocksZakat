//
//  ViewController.swift
//  StocksZakat
//
//  Created by Sherif Yasser on 28.03.21.
//

import UIKit

class PortfolioVC : UIViewController {
    
    var availableStocksSymbols : [String] = []
    
    
    @IBOutlet weak var userPortfolioTable: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextViewController = segue.destination as! AddStocksVC
        nextViewController.availableStocksSymbols = self.availableStocksSymbols
    }
}

