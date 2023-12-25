//
//  Employee.swift
//  CoreDataDemo
//
//  Created by Vikas Salian on 19/12/23.
//

import Foundation

struct Employee{
      var name: String?
      var id: UUID?
      var email: String?
      var image: Data?
    
    var passport: Passport?
    var vehicle: [Vehicle]?
    
    init(name: String? = nil, id: UUID? = nil, email: String? = nil, image: Data? = nil, passport: Passport? = nil,vehicle: [Vehicle]?) {
        self.name = name
        self.id = id
        self.email = email
        self.image = image
        self.passport = passport
        self.vehicle = vehicle
    }
}
