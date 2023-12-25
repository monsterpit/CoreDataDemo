//
//  EmployeeRepository.swift
//  CoreDataDemo
//
//  Created by Vikas Salian on 18/12/23.
//

import Foundation

protocol EmployeeRepository: BaseRepository{
    var maxVehicleCount: Int {get set}
}

struct EmployeeDataRepository: EmployeeRepository{
    
    typealias T = Employee
    
    var maxVehicleCount = 2
    
    func create(record employee: Employee) {
        let cdEmployee = CDEmployee(context: PersistantStorage.shared.context)
        
        if let vehicles = employee.vehicle,
           vehicles.count > 0{
            
            if vehicles.count > maxVehicleCount{
                debugPrint("Failed to save due to exceeding of max vehciles")
            }else{
                debugPrint("Below max vehciles count")
            }
            
            var vehicleSet = Set<CDVehicle>()
            
            vehicles.forEach { vehicle in
                let cdVehicle = CDVehicle(context: PersistantStorage.shared.context)
                cdVehicle.id = vehicle.id
                cdVehicle.name = vehicle.name
                cdVehicle.type = vehicle.type
                vehicleSet.insert(cdVehicle)
            }
            
            cdEmployee.toVehicle = vehicleSet
        }
        
        cdEmployee.firstName = employee.name
        cdEmployee.id = employee.id
        cdEmployee.email = employee.email
        cdEmployee.image = employee.image
        
        if let passport = employee.passport{
            let cdPassport = CDPassport(context: PersistantStorage.shared.context)
            cdPassport.id = passport.id
            cdPassport.passportID = passport.passportID
            cdPassport.placeOfIssue = passport.placeOfIssue
            
            cdEmployee.toPassport = cdPassport
        }
        
        PersistantStorage.shared.saveContext()
    }
    
    func getAll() -> [Employee]? {
        let result = PersistantStorage.shared.fetchModelObject(modelContext: CDEmployee.self)
        return result?.map{$0.convertToEmployee()}
    }
    
    func get(byIdentifier id: UUID) -> Employee? {
        let result = PersistantStorage.shared.fetchModelObject(modelContext: CDEmployee.self, id: id)
        return result?.convertToEmployee()
    }
    
    func update(record employee: Employee) -> Bool {
        guard let result = PersistantStorage.shared.fetchModelObject(modelContext: CDEmployee.self, id: employee.id) else { return false }
        
        if let vehicles = employee.vehicle,
           vehicles.count > 0 {
            
            if vehicles.count > maxVehicleCount{
                debugPrint("Failed to save due to exceeding of max vehciles")
                return false
            }else{
                debugPrint("Below max vehciles count")
            }
            
            var vehicleSet = Set<CDVehicle>()
            
            vehicles.forEach { vehicle in
                let cdVehicle = CDVehicle(context: PersistantStorage.shared.context)
                cdVehicle.id = vehicle.id
                cdVehicle.name = vehicle.name
                cdVehicle.type = vehicle.type
                vehicleSet.insert(cdVehicle)
            }
            
            result.toVehicle = vehicleSet
        }
        
        result.email = employee.email
        result.image = employee.image
        result.firstName = employee.name
        
        if let passport = employee.passport{
            let cdPassport = CDPassport(context: PersistantStorage.shared.context)
            cdPassport.id = passport.id
            cdPassport.passportID = passport.passportID
            cdPassport.placeOfIssue = passport.placeOfIssue
            
            result.toPassport = cdPassport
        }
        
        
        PersistantStorage.shared.saveContext()
        return true
    }
    
    func delete(id: UUID) -> Bool {
        guard let result = PersistantStorage.shared.fetchModelObject(modelContext: CDEmployee.self, id: id) else { return false }
        PersistantStorage.shared.context.delete(result)
        PersistantStorage.shared.saveContext()
        return true
    }
    
    
}
