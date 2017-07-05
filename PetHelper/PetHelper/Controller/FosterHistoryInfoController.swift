//
//  FosterHistoryInfoController.swift
//  PetHelper
//
//  Created by Lu Tam Long on 6/27/17.
//  Copyright © 2017 SUAY555. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage
import Darwin

class FosterHistoryInfoController: UIViewController {
    
    
    @IBOutlet weak var txfQty: UITextField!
    
    @IBOutlet weak var txfStartDate: UITextField!
    
    @IBOutlet weak var txfEndDate: UITextField!
    
    @IBOutlet weak var txfCost: UITextField!

    @IBOutlet weak var txfAnimal: UITextField!
    
    var sessionID: String?
    
    let rootRef = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = UIColor(red: 62/255, green: 167/255, blue: 53/255, alpha: 1)
        
        //insert sessionID here
        //sessionID = 
        
        //show existing info
        let condition = rootRef.child("foster_pet").child(Auth.auth().currentUser!.uid).child(sessionID!)
        
        condition.observe( DataEventType.value, with: { (snapshot: DataSnapshot) in
            
            if let user = snapshot.value as? [String: AnyObject]{
                let info = FosterPet()
                info.setValuesForKeys(user)
                self.txfQty.text = info.fosterQuantity
                self.txfStartDate.text = info.startDate
                self.txfEndDate.text = info.endDate
                self.txfCost.text = info.costPerDay
                self.txfAnimal.text = info.fosterSpecies
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
