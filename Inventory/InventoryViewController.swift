//
//  ViewController.swift
//  Inventory
//
//  Created by Admin on 2015-07-16.
//  Copyright (c) 2015 infoshare. All rights reserved.
//

import UIKit
import CoreData

class InventoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var itemsArr: [Item] = []
    var itemImagesArr: [ItemImage] = []
    var selectedItem : Item? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tableView.dataSource = self
        self.tableView.delegate = self
    
        //createItems()
        
        var context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext!
        var request = NSFetchRequest(entityName: "Item")
        var results = context.executeFetchRequest(request, error: nil)
        
        if results != nil
        {
            itemsArr = results! as! [Item]
            //
            println("Cnt: \(itemsArr.count)")
            for itm in itemsArr
            {
                println(itm.type)
                println(itm.name)
                println("Cnt: \(itm.hasImages.count)")
                var request2 = NSFetchRequest(entityName: "ItemImage")
                let predicate = NSPredicate(format: "belongsToItem == %@", itm)
                request2.predicate = predicate
                var results2 = context.executeFetchRequest(request2, error: nil)
                
                if results2 != nil
                {
                    itemImagesArr = results2! as! [ItemImage]
                    println(itemImagesArr)
                }
//                let imgs = itm.hasImages.allObjects as! [ItemImage]
//                
//                //println("hasImages: \(itm.hasImages)")
//               for img in imgs
//                {
//                    println(img)
//                }
            }
        }


    }
    
    @IBAction func btnAdd(sender: AnyObject) {
        
        selectedItem = nil
        self.performSegueWithIdentifier("itemDetailsSegue", sender: self)
        
    }
    func createItems()
    {
        var context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext!
        
        var item = NSEntityDescription.insertNewObjectForEntityForName("Item", inManagedObjectContext: context) as! Item
        item.type = "RC EQUIPMENT"
        item.name = "TREX 550 FBL"
        //
        context.save(nil)
        //
        var itemImage1 = NSEntityDescription.insertNewObjectForEntityForName("ItemImage", inManagedObjectContext: context) as! ItemImage
        itemImage1.imageMain = UIImageJPEGRepresentation(UIImage(named: "TREX450PRO.jpg"), 1)
        itemImage1.imageDesc = "HELI PHOTO 1"
        itemImage1.belongsToItem = item
        //
        context.save(nil)
        //
        var itemImage2 = NSEntityDescription.insertNewObjectForEntityForName("ItemImage", inManagedObjectContext: context) as! ItemImage
        itemImage2.imageMain = UIImageJPEGRepresentation(UIImage(named: "default.png"), 1)
        itemImage2.imageDesc = "HELI PHOTO 2"
        itemImage2.belongsToItem = item
        //
        context.save(nil)
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.itemsArr.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell()
        cell.textLabel?.text = "Row \(indexPath.row)"
        //cell.textLabel?.text  = self.itemsArr[indexPath.row].name
//        cell.imageView?.image = UIImage(data: self.itemsArr[indexPath.row].image1)

        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        selectedItem = self.itemsArr[indexPath.row]
        self.performSegueWithIdentifier("itemDetailsSegue", sender: self)
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        var itemDetailsViewController = segue.destinationViewController as! ItemDetailsViewController
        itemDetailsViewController.item = selectedItem
        
    }
}

