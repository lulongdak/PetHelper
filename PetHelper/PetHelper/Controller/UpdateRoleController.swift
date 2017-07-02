//
//  UpdateRoleController.swift
//  PetHelper
//
//  Created by Lu Tam Long on 7/3/17.
//  Copyright © 2017 SUAY555. All rights reserved.
//

import UIKit
import Firebase

class UpdateRoleController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var role: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var name: UITextField!
    var id: String?
    let rootRef = Database.database().reference()
    let role_option: [String] = ["ADMIN","MEMBER","FOSTER","DOCTOR"]
    let picker = UIPickerView()
    
    @IBAction func UpdateRole(_ sender: Any) {
        
        let key = rootRef.child("user_info").child(id!).key
        let post = ["userName": name.text!,
                    "email": email.text!,
                    "phoneNumber": phone.text!,
                    "address": address.text!,
                    "isFirstTime": "false",
                    "userRole": role.text!]
        let childupdate = ["/\(key)": post]
        rootRef.child("user_info").updateChildValues(childupdate)
    
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        picker.dataSource = self
        role.inputView = picker
        if (id != nil)
        {
            let condition = rootRef.child("user_info").child(id!)
            
            condition.observe( DataEventType.value, with: { (snapshot: DataSnapshot) in
                
                if let user = snapshot.value as? [String: AnyObject]{
                    let info = UserModel()
                    info.setValuesForKeys(user)
                    self.name.text = info.userName
                    self.address.text = info.address
                    self.phone.text = info.phoneNumber
                    self.email.text = info.email
                    self.role.text = info.userRole
                }
            })

        }
        // Do any additional setup after loading the view.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return role_option.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return role_option[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        role.text = role_option[row]
        self.view.endEditing(false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
