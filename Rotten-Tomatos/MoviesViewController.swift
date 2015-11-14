//
//  MoviesViewController.swift
//  Rotten-Tomatos
//
//  Created by Anh-Tu Hoang on 11/12/15.
//  Copyright © 2015 hatu. All rights reserved.
//

import UIKit
import AFNetworking

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var movie = Movie()
    var refreshControl: UIRefreshControl!
    
    @IBOutlet weak var topErrorNotification: TopNotificationControl!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        // Do any additional setup after loading the view.
        startLoading()
        hideNotification()
        refreshData()
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "refreshData", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(self.refreshControl)
        
    }

    func hideNotification(){
        self.topErrorNotification.hidden=true
    }
    func showNotification(message: String){
        self.topErrorNotification.message = message
        self.topErrorNotification.hidden=false
    }
    
    func refreshData(){
        movie.getObjects() {(data, error) -> Void in
            
            guard error == nil else {
                switch error! {
                case RottenTomatosError.NoNetwork:
                    self.showNotification("No network")

                    
                case RottenTomatosError.WrongJsonFormatResult:
                    print("dont handle this yet")
                case RottenTomatosError.WrongUrlFormat:
                    print("dont handle this yet")
                }
                
                self.finishLoading()
                self.refreshControl.endRefreshing()

                return
            }
            
            self.tableView.reloadData()
            self.hideNotification()
            self.finishLoading()
            self.refreshControl.endRefreshing()
        }

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
    

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let movies = movie.movies {
            return movies.count
        }else{
            return 0
        }
    }
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MovieCell", forIndexPath: indexPath) as! MovieTableViewCell
        
        guard let movies = self.movie.movies else{
            return cell
        }
        
        let movie = movies[indexPath.row]
        cell.title = String(movie["title"]!)
        cell.synopsis = movie["synopsis"] as! String
        
        let posters = movie["posters"] as! [String:String]
        let url = NSURL(string: posters["thumbnail"]!)!
        

        let request = NSURLRequest(URL: url)
        
        cell.imgThumbnail.setImageWithURLRequest(request, placeholderImage: nil, success: { (req, res, img) -> Void in
            cell.imgThumbnail.image = img
            }, failure: { (req, res, error)->Void in
                print ("ERROR loading image", error)
        })
        

        return cell
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPathForCell(cell)!
        
        let movie = self.movie.movies![indexPath.row]
        
        let movieDetailsViewController = segue.destinationViewController as! MovieDetailsViewController
        movieDetailsViewController.movie = movie
    }
    
}
