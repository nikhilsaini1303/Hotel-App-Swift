//
//  MyTableViewCell.swift
//  Assignment-1
//
//  Created by Nikhil Saini on 11/04/23.
//

import UIKit

class MyTableViewCell: UITableViewCell {
    
    static let identifier = "cell"
    
    @IBOutlet weak var fullNameLabel: UILabel!
    
    @IBOutlet weak var shortNameLabel: UILabel!
    
    @IBOutlet weak var displayNameLabel: UILabel!
    
    @IBOutlet weak var primaryNameLabel: UILabel!
    
    @IBOutlet weak var secondaryNameLabel: UILabel!
    
    @IBOutlet weak var lastNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
