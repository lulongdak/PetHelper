//
//  HistoryMember_Foster_Controller.swift
//  PetHelper
//
//  Created by Lu Tam Long on 7/4/17.
//  Copyright © 2017 SUAY555. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage
import Darwin

class HistoryMember_Foster_Controller: UIViewController {

    
    @IBOutlet weak var txfFoster: UITextField!
    
    @IBOutlet weak var txfQty: UITextField!
    
    @IBOutlet weak var txfAddress: UITextField!
    
    var sessionID: String?
    let rootRef = Database.database().reference()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        navigationController?.navigationBar.barTintColor = UIColor(red: 62/255, green: 167/255, blue: 53/255, alpha: 1)
        
        
        
        
        //insert session ID here
        //sessionID =
        
        //show existing info
        let condition = rootRef.child("foster_id").child(sessionID!)
        
        condition.observe( DataEventType.value, with: { (snapshot: DataSnapshot) in
            
            if let user = snapshot.value as? [String: AnyObject]{
                let info = FosterPet()
                info.setValuesForKeys(user)
                let fosterID = info.fosterUserID
                self.txfQty.text = info.fosterQuantity
                
                //get doctor info
                let fosterCondition = self.rootRef.child("user_info").child(fosterID!)
                fosterCondition.observe( DataEventType.value, with: { (snapshot: DataSnapshot) in
                    
                    if let foster = snapshot.value as? [String: AnyObject]{
                        let fosterInfo = UserModel()
                        fosterInfo.setValuesForKeys(foster)
                        self.txfFoster.text = fosterInfo.userName
                        self.txfAddress.text = fosterInfo.address
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
