//
//  ViewController.swift
//  QuotePro
//
//  Created by Narendra Thapa on 2016-02-17.
//  Copyright © 2016 Narendra Thapa. All rights reserved.
//

import UIKit

class ViewController: UIViewController, NSURLConnectionDelegate {
    
    var data = NSMutableData()
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var quoteLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.orangeColor()
        dataDownload()
        quoteDownload()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        dataDownload()
        quoteDownload()
    }

    func startConnection() {
//      NSURLSession *session = [NSURLSession sharedSession];
        let session = NSURLSession.sharedSession()
        
//      NSString *urlString = @"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/in_theaters.json?apikey=c9zzxwtuc3q2tftqata3k59w";
        let url = NSURL(string: "http://api.rottentomatoes.com/api/public/v1.0/lists/movies/in_theaters.json?apikey=c9zzxwtuc3q2tftqata3k59w")

//      NSURL *url = [NSURL URLWithString:urlString];
//      NSURLRequest *urlRequest = NSURLRequest requestWithURL:url
        let urlRequest = NSURLRequest(URL: url!)
        
        let datatask = session.dataTaskWithRequest(urlRequest) { (data, response, error) -> Void in
            if let dict = try! NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSDictionary {
                print(dict)
            } else {
                print("Could not read JSON dictionary")
            }
        }
        datatask.resume()
    }
    
    func dataDownload() {

        let session = NSURLSession.sharedSession()
        let url = NSURL(string: "https://unsplash.it/200/300/?random")
        let urlRequest = NSURLRequest(URL: url!)
        let datatask = session.dataTaskWithRequest(urlRequest) { (data, response, error) -> Void in
            let image = UIImage(data: data!)
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.imageView.image = image
            })
            
            print(image)
        }
        datatask.resume()
    }

    func quoteDownload() {
        let session = NSURLSession.sharedSession()
        let url = NSURL(string: "http://api.forismatic.com/api/1.0/?method=getQuote&lang=en&format=json")
        let urlRequest = NSURLRequest(URL: url!)
        
        let datatask = session.dataTaskWithRequest(urlRequest) { (data, response, error) -> Void in

            do {
                if let dict = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSDictionary {
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.quoteLabel.text = dict["quoteText"] as? String
                    })
                    print(dict)
                } else {
                    print("Could not read JSON dictionary")
                }
            } catch _ {
                print("Bad quote!")
                self.quoteDownload()
            }
        }
        datatask.resume()
    }

    
    
    func connection(connection: NSURLConnection!, didReceiveData data: NSData!){
        self.data.appendData(data)
    }
    
    func buttonAction(sender: UIButton!){
        startConnection()
    }
    
//    func connectionDidFinishLoading(connection: NSURLConnection!) {
//        var err: NSError
//        // throwing an error on the line below (can't figure out where the error message is)
//        var jsonResult: NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
//        print(jsonResult)
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }

    @IBAction func newImageButtonPressed(sender: UIButton) {
        dataDownload()
        
    }
    
    
    @IBAction func newQuoteButtonPressed(sender: UIButton) {
        
        quoteDownload()
    }
    
    

}

