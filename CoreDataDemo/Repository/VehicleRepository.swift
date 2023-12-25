//
//  VehicleRepository.swift
//  CoreDataDemo
//
//  Created by Vikas Salian on 25/12/23.
//

import Foundation
protocol VehicleRepository: BaseRepository{
}

struct VehicleDataRepository: VehicleRepository{
    typealias T = Vehicle
    
    
    func create(record: Vehicle) {
        let cdVehicle = CDVehicle(context: PersistantStorage.shared.context)
        cdVehicle.id = record.id
        cdVehicle.name = record.name
        cdVehicle.type = record.type
    }
    
    func getAll() -> [Vehicle]? {
        let result = PersistantStorage.shared.fetchModelObject(modelContext: CDVehicle.self)
        return result?.map{$0.convertToVehicle()}
    }
    
    func get(byIdentifier id: UUID) -> Vehicle? {
        let result = PersistantStorage.shared.fetchModelObject(modelContext: CDVehicle.self, id: id)
        return result?.convertToVehicle()
    }
    
    func update(record vehicle: Vehicle) -> Bool {
        guard let result = PersistantStorage.shared.fetchModelObject(modelContext: CDVehicle.self, id: vehicle.id) else { return false }
        result.name = vehicle.name
        result.type = vehicle.type
    
        PersistantStorage.shared.saveContext()
        return true
    }
    
    func delete(id: UUID) -> Bool {
        guard let result = PersistantStorage.shared.fetchModelObject(modelContext: CDVehicle.self, id: id) else { return false }
        PersistantStorage.shared.context.delete(result)
        return true
    }
    
    
    
    
}
