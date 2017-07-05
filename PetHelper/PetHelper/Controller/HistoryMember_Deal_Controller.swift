//
//  HistoryMember_Deal_Controller.swift
//  PetHelper
//
//  Created by Lu Tam Long on 7/4/17.
//  Copyright © 2017 SUAY555. All rights reserved.
//

import UIKit
import Firebase

class HistoryMember_Deal_Controller: UIViewController, UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var txfDoctor: UITextField!
    
    @IBOutlet weak var txfCost: UITextField!
    
    @IBOutlet weak var txfAddress: UITextField!
    
    var sessionID: String?
    let rootRef = Database.database().reference()

    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        navigationController?.navigationBar.barTintColor = UIColor(red: 62/255, green: 167/255, blue: 53/255, alpha: 1)
        
        
        //insert session ID here
        //sessionID =
        
        //show existing info
        let condition = rootRef.child("surgery_id").child(sessionID!)
        
        condition.observe( DataEventType.value, with: { (snapshot: DataSnapshot) in
            
            if let user = snapshot.value as? [String: AnyObject]{
                let info = DoctorCheckup()
                info.setValuesForKeys(user)
                let doctorID = info.doctorUserID
                self.txfCost.text = info.cost
                
                //get doctor info
                let doctorCondition = self.rootRef.child("user_info").child(doctorID!)
                doctorCondition.observe( DataEventType.value, with: { (snapshot: DataSnapshot) in
                    
                    if let doctor = snapshot.value as? [String: AnyObject]{
                        let doctorInfo = UserModel()
                        doctorInfo.setValuesForKeys(doctor)
                        self.txfDoctor.text = doctorInfo.userName
                        self.txfAddress.text = doctorInfo.address
                    }
                })
                
            }
        })

        
        // Do any additional setup after loading the view.
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
