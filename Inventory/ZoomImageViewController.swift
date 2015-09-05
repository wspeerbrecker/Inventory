//
//  ZoomImageViewController.swift
//  Inventory
//
//  Created by Admin on 2015-07-20.
//  Copyright (c) 2015 infoshare. All rights reserved.
//

import UIKit

class ZoomImageViewController: UIViewController, UIScrollViewDelegate {

    var image : UIImage? = nil
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.scrollView.minimumZoomScale = 1
        self.scrollView.maximumZoomScale = 50
        self.scrollView.delegate = self
        self.imageView.image = image!
    }

    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        
        return imageView
    }
}
