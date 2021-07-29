//
//  ViewTableViewCell.swift
//  BarBerry
//
//  Created by Odirile Kekana on 2021/07/21.
//

import UIKit



class ViewTableViewCell: UITableViewCell {

    @IBOutlet weak var drinkImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var categoryLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
