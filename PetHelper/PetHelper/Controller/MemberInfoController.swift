//
//  MemberInfoController.swift
//  PetHelper
//
//  Created by Allen on 6/29/17.
//  Copyright © 2017 SUAY555. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage
import Darwin

class MemberInfoController: UIViewController,UIImagePickerControllerDelegate,
UINavigationControllerDelegate {

    @IBOutlet weak var imgUserProfile: UIImageView!
    
    @IBOutlet weak var txfUsername: UITextField!
    
    @IBOutlet weak var txfUserEmail: UITextField!
    
    @IBOutlet weak var txfUserPhone: UITextField!
    
    @IBOutlet weak var txfUserAddress: UITextField!
    
    @IBOutlet weak var btnUpdate: UIButton!
    
    @IBOutlet weak var btnHistory: UIButton!
    

    let rootRef = Database.database().reference()
    
    var profilePic = UIImage(named: "userprofile.jpg")
    let picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker.delegate = self
        //create buttons background
        btnUpdate.layer.borderWidth = 2
        btnUpdate.layer.borderColor = UIColor(red: 62/255, green: 167/255, blue: 53/255,alpha: 1).cgColor
        btnUpdate.layer.cornerRadius = 5
        btnUpdate.backgroundColor = UIColor(red: 62/255, green: 167/255, blue: 53/255, alpha: 1)
        
        
        btnHistory.layer.borderWidth = 2
        btnHistory.layer.borderColor = UIColor(red: 62/255, green: 167/255, blue: 53/255, alpha: 1).cgColor
        btnHistory.layer.cornerRadius = 5
        btnHistory.backgroundColor = UIColor(red: 62/255, green: 167/255, blue: 53/255, alpha: 1)

        navigationController?.navigationBar.barTintColor = UIColor(red: 62/255, green: 167/255, blue: 53/255, alpha: 1)


        
        imgUserProfile.layer.masksToBounds=true
        imgUserProfile.layer.borderWidth=1.5
        imgUserProfile.layer.borderColor = UIColor.gray.cgColor
        imgUserProfile.layer.cornerRadius=imgUserProfile.bounds.width/2
        
        
        //image picker setup
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(MemberInfoController.tapDetected))
        singleTap.numberOfTapsRequired = 1 // you can change this value
        imgUserProfile.isUserInteractionEnabled = true
        imgUserProfile.addGestureRecognizer(singleTap)
        
        let path = "Avatar/" + Auth.auth().currentUser!.uid + "/userprofile.jpg"          //path save file in Storage
        let storageRef = Storage.storage().reference(withPath: path )   //Create reference with path
       
        storageRef.getData(maxSize: INT64_MAX){ (data,error) in         //Get data file
            if error == nil {                                           //Download success
                print("Download success")
                self.imgUserProfile.image = UIImage(data: data!)                 //Show image downloaded
               // self.AlertNotice(title: "Download", message: "Download Success")
            }
            else {                              // if error will not show anymore
                print(error?.localizedDescription ?? "Error")
                print("Download failed")
              //   self.AlertNotice(title: "Error", message: (error?.localizedDescription)!)
            }
            
            
        }
        
        //show existing info
        let condition = rootRef.child("user_info").child(Auth.auth().currentUser!.uid)

        condition.observe( DataEventType.value, with: { (snapshot: DataSnapshot) in
            
            if let user = snapshot.value as? [String: AnyObject]{
                let info = UserModel()
                info.setValuesForKeys(user)
                self.txfUsername.text = info.userName
                self.txfUserAddress.text = info.address
                self.txfUserPhone.text = info.phoneNumber
                self.txfUserEmail.text = info.email
            }
        })

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func btnUpdatePressed(_ sender: Any) {
        //update data to realtime database
        let key = rootRef.child("user_info").child(Auth.auth().currentUser!.uid).key
        let post = ["userName": txfUsername.text!,
                    "email": txfUserEmail.text!,
                    "phoneNumber": txfUserPhone.text!,
                    "address": txfUserAddress.text!,
                    "isFirstTime": "false",
                    "userRole": "MEMBER"]
        let childupdate = ["/\(key)": post]
        rootRef.child("user_info").updateChildValues(childupdate)
        
        if (profilePic != nil){
        let path = "Avatar/" + Auth.auth().currentUser!.uid + "/userprofile.jpg"          //path save file in Storage, name folder is your ID user
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
        
        //transit to main member menu
            let storyboard = UIStoryboard(name: "MemberView", bundle: Bundle.main)
            let controller = storyboard.instantiateViewController(withIdentifier: "MemberBoard")
            self.present(controller, animated: true, completion: nil)
        

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
        
        profilePic = chosenPic
        imgUserProfile.contentMode = .scaleAspectFit
        imgUserProfile.image = chosenPic
        
        dismiss(animated:true, completion: nil) //5
    }
    
    
    func AlertNotice(title: String, message: String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
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
