//
//  CDEmployee+CoreDataProperties.swift
//  CoreDataDemo
//
//  Created by Vikas Salian on 26/12/23.
//
//

import Foundation
import CoreData


extension CDEmployee {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDEmployee> {
        return NSFetchRequest<CDEmployee>(entityName: "CDEmployee")
    }

    @NSManaged public var email: String?
    @NSManaged public var firstName: String?
    @NSManaged public var id: UUID?
    @NSManaged public var image: Data?
    @NSManaged public var price: NSDecimalNumber?
    @NSManaged public var toPassport: CDPassport?
    @NSManaged public var toVehicle: Set<CDVehicle>?

}

// MARK: Generated accessors for toVehicle
extension CDEmployee {

    @objc(addToVehicleObject:)
    @NSManaged public func addToToVehicle(_ value: CDVehicle)

    @objc(removeToVehicleObject:)
    @NSManaged public func removeFromToVehicle(_ value: CDVehicle)

    @objc(addToVehicle:)
    @NSManaged public func addToToVehicle(_ values: Set<CDVehicle>)

    @objc(removeToVehicle:)
    @NSManaged public func removeFromToVehicle(_ values: Set<CDVehicle>)

}

extension CDEmployee : Identifiable {

}
