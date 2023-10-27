//
//  CategoriesTableViewCell.swift
//  MovieDataBaseApp
//
//  Created by Shubhransh Gupta on 27/10/23.
//

import UIKit

class CategoriesTableViewCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var buttonlabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func showButton(visibility : Bool) {
        self.buttonlabel.isHidden = !visibility
    }
    
}
