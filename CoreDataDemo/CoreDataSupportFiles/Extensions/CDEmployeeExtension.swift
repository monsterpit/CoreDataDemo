//
//  CDEmployeeExtension.swift
//  CoreDataDemo
//
//  Created by Vikas Salian on 19/12/23.
//

import Foundation

extension CDEmployee {
    func convertToEmployee() -> Employee{
        return Employee(name: firstName,id: id,email: email,image: image,passport: toPassport?.convertToPassport(), vehicle: toVehicle?.map{$0.convertToVehicle()})
    }
}
//@NSManaged public var toVehicle: NSSet? //MARK: One To Many we make it Set<CDVehicle> particular type confirmation because passing wrong value can crash
