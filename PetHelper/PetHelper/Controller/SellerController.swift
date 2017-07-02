//
//  SellerController.swift
//  PetHelper
//
//  Created by Allen on 7/2/17.
//  Copyright © 2017 SUAY555. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage
import Darwin

class SellerController: UIViewController,UIImagePickerControllerDelegate,
UINavigationControllerDelegate {

    @IBOutlet weak var imgPet: UIImageView!
    
    @IBOutlet weak var txfAge: UITextField!
    
    @IBOutlet weak var txfAmount: UITextField!
    
    @IBOutlet weak var txfPrice: UITextField!
    
    @IBOutlet weak var txfSpecies: UITextField!
    
    @IBOutlet weak var txfRace: UITextField!
    
    @IBOutlet weak var txfExpDate: UITextField!
    
    @IBOutlet weak var txfAdopter: UITextField!
    
    @IBOutlet weak var navRightBarButton: UIBarButtonItem!
    
    let rootRef = Database.database().reference()
    var profilePic: UIImage?
    let picker = UIImagePickerController()
    var userAddress: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        navigationController?.navigationBar.barTintColor = UIColor(red: 62/255, green: 167/255, blue: 53/255, alpha: 1)

        //image picker setup
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(MemberInfoController.tapDetected))
        singleTap.numberOfTapsRequired = 1 // you can change this value
        imgPet.isUserInteractionEnabled = true
        imgPet.addGestureRecognizer(singleTap)
        
        
        //show existing info
        let condition = rootRef.child("sales_pet").child(Auth.auth().currentUser!.uid)
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
    
    
    @IBAction func updateInfo(_ sender: Any) {
        
        
        let key = rootRef.child("sales_pet").child(Auth.auth().currentUser!.uid).childByAutoId().key
       
        let condition = rootRef.child("user_info").child(Auth.auth().currentUser!.uid)
        //get seller address
        condition.observe( DataEventType.value, with: { (snapshot: DataSnapshot) in
            
            if let user = snapshot.value as? [String: AnyObject]{
                let info = UserModel()
                info.setValuesForKeys(user)
                let userAddress = info.address
                
                //update information
                let post = ["petAge": self.txfAge.text!,
                            "saleUserID": Auth.auth().currentUser!.uid,
                            "saleAddress": userAddress,
                            "salePrice": self.txfPrice.text!,
                            "saleAmount": self.txfAmount.text!,
                            "saleSpecies": self.txfSpecies.text!,
                            "saleRace": self.txfRace.text!,
                            "expDate": self.txfExpDate.text!,
                            "orderStatus": "false"]
                let childupdate = ["/\(key)": post]
                self.rootRef.child("sales_pet").updateChildValues(childupdate)
            }
        })
        
        
        let path = "PetSale/" + Auth.auth().currentUser!.uid + key + "/petpic.jpg"          //path save file in Storage, name folder is your ID user
        let storageRef = Storage.storage().reference(withPath: path )   // Create reference with path
        let metadata = StorageMetadata()                                //Create metadata of Storage file
        metadata.contentType="image/jpeg"                               //Content type
        storageRef.putData(UIImageJPEGRepresentation(profilePic!, 1.0)!, metadata: metadata) { (data,error) in //Upload file
            if error == nil {                       // if uploading not error, file is upload successfully
                print("Upload success!")
                //   self.AlertNotice(title: "Upload", message: "Upload Success")        //notice "Upload success"
                
            }
            else{
                print(error?.localizedDescription ?? "Error")
                print("Upload failed!")
                //  self.AlertNotice(title: "Upload", message: (error?.localizedDescription)!)
            }
            
        }
        

        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
