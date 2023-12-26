//
//  ViewController.swift
//  CoreDataDemo
//
//  Created by Vikas Salian on 18/12/23.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
   
    lazy var employeeProvider = {
        EmloyeeProvider(fetchedResultControllerDelegate: self)
    }()
    
    var employeeManager = EmployeeManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        printDirectory()
        
        setupNavigationBar()
        setupTableView()
    }
    
    private func setupNavigationBar(){
        let addBarButton = UIBarButtonItem(image:  UIImage(systemName: "plus.app.fill"), style: .plain, target: self, action: #selector(handleAddEmployee))
        
        let newBarButton = UIBarButtonItem(image:  UIImage(systemName: "square.and.arrow.up.fill"), style: .plain, target: self, action: #selector(handleAddMultipleEmployees))
        navigationItem.rightBarButtonItems = [addBarButton,newBarButton]
    }
    
    private func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "EmployeeTableViewCell", bundle: nil), forCellReuseIdentifier: "EmployeeTableViewCell")
    }
    
    
    @objc func handleAddEmployee(){
        let addEmployeeVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddEmployeeVC") as! AddEmployeeVC
        navigationController?.pushViewController(addEmployeeVC, animated: true)
    }
    
    @objc func handleAddMultipleEmployees(){
        let emp1 = Employee(name: "Wow1",id: UUID(),email: "Wow1", vehicle: nil)
        let emp2 =  Employee(name: "Wow2",id: UUID(),email: "Wow2", vehicle: nil)
        let emp3 =  Employee(name: "Wow3",id: UUID(),email: "Wow3", vehicle: nil)
        let emp4 =  Employee(name: "Wow4",id: UUID(),email: "Wow4", vehicle: nil)
        employeeManager.createsMultipleEmployee(employee: [emp1,emp2,emp3,emp4])
    }
    
    func printDirectory(){
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        debugPrint(url!.absoluteString)
    }

    func createEmployee(){
       let employee =  CDEmployee(context: PersistantStorage.shared.context)
        employee.firstName = "Vikas"
        PersistantStorage.shared.saveContext()
    }

}

extension ViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employeeProvider.fetchedResultController.fetchedObjects?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmployeeTableViewCell", for: indexPath) as! EmployeeTableViewCell
        let employee = employeeProvider.fetchedResultController.object(at: indexPath).convertToEmployee()
        cell.setup(profileImage: UIImage(data: employee.image ?? Data()), name: employee.name ?? "", email: employee.email ?? "")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let addEmployeeVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddEmployeeVC") as! AddEmployeeVC
        addEmployeeVC.employee = employeeProvider.fetchedResultController.object(at: indexPath).convertToEmployee()
        navigationController?.pushViewController(addEmployeeVC, animated: true)
    }
    
}


extension ViewController: NSFetchedResultsControllerDelegate{
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.reloadData()
    }
}
