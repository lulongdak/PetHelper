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
    var petPic: UIImage?
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
        
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func updateInfo(_ sender: Any) {
        
        
        
        if (txfAge.text!.isNumber == false || txfAmount.text!.isNumber == false)
        {
            print("Quantity and deal must be a number");
        }
        else
        {
            self.navigationController?.popViewController(animated: true)
        }

        
         let key = rootRef.child("sales_pet").child(Auth.auth().currentUser!.uid).childByAutoId().key
        
        let path = "PetSale/" + Auth.auth().currentUser!.uid + key + "/petpic.jpg"          //path save file in Storage, name folder is your ID user
        
        let storageRef = Storage.storage().reference(withPath: path )   // Create reference with path
        let metadata = StorageMetadata()                                //Create metadata of Storage file
        metadata.contentType="image/jpeg"                               //Content type
        
       if(petPic == nil)
       {
            self.AlertNotice(title: "Error", message: "Please select image!")
            self.navigationController?.popViewController(animated: true)
        
        }
       else
       {
        
            storageRef.putData(UIImageJPEGRepresentation(petPic!, 1.0)!, metadata: metadata) { (data,error) in //Upload file
                if error == nil {                       // if uploading not error, file is upload successfully
                print("Upload success!")
                //   self.AlertNotice(title: "Upload", message: "Upload Success")        //notice "Upload success"
                //self.imgPet.image = UIImage(data: data!)
                
                }
                else{
                    print(error?.localizedDescription ?? "Error")
                    print("Upload failed!")
                //  self.AlertNotice(title: "Upload", message: (error?.localizedDescription)!)
                }
            
            }
        
        
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
                                "orderStatus": "false",
                                "petPic": path]
                    let childupdate = ["/\(key)": post]
                    self.rootRef.child("sales_pet").updateChildValues(childupdate)
                }
            })
        }
    }
    
    
    
    func tapDetected() {
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        let chosenPic = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        petPic = chosenPic
        self.imgPet.contentMode = .scaleAspectFit
        self.imgPet.image = chosenPic
        
        dismiss(animated:true, completion: nil) //5
    }
    
    
    func AlertNotice(title: String, message: String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
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
