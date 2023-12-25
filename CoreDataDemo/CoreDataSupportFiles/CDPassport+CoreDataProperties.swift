//
//  CDPassport+CoreDataProperties.swift
//  CoreDataDemo
//
//  Created by Vikas Salian on 26/12/23.
//
//

import Foundation
import CoreData


extension CDPassport {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDPassport> {
        return NSFetchRequest<CDPassport>(entityName: "CDPassport")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var passportID: String?
    @NSManaged public var placeOfIssue: String?
    @NSManaged public var toEmployee: CDEmployee?

}

extension CDPassport : Identifiable {

}
