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
    var isSearching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    

}

extension AddStocksVC: UITableViewDataSource, UITableViewDelegate {
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching{
            return searchSymbols.count
        }
        else{
            return availableStocksSymbols.count
        }
        
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stocksSearchTableReuseIdentifier")
        if isSearching{
            cell?.textLabel?.text = searchSymbols[indexPath.row]
        }
        else{
            cell?.textLabel?.text = availableStocksSymbols[indexPath.row]
        }
        return cell!
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isSearching{
            print(searchSymbols[indexPath[1]])
        }
        else{
            print(availableStocksSymbols[indexPath[1]])
        }
    }
}

extension AddStocksVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchSymbols = availableStocksSymbols.filter({$0.prefix(searchText.count) == searchText})
        isSearching = true
        allSymbolsTable.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
    }
}
