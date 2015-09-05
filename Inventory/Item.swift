//
//  Item.swift
//  Inventory
//
//  Created by Admin on 2015-09-03.
//  Copyright (c) 2015 infoshare. All rights reserved.
//

import Foundation
import CoreData

class Item: NSManagedObject {

    @NSManaged var category: String
    @NSManaged var desc: String
    @NSManaged var name: String
    @NSManaged var type: String
    @NSManaged var hasImages: NSSet

}
