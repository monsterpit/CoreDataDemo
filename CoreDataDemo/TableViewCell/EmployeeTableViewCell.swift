//
//  EmployeeTableViewCell.swift
//  CoreDataDemo
//
//  Created by Vikas Salian on 19/12/23.
//

import UIKit

class EmployeeTableViewCell: UITableViewCell {
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var employeeName: UILabel!
    @IBOutlet weak var employeeEmail: UILabel!
    
    func setup(profileImage: UIImage?,name: String,email: String){
        profileImageView.image = profileImage
        employeeName.text = name
        employeeEmail.text = email
    }
}
