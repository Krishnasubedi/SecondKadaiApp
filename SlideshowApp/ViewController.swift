//
//  ViewController.swift
//  SlideshowApp
//
//  Created by Krishna Subedi on 2021/09/16.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
       
    @IBOutlet weak var nextBtn: UIButton!
    
    @IBOutlet weak var prevBtn: UIButton!
    
    @IBOutlet weak var playStopBtn: UIButton!
    
    var currentImageIndex:Int = 0
    
    var imageGallery: [UIImage] = []
    
    var timer: Timer!

    var timer_sec: Float = 0
    
    var isStopped: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        imageGallery = [UIImage(named: "cat1.png")!,
                        UIImage(named: "cat2.png")!,
                        UIImage(named: "cat3.jpeg")!,
                        UIImage(named: "cat4.jpg")!,
                        UIImage(named: "cat5.jpeg")!]
        
        imageView.image = imageGallery[currentImageIndex]

       
      let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleImageTap(_ :)))
        imageView.addGestureRecognizer(tapGesture)
        imageView.isUserInteractionEnabled = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(timer != nil){
            timer.invalidate()
        }
             
        let displayImageViewController : DisplayImageViewController = segue.destination as! DisplayImageViewController
        print(displayImageViewController)
        
        displayImageViewController.imageReceived = imageGallery[currentImageIndex]
       
    }    
        
    @objc func handleImageTap(_ tapGesture: UITapGestureRecognizer){
        self.performSegue(withIdentifier: "navigateToEnalargedImage", sender: self)
    }
    
    @IBAction func unwind(_ segue: UIStoryboardSegue) {
        imageView.image = imageGallery[currentImageIndex]
        nextBtn.isEnabled = true
        prevBtn.isEnabled = true
        playStopBtn.setTitle("再生", for: .normal)
        //timer = nil
    }
    
      
    @IBAction func displayNextImage(_ sender: Any) {
        
        currentImageIndex += 1
        if(currentImageIndex < imageGallery.count){
            imageView.image = imageGallery[currentImageIndex]
            
        }else {
            currentImageIndex = 0;
            imageView.image = imageGallery[currentImageIndex]
        }
    }
    
    @IBAction func displayPrevImage(_ sender: Any) {
        
        currentImageIndex -= 1
        
        if(currentImageIndex >= 0){
            imageView.image = imageGallery[currentImageIndex]
            
        }else {
            currentImageIndex = imageGallery.count-1;
            imageView.image = imageGallery[currentImageIndex]
        }
   }

    @objc func startSlide(_ timer : Timer){
        playStopBtn.setTitle("停止", for: .normal)
        nextBtn.isEnabled = false
        prevBtn.isEnabled = false
        
               
        currentImageIndex += 1
        
        if(currentImageIndex < imageGallery.count){
            imageView.image = imageGallery[currentImageIndex]
         
        } else {
            currentImageIndex = 0
        }
        
    }
    
    @IBAction func startSlideShow(_ sender: Any) {
        
        let displayingImageIndex :Int = currentImageIndex
        
        if self.timer == nil {
            self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(startSlide(_:)), userInfo: nil, repeats: true)
        }else {
            playStopBtn.setTitle("再生", for: .normal)
            nextBtn.isEnabled = true
            prevBtn.isEnabled = true
            self.timer.invalidate()
            currentImageIndex = displayingImageIndex
            self.timer = nil
        }
    }
 }

