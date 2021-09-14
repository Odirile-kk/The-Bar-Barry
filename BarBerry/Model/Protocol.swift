//
//  Protocol.swift
//  BarBerry
//
//  Created by Odirile Kekana on 2021/08/26.
//

import Foundation

protocol DownloadData {
    
    func getData(completed: @escaping () -> ())
    
}
