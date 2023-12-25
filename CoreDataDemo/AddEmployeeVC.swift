//
//  AddEmployeeVC.swift
//  CoreDataDemo
//
//  Created by Vikas Salian on 19/12/23.
//

import UIKit

class AddEmployeeVC: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passportIDTextField: UITextField!
    @IBOutlet weak var passportPlaceOfIssueTextField: UITextField!
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var saveEmployeeButton: UIButton!
    
    @IBOutlet weak var vehicleTextfield: UITextField!
    
    @IBOutlet weak var updateDeleteView: UIView!
    @IBOutlet weak var saveView: UIView!
    var employee: Employee?
    let employeeManager: EmployeeManager = EmployeeManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let employee = employee{
            nameTextField.text = employee.name
            emailTextField.text = employee.email
            passportIDTextField.text = employee.passport?.placeOfIssue
            passportPlaceOfIssueTextField.text = employee.passport?.placeOfIssue
            vehicleTextfield.text = ((employee.vehicle?.map{$0.name ?? ""}) ?? []).joined(separator: ",")
            
            profileImageView.image =  UIImage(data: employee.image ?? Data())
            
            updateDeleteView.isHidden = false
            saveView.isHidden = true
        }else{
            updateDeleteView.isHidden = true
            saveView.isHidden = false
        }
    }
    
    @IBAction func handleSaveEmployeeButton(_ sender: UIButton) {
        
        let passport = Passport(id:  UUID(),passportID: passportIDTextField.text,placeOfIssue: passportPlaceOfIssueTextField.text)
        
        let vehicles = vehicleTextfield.text?.split(separator: ",") ?? []
        let vehicleArr = vehicles.map{ Vehicle(id: UUID(), name: String($0), type: "Bike")}
        employeeManager.createEmployee(employee: Employee(name: nameTextField.text,id: UUID(),email: emailTextField.text,image: profileImageView.image?.pngData(),passport: passport, vehicle: vehicleArr))
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func handleUpdateEmployee(_ sender: UIButton) {
        let vehicles = vehicleTextfield.text?.split(separator: ",") ?? []
        let vehicleArr = vehicles.map{ Vehicle(id: UUID(), name: String($0), type: "Bike")}
        if employeeManager.updateEmployee(employee: Employee(name: nameTextField.text,id: employee?.id,email: emailTextField.text,image: profileImageView.image?.pngData(), vehicle: vehicleArr)){
            showAlert(message: "Updated Employee successfully")
        }else{
            showAlert(message: "Couldnt update Employee")
        }
    }
    
    @IBAction func handleDeleteEmployee(_ sender: UIButton) {
        if let id = employee?.id{
            if employeeManager.deleteEmployee(id: id){
                showAlert(message: "Deleted Employee successfully")
            }else{
                showAlert(message: "Couldnt delete Employee")
            }
        }else{
            showAlert(message: "Employee ID not found")
        }
    }
    
    @IBAction func handleProfileImageTap(_ sender: UITapGestureRecognizer) {
        let picker = UIImagePickerController()
            picker.allowsEditing = true
            picker.delegate = self
            present(picker, animated: true)
    }
    
    private func showAlert(message: String){
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let alertOkAction = UIAlertAction(title: "OK", style: .default){[weak self] action in
            guard let self else { return }
            self.nameTextField.resignFirstResponder()
            self.emailTextField.resignFirstResponder()
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(alertOkAction)
        self.present(alert, animated: true)
    }
    
}

extension AddEmployeeVC: UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        profileImageView.image = image
        dismiss(animated: true)

    }
}
