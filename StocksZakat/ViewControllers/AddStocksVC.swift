//
//  AddStocksVC.swift
//  StocksZakat
//
//  Created by Sherif Yasser on 28.03.21.
//

import UIKit

class AddStocksVC : UIViewController {


    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var allSymbolsTable: UITableView!
    
    var availableStocksSymbols : [String] = []
    var searchSymbols: [String] = []
    var selectedSymbol : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchSymbols = availableStocksSymbols
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextView =  segue.destination as! StockOverviewVC
        nextView.stockSymbol = selectedSymbol
    }
}

extension AddStocksVC: UITableViewDataSource, UITableViewDelegate {
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchSymbols.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stocksSearchTableReuseIdentifier")
        cell?.textLabel?.text = searchSymbols[indexPath.row]
        return cell!
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedSymbol = searchSymbols[indexPath[1]]
        self.view.endEditing(true)
        performSegue(withIdentifier: "stockInfo", sender: self)
    }
}

extension AddStocksVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchSymbols = availableStocksSymbols.filter({$0.prefix(searchText.count) == searchText.uppercased()})
        allSymbolsTable.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
    }
}
