//
//  QuoteAndImage.swift
//  QuotePro
//
//  Created by Narendra Thapa on 2016-02-17.
//  Copyright © 2016 Narendra Thapa. All rights reserved.
//

import UIKit

class QuoteAndImage: NSObject {
    
        let quote: String!
        let image: UIImage!
        let author: String!
    
    init(quote: String, image: UIImage, author: String) {
        self.quote = quote
        self.image = image
        self.author = author
    }

}
