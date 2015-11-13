//
//  MovieDetailsViewController.swift
//  Rotten-Tomatos
//
//  Created by Anh-Tu Hoang on 11/13/15.
//  Copyright © 2015 hatu. All rights reserved.
//

import UIKit
import AFNetworking

class MovieDetailsViewController: UIViewController {

    var movie: [String:AnyObject]!{
        didSet{
            
        }
    }
        
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var imgImage: UIImageView!
    @IBOutlet weak var lblSynopsis: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        lblTitle.text = movie["title"] as! String
        lblSynopsis.text = movie["synopsis"] as! String
        
        let posters = self.movie["posters"] as! [String:String]
        let url = NSURL(string: posters["detailed"]!)!
        
        let request = NSURLRequest(URL: url)
        self.startLoading()
        
        imgImage.setImageWithURLRequest(request, placeholderImage: nil, success: { (req, res, img) -> Void in
                self.imgImage.image = img
                self.finishLoading()
            }, failure: { (req, res, error)->Void in
                print ("ERROR loading image", error)
        })
        
    }

    func startLoading(){
        self.activityIndicator.hidden=false
        self.activityIndicator.startAnimating()
    }
    
    func finishLoading(){
        self.activityIndicator.hidden=true
        self.activityIndicator.stopAnimating()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
