//
//  QuoteView.swift
//  QuotePro
//
//  Created by Narendra Thapa on 2016-02-17.
//  Copyright © 2016 Narendra Thapa. All rights reserved.
//

import UIKit

class QuoteView: UIView {
    
    @IBOutlet weak var quoteImageView: UIImageView!
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var quoteAuthorLabel: UILabel!

    func setupWithImage(image: UIImage) {
        self.quoteImageView.image = image
    }
    
    func setupWithQuote(quote: String, author: String) {
        self.quoteLabel.text = quote
        self.quoteAuthorLabel.text = author
    }
    
    
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
