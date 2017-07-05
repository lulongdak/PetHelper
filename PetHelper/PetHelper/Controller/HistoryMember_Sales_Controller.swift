//
//  HistoryMember_Sales_Controller.swift
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

class HistoryMember_Sales_Controller: UIViewController {

    
    @IBOutlet weak var imgPet: UIImageView!
    
    @IBOutlet weak var txfAge: UITextField!
    
    @IBOutlet weak var txfPrice: UITextField!
    
    @IBOutlet weak var txfAmount: UITextField!
    
    @IBOutlet weak var txfSpecies: UITextField!
    
    @IBOutlet weak var txfRace: UITextField!
    
    @IBOutlet weak var txfExpDate: UITextField!
    
    @IBOutlet weak var txfAdopter: UITextField!
    
    
    var sessionID: String?
    let rootRef = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.barTintColor = UIColor(red: 62/255, green: 167/255, blue: 53/255, alpha: 1)
        //insert sessionID here
        //sessionID =
        
        //show existing info
        let condition = rootRef.child("sales_pet").child(Auth.auth().currentUser!.uid).child(sessionID!)
        //pass data ID from table here
        
        condition.observe( DataEventType.value, with: { (snapshot: DataSnapshot) in
            
            if let user = snapshot.value as? [String: AnyObject]{
                let info = PetTrade()
                info.setValuesForKeys(user)
                self.txfAge.text = info.petAge
                self.txfAmount.text = info.saleAmount
                self.txfPrice.text = info.salePrice
                self.txfSpecies.text = info.saleSpecies
                self.txfRace.text = info.saleRace
                self.txfExpDate.text = info.expDate
                
                let path = info.petPic          //path save file in Storage
                let storageRef = Storage.storage().reference(withPath: path! )   //Create reference with path
                
                storageRef.getData(maxSize: INT64_MAX){ (data,error) in         //Get data file
                    if error == nil {                                           //Download success
                        print("Download success")
                        self.imgPet.image = UIImage(data: data!)                 //Show image downloaded
                        // self.AlertNotice(title: "Download", message: "Download Success")
                    }
                    else {                              // if error will not show anymore
                        print(error?.localizedDescription ?? "Error")
                        print("Download failed")
                        //   self.AlertNotice(title: "Error", message: (error?.localizedDescription)!)
                    }
                }
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
