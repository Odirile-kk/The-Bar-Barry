//
//  NonVTableViewCell.swift
//  BarBerry
//
//  Created by Odirile Kekana on 2021/08/26.
//

import UIKit

class NonVTableViewCell: UITableViewCell {

    @IBOutlet weak var nvImg: UIImageView!
    @IBOutlet weak var nvTitle: UILabel!
    @IBOutlet weak var nvType: UILabel!
    @IBOutlet weak var nvBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func nvBtnTapped(_ sender: Any) {
    }
}
