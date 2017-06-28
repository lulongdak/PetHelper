//
//  ViewController.swift
//  PetHelper
//
//  Created by Lu Tam Long on 6/10/17.
//  Copyright © 2017 SUAY555. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import GoogleMaps

class ViewController: UIViewController {

        
    
    @IBOutlet weak var btnLogIn: UIButton!
    
    @IBOutlet weak var btnSignUp: UIButton!
    
    @IBOutlet weak var txfEmail: UITextField!
    
    @IBOutlet weak var txfPassword: UITextField!
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        btnLogIn.layer.borderWidth = 2
        btnLogIn.layer.borderColor = UIColor.white.cgColor
        btnLogIn.layer.cornerRadius = 5
        btnLogIn.backgroundColor = UIColor.white

        // Do any additional setup after loading the view, typically from a nib.
    }
        
    /*@IBAction func Gotomap(_ sender: Any) {
        let storyboar = UIStoryboard(name: "MapView", bundle: Bundle.main)
        let controller = storyboar.instantiateViewController(withIdentifier: "MapView")
        self.present(controller, animated: true, completion: nil)

    }
    @IBAction func gotoDoctorView(_ sender: Any) {
        let storyboar = UIStoryboard(name: "DoctorView", bundle: Bundle.main)
        let controller = storyboar.instantiateViewController(withIdentifier: "DoctorBoard")
        self.present(controller, animated: true, completion: nil)

    }*/
    
    
    

 
    @IBAction func btnLoginPressed(_ sender: Any) {
        
        Auth.auth().signIn(withEmail: txfEmail.text!,password: txfPassword.text!) { user, error in
            if error == nil
            {
                
                
                
                //if first time logged in
                let rootRef = Database.database().reference()
               
                
                let userID = Auth.auth().currentUser?.uid
                rootRef.child("user_info").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
                    // Get user value
                    let value = snapshot.value as? NSDictionary
                    let userRole = value?["userRole"] as? String ?? ""
                    let firstTime = value?["isFirstTime"] as? String ?? ""
                    
                    if(userRole.isEqual("DOCTOR"))
                    {
                        let storyboard = UIStoryboard(name: "DoctorView", bundle: Bundle.main)
                        let controller = storyboard.instantiateViewController(withIdentifier: "DoctorBoard")
                        self.present(controller, animated: true, completion: nil)
                    }
                    else if (userRole.isEqual("FOSTER"))
                    {
                        let storyboard = UIStoryboard(name: "FosterView", bundle: Bundle.main)
                        let controller = storyboard.instantiateViewController(withIdentifier: "FosterBoard")
                        self.present(controller, animated: true, completion: nil)
                    }
                    else if (userRole.isEqual("MEMBER"))
                    {
                        if (firstTime.isEqual("true"))
                        {

                                let alertController = UIAlertController(title: "Update information", message: "Look like this is the first time you logged in. Please update your information before proceeding",preferredStyle: .alert)
                        
                                let defaultAction = UIAlertAction(title: "OK", style: .default) { action in
                                    let storyboard = UIStoryboard(name: "MemberView", bundle: Bundle.main)
                                    let controller = storyboard.instantiateViewController(withIdentifier: "MemberInfo")
                                    self.present(controller, animated: true, completion: nil)
                                }
                                alertController.addAction(defaultAction)
                        
                                self.present(alertController, animated: true, completion: nil)

                        
                        
                        }
                        else
                        {
                            let storyboard = UIStoryboard(name: "MemberView", bundle: Bundle.main)
                            let controller = storyboard.instantiateViewController(withIdentifier: "MemberBoard")
                            self.present(controller, animated: true, completion: nil)
                        
                        }
                    }


                }) { (error) in
                    print(error.localizedDescription)
                }
                
                
            }
            else
            {
                
                //Tells the user that there is an error and then gets firebase to tell them the error
                let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }

    
    
   
    @IBAction func btnSignUpPressed(_ sender: Any) {
        //create register message
        let alert = UIAlertController(title: "Register", message: "Register", preferredStyle: .alert)
        
        //create save button and action
        let saveAction = UIAlertAction(title: "Save", style: .default) { action in
            //get text from message
            let emailField = alert.textFields![0]
            let passwordField = alert.textFields![1]
            let phoneField = alert.textFields![2]
            
            let email = emailField.text!
            let password = passwordField.text!
            let phone = phoneField.text!
            
            Auth.auth().createUser(withEmail: email,password: password) { user, error in
                if error == nil {
                    
                    let alertController = UIAlertController(title: "Success", message: "Account created!",preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                    Auth.auth().signIn(withEmail: self.txfEmail.text!,password: self.txfPassword.text!)
                    
                    let rootRef = Database.database().reference()
                    let firstTime = "true"
                    //update basic info
                    let userRole = "member"
                    let key = rootRef.child("user_info").child(Auth.auth().currentUser!.uid).key
                    let post = ["email": email,
                                "phoneNumber": phone,
                                "userRole": userRole,
                                "isFirstTime": firstTime]
                    let childupdate = ["/\(key)": post]
                    rootRef.child("user_info").updateChildValues(childupdate)
                    
                }
                else
                {
                    //Tells the user that there is an error and then gets firebase to tell them the error
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)

                }
            }
        }
        
        
        //create cancel button and action
        let cancelAction = UIAlertAction(title: "Cancel",style: .default)
        
        //add text to message
        alert.addTextField { textEmail in
            textEmail.placeholder = "Enter your email"
        }
        
        alert.addTextField { textPassword in
            textPassword.isSecureTextEntry = true
            textPassword.placeholder = "Enter your password"
        }
        
        //add text to message
        alert.addTextField { textPhone in
            textPhone.placeholder = "Enter your phone number"
        }
        
        //add action to message
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        //show
        present(alert, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

