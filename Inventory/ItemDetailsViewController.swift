//
//  ItemDetailsViewController.swift
//  Inventory
//
//  Created by Admin on 2015-07-16.
//  Copyright (c) 2015 infoshare. All rights reserved.
//

import UIKit
import CoreData

class ItemDetailsViewController: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var itemType: UITextField!
    @IBOutlet weak var itemName: UITextField!
    @IBOutlet weak var itemDesc: UITextView!
    @IBOutlet weak var itemImage1: UIImageView!
    @IBOutlet weak var itemImage2: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var item : Item? = nil
    var newItem : Item? = nil
    var itemImagesArr :  [ItemImage] = []
    var tappedImage : UIImage? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if (item != nil)
        {
            itemType.text = item?.type
            itemName.text = item?.name
            //
            var context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext!
            var request2 = NSFetchRequest(entityName: "ItemImage")
            let predicate = NSPredicate(format: "belongsToItem == %@", item!)
            request2.predicate = predicate
            var results2 = context.executeFetchRequest(request2, error: nil)
            
            if results2 != nil
            {
                itemImagesArr = results2! as! [ItemImage]
                println(itemImagesArr)
            }
        }
        else {
            itemType.text = nil
            itemName.text = nil
            itemDesc.text = nil
            itemImage1.image = nil
            //itemImage2.image = nil
        }
        var image1TapRecognizer = UITapGestureRecognizer(target: self, action: "Image1Tap")
        self.itemImage1.addGestureRecognizer(image1TapRecognizer)
        //var image2TapRecognizer = UITapGestureRecognizer(target: self, action: "displayPhotos")
        //self.itemImage2.addGestureRecognizer(image2TapRecognizer)
        
        self.navigationController
    }
    func Image1Tap()
    {
        displayPhotos()
    }

    @IBAction func btnSelectImage1(sender: AnyObject) {

        displayPhotos()

    }
    
    @IBAction func tappedAdd(sender: AnyObject) {
        
        displayPhotos()
        
    }
    @IBAction func btnZoomImage1(sender: AnyObject) {
        
        self.tappedImage = self.itemImage1.image
        self.performSegueWithIdentifier("zoomSegue", sender: self)
        
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        var zoomViewController = segue.destinationViewController as! ZoomImageViewController
        zoomViewController.image = self.tappedImage
    }
    func displayPhotos()
    {
        var imagePicker = UIImagePickerController()
        
        var sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum
        
        if (UIImagePickerController.isSourceTypeAvailable(sourceType))
        {
            imagePicker.sourceType = sourceType
            imagePicker.delegate = self
            
            presentViewController(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        
        var image = info[UIImagePickerControllerOriginalImage] as! UIImage
        //
        saveItemImage(image)
        //
        dismissViewControllerAnimated(true, completion: nil)
    }
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    @IBAction func btnCancelDetails(sender: AnyObject) {
        
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    @IBAction func btnTrash(sender: AnyObject) {
        var context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext!
        
        var item = NSEntityDescription.insertNewObjectForEntityForName("Item", inManagedObjectContext: context) as! Item

        // ***** SAME CODE TO DELETE DATA FROM COREDATA *****
        // remove the deleted item from the model
//        let appDel:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
//        let context:NSManagedObjectContext = appDel.managedObjectContext!
//        context.deleteObject(myData[indexPath.row] as NSManagedObject)
//        myData.removeAtIndex(indexPath.row)
//        context.save(nil)
//        
//        //tableView.reloadData()
//        // remove the deleted item from the `UITableView`
//        self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        
    }
    @IBAction func btnSave(sender: AnyObject) {
        
        saveItem()
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    func saveItem()
    {
        var context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext!
        //
        var newItem = NSEntityDescription.insertNewObjectForEntityForName("Item", inManagedObjectContext: context) as! Item
        newItem.type = itemType.text
        newItem.name = itemName.text
        //
        context.save(nil)
    }
    func saveItemImage(img : UIImage)
    {
        var context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext!
        //
        var itemImg = NSEntityDescription.insertNewObjectForEntityForName("ItemImage", inManagedObjectContext: context) as! ItemImage
        //
        itemImg.imageDesc = "Image 1"
        itemImg.imageMain = UIImagePNGRepresentation(img)
        itemImg.belongsToItem = item!
        //
        context.save(nil)
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return itemImagesArr.count
    }
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        let cell: photoThumbnailCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("PhotoCell", forIndexPath: indexPath) as! photoThumbnailCollectionViewCell
//        if (indexPath.row == 1)
//        {
//            
//            for img in item!.hasImages
//            {
//                let img1 =  UIImage(data: img.imageMain)
//                cell.setThumbnailImage(img1!)
//            }
////            if self.itemImage1.image != nil
////            { cell.setThumbnailImage(self.itemImage1.image!) }
//        }
////        else
////        {
////            cell.setThumbnailImage(self.itemImage2.image!)
////        }
        //
        var image = UIImage(data: itemImagesArr[indexPath.row].imageMain)
        //var img = itemImagesArr[indexPath.row].imageMain as UIImage
        cell.setThumbnailImage(image!)
        //
        //cell.backgroundColor = UIColor.redColor()
        
        return cell
    }
}
