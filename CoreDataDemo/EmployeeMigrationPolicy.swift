//
//  EmployeeMigrationPolicy.swift
//  CoreDataDemo
//
//  Created by Vikas Salian on 26/12/23.
//

import Foundation
import CoreData

class EmployeeMigrationPolicy: NSEntityMigrationPolicy{
    
    override func createDestinationInstances(forSource sInstance: NSManagedObject, in mapping: NSEntityMapping, manager: NSMigrationManager) throws {
        if sInstance.entity.name == "CDEmployee"{
            let email = sInstance.value(forKey: "email") as? String
            let firstName = sInstance.value(forKey: "firstName") as? String
            let id = sInstance.value(forKey: "id") as? UUID
            let image = sInstance.value(forKey: "image") as? Data
            let price = sInstance.value(forKey: "price") as? String
            let passport = sInstance.value(forKey: "toPassport") as? CDPassport
            let vehicle = sInstance.value(forKey: "toVehicle") as? CDVehicle
            
            let newEntity = NSEntityDescription.insertNewObject(forEntityName: "CDEmployee", into: manager.destinationContext)
            
            newEntity.setValue(email, forKey: "email")
            newEntity.setValue(firstName, forKey: "firstName")
            newEntity.setValue(id, forKey: "id")
            newEntity.setValue(image, forKey: "image")
            newEntity.setValue(price?.toDecimal(), forKey: "price")
            newEntity.setValue(passport, forKey: "toPassport")
            newEntity.setValue(vehicle, forKey: "toVehicle")
         }
    }
}
