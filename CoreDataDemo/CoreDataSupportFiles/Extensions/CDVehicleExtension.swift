//
//  CDVehicleExtension.swift
//  CoreDataDemo
//
//  Created by Vikas Salian on 25/12/23.
//

import Foundation

extension CDVehicle{
    func convertToVehicle() -> Vehicle{
        return  Vehicle(id: id,name: name,type: type)
    }
}
