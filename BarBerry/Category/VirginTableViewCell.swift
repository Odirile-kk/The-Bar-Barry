//
//  VirginTableViewCell.swift
//  BarBerry
//
//  Created by Odirile Kekana on 2021/08/26.
//

import UIKit

class VirginTableViewCell: UITableViewCell {
    @IBOutlet weak var vImg: UIImageView!
    
    @IBOutlet weak var vTitle: UILabel!
   // @IBOutlet weak var vType: UILabel!
    @IBOutlet weak var vBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func vBtnTapped(_ sender: Any) {
    }
    
}
