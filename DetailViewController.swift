//
//  DetailViewController.swift
//  QuotePro
//
//  Created by Narendra Thapa on 2016-02-17.
//  Copyright © 2016 Narendra Thapa. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailQuoteView: UIView!
    
    var quote = String()
    var author = String()
    var image = UIImage()
    
    var quoteViewDetails = QuoteView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
            if let objects = NSBundle.mainBundle().loadNibNamed("QuoteView", owner: nil, options: nil),
                let quoteView = objects.first as? QuoteView {
                    self.quoteViewDetails = quoteView
                    detailQuoteView.addSubview(quoteView)
                    
                    quoteView.frame.size.width = detailQuoteView.frame.size.width
                    quoteView.frame.size.height = detailQuoteView.frame.size.height
                    
                    self.quoteViewDetails.setupWithQuote(self.quote, author: self.author)
                    self.quoteViewDetails.setupWithImage(self.image)
            }

        // Do any additional setup after loading the view.
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
