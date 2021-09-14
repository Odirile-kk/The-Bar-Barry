//
//  OnboardingCollectionViewCell.swift
//  BarBerry
//
//  Created by Odirile Kekana on 2021/08/11.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: OnboardingCollectionViewCell.self)
    
    @IBOutlet weak var slideImgView: UIImageView!
    @IBOutlet weak var slideTitleLbl: UILabel!
    @IBOutlet weak var slideDescLbl: UILabel!

    
    func setUp(slide: OnboardingSlide) {
        
        slideImgView.image = slide.image
        slideTitleLbl.text = slide.title
        slideDescLbl.text = slide.description
    }

}
