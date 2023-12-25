//
//  PassportRepository.swift
//  CoreDataDemo
//
//  Created by Vikas Salian on 19/12/23.
//

import Foundation

protocol PassportRepository: BaseRepository{
}


struct PassportDataRepository: PassportRepository{
    
    typealias T = Passport
    
    func create(record passport: Passport) {
        let cdPassport = CDPassport(context: PersistantStorage.shared.context)
        cdPassport.id = passport.id
        cdPassport.passportID = passport.passportID
        cdPassport.placeOfIssue = passport.placeOfIssue
    }
    
    func getAll() -> [Passport]? {
        let result = PersistantStorage.shared.fetchModelObject(modelContext: CDPassport.self)
        return result?.map{$0.convertToPassport()}
    }
    
    func get(byIdentifier id: UUID) -> Passport? {
        let result = PersistantStorage.shared.fetchModelObject(modelContext: CDPassport.self, id: id)
        return result?.convertToPassport()
    }
    
    func update(record passport: Passport) -> Bool {
        guard let result = PersistantStorage.shared.fetchModelObject(modelContext: CDPassport.self, id: passport.id) else { return false }
        result.passportID = passport.passportID
        result.placeOfIssue = passport.placeOfIssue
        
        PersistantStorage.shared.saveContext()
        return true
    }
    
    func delete(id: UUID) -> Bool {
        guard let result = PersistantStorage.shared.fetchModelObject(modelContext: CDPassport.self, id: id) else { return false }
        PersistantStorage.shared.context.delete(result)
        return true
    }
    
}
