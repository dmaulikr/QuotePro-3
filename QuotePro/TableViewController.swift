//
//  TableViewController.swift
//  QuotePro
//
//  Created by Narendra Thapa on 2016-02-17.
//  Copyright © 2016 Narendra Thapa. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, NSURLConnectionDelegate {
    
    struct quoteImageElement {
        let quote: String
        let image: UIImage
        let author: String
    }
    
    var quoteAndImageArray = [quoteImageElement]()
    
    var quoteString = String()
    var quoteAuthor = String()
    var quoteImage = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataDownload()

        self.tableView.reloadData()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func dataDownload() {
        
        let session = NSURLSession.sharedSession()
        let url = NSURL(string: "https://unsplash.it/200/300/?random")
        let urlRequest = NSURLRequest(URL: url!)
        
        let datatask = session.dataTaskWithRequest(urlRequest) { (data, response, error) -> Void in
            let image = UIImage(data: data!)
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.quoteImage = image!
                self.quoteDownload()
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
                if let dict = try NSJSONSerialization.JSONObjectWithData(data! , options: []) as? NSDictionary {
                    
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        
                        self.quoteString = (dict["quoteText"] as? String)!
                        self.quoteAuthor = (dict["quoteAuthor"] as? String)!
                        self.saveOneQuoteToArray()

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
    
    func saveOneQuoteToArray() {
        let oneItem = quoteImageElement(quote: self.quoteString, image: self.quoteImage, author: self.quoteAuthor)
        self.quoteAndImageArray.append(oneItem)
        self.tableView.reloadData()

    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return quoteAndImageArray.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TableCell", forIndexPath: indexPath) as? TableViewCell
        let quote = quoteAndImageArray[indexPath.row]
        
        cell?.quoteCellLabel.text = quote.quote
        cell?.authorCellLabel.text = quote.author
        cell?.cellBackground.image = quote.image

        return cell!
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "ShowDetail" {
            let quoteDetailViewController = segue.destinationViewController as! DetailViewController
            // Get the cell that generated this segue.
            
            let indexPath = self.tableView.indexPathForSelectedRow
            if indexPath != nil {
            let selectedQuote = quoteAndImageArray[indexPath!.row]
                quoteDetailViewController.quote = selectedQuote.quote
                quoteDetailViewController.author = selectedQuote.author
                quoteDetailViewController.image = selectedQuote.image
                }
            }
        else if segue.identifier == "AddItem" {
    
            print("Adding new quote.")
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
