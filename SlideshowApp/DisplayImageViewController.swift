//
//  DisplayImageViewController.swift
//  SlideshowApp
//
//  Created by Krishna Subedi on 2021/09/18.
//

import UIKit

class DisplayImageViewController: UIViewController {
    
    @IBOutlet weak var imageViewEnlarged: UIImageView!
    
    var imageReceived : UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(self.imageReceived != nil){
            
            self.imageViewEnlarged.image = imageReceived
       
        }
    }
    
}
