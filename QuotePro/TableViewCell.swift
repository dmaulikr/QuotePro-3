//
//  TableViewCell.swift
//  QuotePro
//
//  Created by Narendra Thapa on 2016-02-17.
//  Copyright © 2016 Narendra Thapa. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var quoteCellLabel: UILabel!
    @IBOutlet weak var authorCellLabel: UILabel!
    @IBOutlet weak var cellBackground: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
  //      self.accessoryView = nil
        
    }
//
//    override func layoutSubviews() {
//        self.contentView.frame = self.frame
//    }
    
        
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
