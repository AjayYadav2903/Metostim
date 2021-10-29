//
//  GetFormulaData+CoreDataProperties.swift
//  
//
//  Created by User on 28/10/21.
//
//

import Foundation
import CoreData


extension GetFormulaData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GetFormulaData> {
        return NSFetchRequest<GetFormulaData>(entityName: "GetFormulaData")
    }

    @NSManaged public var birds_Code: Int32
    @NSManaged public var birds_Name: String?
    @NSManaged public var birdValue: Int32
    @NSManaged public var climate_code: Int32
    @NSManaged public var climate_Name: String?
    @NSManaged public var days: Int32
    @NSManaged public var formulaValue: Double

}
