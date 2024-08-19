//
//  CreateProfileVc.swift
//  CoreDataData
//
//  Created by SAIL on 05/08/24.
//

import UIKit

class CreateProfileVc: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var idNoTextField: UITextField!
    @IBOutlet weak var emailIdTextField: UITextField!
    @IBOutlet weak var saveButtonOutlet: UIButton!
    
    let CoreData = CoreDataCRUDFile.Shared
    var updateData = Person()
    var updateTime = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if updateTime{
            saveButtonOutlet.setTitle("Update", for: .normal)
            nameTextField.text = updateData.name
            idNoTextField.text = "\(updateData.id) (Not changeable)"
            emailIdTextField.text = updateData.emailId
            idNoTextField.isUserInteractionEnabled = false
        }else{
            nameTextField.text = ""
            idNoTextField.text = ""
            emailIdTextField.text = ""
            saveButtonOutlet.setTitle("Save", for: .normal)
            idNoTextField.isUserInteractionEnabled = true
        }
    }
    

    @IBAction func saveButton(_ sender: Any) {
        
        if updateTime{
            let idNumber = updateData.id
            if let newName = nameTextField.text, let newEmailId = emailIdTextField.text {
                CoreData.updateData(id: Int(idNumber), newEmailId: newEmailId, newName: newName) { result in
                    if result == true {
                        self.showAlert(title: "Success", message: "Details Updated", actionTitles: ["OK"], handlers: [
                            { action in
                                let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomePageVc") as! HomePageVc
                                self.navigationController?.pushViewController(vc, animated: true)
                            }
                        ])
                        print("Data updated successfully")
                    } else {
                        self.showAlert(title: "Error", message: "Data not Saved", actionTitles: ["OK"], handlers: [
                            { action in
                                let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomePageVc") as! HomePageVc
                                self.navigationController?.pushViewController(vc, animated: true)
                            }
                        ])
                    }
                }
            }
        }else{
            let idNumber = Int(idNoTextField.text ?? "")
            CoreData.createCoreData(name: nameTextField.text ?? "", emailID: emailIdTextField.text ?? "", id: idNumber ?? 0, createdAt: Date()){ result in
                if (result == true) {
                    
                    self.showAlert(title: "Data Saved", message: "see your profile in List", actionTitles: ["OK"], handlers: [
                        { action in
                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomePageVc") as! HomePageVc
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                    ])
                }else {
                    self.showAlert(title: "Error", message: "Data not Saved", actionTitles: ["OK"], handlers: [
                        { action in
                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomePageVc") as! HomePageVc
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                    ])
                }
            }
        }
    }

}

extension UIViewController {
    
    func showAlert(title: String, message: String, actionTitles: [String], actionStyles: [UIAlertAction.Style]? = nil, handlers: [((UIAlertAction) -> Void)?]) {
           let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
           
           for (index, title) in actionTitles.enumerated() {
               let style = actionStyles?[index] ?? .default
               let action = UIAlertAction(title: title, style: style, handler: handlers[index])
               alertController.addAction(action)
           }
           self.present(alertController, animated: true, completion: nil)
       }
}

