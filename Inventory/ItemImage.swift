//
//  ItemImage.swift
//  Inventory
//
//  Created by Admin on 2015-09-04.
//  Copyright (c) 2015 infoshare. All rights reserved.
//

import Foundation
import CoreData

class ItemImage: NSManagedObject {

    @NSManaged var imageDesc: String
    @NSManaged var imageMain: NSData
    @NSManaged var belongsToItem: Item

}
