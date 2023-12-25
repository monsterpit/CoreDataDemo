//
//  Vehicle.swift
//  CoreDataDemo
//
//  Created by Vikas Salian on 25/12/23.
//

import Foundation

struct Vehicle{
    var id: UUID?
    var name: String?
    var type: String?
    var ownerName: String?
    
    init(id: UUID?, name: String?, type: String?, ownerName: String? = nil) {
        self.id = id
        self.name = name
        self.type = type
        self.ownerName = ownerName
    }
}
