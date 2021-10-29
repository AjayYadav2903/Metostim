//
//  GetBirdsTypeEntity+CoreDataProperties.swift
//  
//
//  Created by User on 28/10/21.
//
//

import Foundation
import CoreData


extension GetBirdsTypeEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GetBirdsTypeEntity> {
        return NSFetchRequest<GetBirdsTypeEntity>(entityName: "GetBirdsTypeEntity")
    }

    @NSManaged public var birds_Code: Int32
    @NSManaged public var birds_Image: String?
    @NSManaged public var birds_Name: String?
    @NSManaged public var climate_code: Int32
    @NSManaged public var climate_name: String?
    @NSManaged public var iD: Int32

}
