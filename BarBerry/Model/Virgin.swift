//
//  Virgin.swift
//  BarBerry
//
//  Created by Odirile Kekana on 2021/08/26.
//

import Foundation

struct VirginArray: Decodable {
    let drinks: [Virgin]
}

struct Virgin: Decodable {
    
    let strDrink: String
    let strDrinkThumb: String
}
