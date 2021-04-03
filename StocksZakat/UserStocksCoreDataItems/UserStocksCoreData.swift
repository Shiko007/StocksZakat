//
//  UserStocksCoreData.swift
//  StocksZakat
//
//  Created by Sherif Yasser on 04.04.21.
//

import UIKit


class UserStocksCoreData {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func loadStoredStocks() -> [UserStocksItem]{
        var userStockItems : [UserStocksItem] = []
        do {
            userStockItems   = try context.fetch(UserStocksItem.fetchRequest())
        } catch let error {
            print("Error \(error) while fetching persistent data")
        }
        return userStockItems
    }
    func createStockItem(stockSymbol: String,stockCount: Double){
        let newStockItem = UserStocksItem(context: context)
        newStockItem.stockSymbol = stockSymbol
        newStockItem.stocksCount = stockCount
        savePersistency()
    }
    func deleteStockItem(item: UserStocksItem){
        context.delete(item)
        savePersistency()
    }
    func updateItem(item: UserStocksItem,stockCount: Double){
        item.stocksCount = stockCount
        savePersistency()
    }
    
    func savePersistency(){
        
        do {
            try context.save()
        } catch let error {
            print("Error \(error) while saving persistent data")
        }
    }
}
