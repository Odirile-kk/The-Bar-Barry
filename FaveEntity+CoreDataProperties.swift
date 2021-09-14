//
//  FaveEntity+CoreDataProperties.swift
//  BarBerry
//
//  Created by Odirile Kekana on 2021/08/27.
//
//

import Foundation
import CoreData


extension FaveEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FaveEntity> {
        return NSFetchRequest<FaveEntity>(entityName: "FaveEntity")
    }

    @NSManaged public var barID: String?

}

extension FaveEntity : Identifiable {

}
