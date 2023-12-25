//
//  CDPassportExtension.swift
//  CoreDataDemo
//
//  Created by Vikas Salian on 19/12/23.
//

import Foundation

extension CDPassport {
    func convertToPassport() -> Passport{
        return  Passport(id: id,passportID: passportID,placeOfIssue: placeOfIssue,name:  toEmployee?.firstName )
    }
}
