//
//  ViewController.swift
//  CoreDataDemo
//
//  Created by Vikas Salian on 18/12/23.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    let employeeManager: EmployeeManager = EmployeeManager()
    var employees: [Employee]? = []
    override func viewDidLoad() {
        super.viewDidLoad()
    //   createEmployee()
        
        printDirectory()
        
        setupNavigationBar()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchEmployee()
        tableView.reloadData()
    }
    
    private func setupNavigationBar(){
        let addBarButton = UIBarButtonItem(image:  UIImage(systemName: "plus.app.fill"), style: .plain, target: self, action: #selector(handleAddEmployee))
        navigationItem.rightBarButtonItems = [addBarButton]
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
    
    func printDirectory(){
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        debugPrint(url!.absoluteString)
    }

    func createEmployee(){
       let employee =  CDEmployee(context: PersistantStorage.shared.context)
        employee.name = "Vikas"
        PersistantStorage.shared.saveContext()
    }

    func fetchEmployee(){
        employees = employeeManager.fetchEmployees()
    }
}

extension ViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employees?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmployeeTableViewCell", for: indexPath) as! EmployeeTableViewCell
       
        cell.setup(profileImage: UIImage(data: employees?[indexPath.row].image ?? Data()), name: employees?[indexPath.row].name ?? "", email: employees?[indexPath.row].email ?? "")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let addEmployeeVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddEmployeeVC") as! AddEmployeeVC
        addEmployeeVC.employee = employees?[indexPath.row]
        navigationController?.pushViewController(addEmployeeVC, animated: true)
    }
    
}
