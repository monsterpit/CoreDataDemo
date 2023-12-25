//
//  CDVehicle+CoreDataProperties.swift
//  CoreDataDemo
//
//  Created by Vikas Salian on 26/12/23.
//
//

import Foundation
import CoreData


extension CDVehicle {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDVehicle> {
        return NSFetchRequest<CDVehicle>(entityName: "CDVehicle")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var type: String?
    @NSManaged public var toEmployee: CDEmployee?

}

extension CDVehicle : Identifiable {

}
