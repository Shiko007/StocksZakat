//
//  UserStocksItem+CoreDataProperties.swift
//  StocksZakat
//
//  Created by Sherif Yasser on 04.04.21.
//
//

import Foundation
import CoreData


extension UserStocksItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserStocksItem> {
        return NSFetchRequest<UserStocksItem>(entityName: "UserStocksItem")
    }

    @NSManaged public var stocksCount: Double
    @NSManaged public var stockSymbol: String?

}

extension UserStocksItem : Identifiable {

}
