//
//  Movie.swift
//  Rotten-Tomatos
//
//  Created by Anh-Tu Hoang on 11/12/15.
//  Copyright © 2015 hatu. All rights reserved.
//

import Foundation

public enum RottenTomatosError: ErrorType {
    case NoNetwork
    case WrongJsonFormatResult
    case WrongUrlFormat
}

class Movie {
    static var apiUrl = "https://coderschool-movies.herokuapp.com/movies?api_key=xja087zcvxljadsflh214"
    
    var movies: [[String:AnyObject]]?
    
    func getObjects(callback: (data: [[String:AnyObject]]?, error: RottenTomatosError?) -> Void) -> Void{
        guard let url = NSURL(string: Movie.apiUrl) else {
            callback(data: nil, error: .WrongUrlFormat)
            return
        }
        
        //let url = NSURL(string: self.apiUrl)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url) {(data, response, error) -> Void in
            
            guard error == nil else {
                callback(data: nil, error: .NoNetwork)
                return
            }
            
            do{
                let json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! [String:AnyObject]
                self.movies = json["movies"] as! [[String:AnyObject]]

                print ("json:", json)
                callback(data: self.movies, error: nil)

            }catch  {
                print ("ERROR: cannot parse to JSON")
            }
        }
        
        task.resume()
    }
}