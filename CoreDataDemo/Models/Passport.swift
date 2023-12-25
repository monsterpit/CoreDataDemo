//
//  Passport.swift
//  CoreDataDemo
//
//  Created by Vikas Salian on 19/12/23.
//

import Foundation

struct Passport{
    var id: UUID?
    var passportID: String?
    var placeOfIssue: String?
    var name: String?
    
    init(id: UUID? = nil, passportID: String? = nil, placeOfIssue: String? = nil, name: String? = nil) {
        self.id = id
        self.passportID = passportID
        self.placeOfIssue = placeOfIssue
        self.name = name
    }
}
