//
//  EmployeeManager.swift
//  CoreDataDemo
//
//  Created by Vikas Salian on 19/12/23.
//

import Foundation

struct EmployeeManager{
    
    private var employeeDataRepository: EmployeeDataRepository = EmployeeDataRepository()
    
    func createsMultipleEmployee(employee: [Employee]){
        employeeDataRepository.create(records: employee)
    }
 
    func createEmployee(employee: Employee){
        var employee = employee
        if !validPassport(passport: employee.passport){
            employee.passport = nil
        }
        employeeDataRepository.create(record: employee)
    }
    
    func fetchEmployees() -> [Employee]? {
        employeeDataRepository.getAll()
    }
    
    func fetchEmployee(id: UUID) -> Employee? {
        employeeDataRepository.get(byIdentifier: id)
    }
    
    func updateEmployee(employee: Employee) -> Bool{
        employeeDataRepository.update(record: employee)
    }
    
    func deleteEmployee(id: UUID) -> Bool{
        employeeDataRepository.delete(id: id)
    }
    
    func validPassport(passport: Passport?) -> Bool{
        
        if passport == nil || passport?.passportID?.isEmpty == true || passport?.placeOfIssue?.isEmpty == true{
            return false
        }
        return true
    }
}
