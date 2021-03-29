//
//  AddStocksVC.swift
//  StocksZakat
//
//  Created by Sherif Yasser on 28.03.21.
//

import UIKit

class AddStocksVC : UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        StocksData().getCompanyBalanceSheet(company: "AAPL") { result in
            switch result{
            case .success(let balanceSheet):
                print(balanceSheet[0].symbol!)
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
