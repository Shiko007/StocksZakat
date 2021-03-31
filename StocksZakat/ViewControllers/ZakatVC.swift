//
//  ZakatVC.swift
//  StocksZakat
//
//  Created by Sherif Yasser on 28.03.21.
//

import UIKit

class ZakatVC : UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }

    func getCompanyBalanceSheet(symbol: String) {
        StocksData().getCompanyBalanceSheet(company: "AAPL") { result in
            switch result{
            case .success(let balanceSheet):
                print(balanceSheet[0])
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
