//
//  FaveTableViewCell.swift
//  BarBerry
//
//  Created by Odirile Kekana on 2021/08/06.
//

import UIKit

class FaveTableViewCell: UITableViewCell {

    
    @IBOutlet weak var favImg: UIImageView!
    @IBOutlet weak var favLbl: UILabel!
    @IBOutlet weak var favType: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
