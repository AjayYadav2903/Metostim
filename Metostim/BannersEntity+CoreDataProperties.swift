//
//  BannersEntity+CoreDataProperties.swift
//  
//
//  Created by User on 28/10/21.
//
//

import Foundation
import CoreData


extension BannersEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BannersEntity> {
        return NSFetchRequest<BannersEntity>(entityName: "BannersEntity")
    }

    @NSManaged public var filename: String?
    @NSManaged public var fileStream: String?

}
