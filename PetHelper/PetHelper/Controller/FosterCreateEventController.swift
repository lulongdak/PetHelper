//
//  FosterCreateEventController.swift
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


class FosterCreateEventController: UIViewController {

    
    @IBOutlet weak var qty: UITextField!
    
    @IBOutlet weak var startdate: UITextField!
    
    @IBOutlet weak var enddate: UITextField!
    
    @IBOutlet weak var dealcost: UITextField!
    
    @IBOutlet weak var animal: UITextField!
    let rootRef = Database.database().reference()
    
    @IBAction func back(_ sender: Any) {
           self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func Create_Deal(_ sender: Any) {
        
        let txtqty = qty.text!
        let txtenddate = enddate.text!
        let txtstartdate = startdate.text!
        let txtdeal = dealcost.text!
        let txtanimal = animal.text!
        if (txtqty.isNumber == false || txtdeal.isNumber == false){
            print("Quantity and deal must be a number");
        }
        else
        {
            self.navigationController?.popViewController(animated: true)
        }
        
        
        let key = rootRef.child("foster_pet").child(Auth.auth().currentUser!.uid).childByAutoId().key
        
        let condition = rootRef.child("user_info").child(Auth.auth().currentUser!.uid)
        
        //update information
        let post = ["fosterQuantity": txtqty,
                    "fosterUserID": Auth.auth().currentUser!.uid,
                    "endDate": txtenddate,
                    "startDate": txtstartdate,
                    "costPerDay": txtdeal,
                    "fosterSpecies": txtanimal,
                    "adopterList": ""]
        let childupdate = ["/\(key)": post]
        self.rootRef.child("foster_pet").updateChildValues(childupdate)
        

    }
    
    
    /*** Input start date */
    let m_startdate = UIDatePicker()
    
    func createstartdate(){
        
        //format date of birth
        m_startdate.datePickerMode = .date
        //toolbar
        let toolbar=UIToolbar()
        toolbar.sizeToFit()
        
        //bar button item
        let btn_done=UIBarButtonItem(barButtonSystemItem: .done,target: nil,action: #selector (donePress_Start))
        toolbar.setItems([btn_done], animated: false)
        startdate.inputAccessoryView=toolbar
        
        //
        startdate.inputView=m_startdate
        
    }
    
    func donePress_Start()
    {
        let dateformatter=DateFormatter()
        dateformatter.dateStyle = .long
        dateformatter.timeStyle = .none
        dateformatter.dateFormat="dd-MM-yyyy"
        
        startdate.text=dateformatter.string(from: m_startdate.date)
        self.view.endEditing(true)
    }
    
    /*** Input end date */
    let m_enddate = UIDatePicker()
    
    func createenddate(){
        
        //format date of birth
        m_enddate.datePickerMode = .date
        //toolbar
        let toolbar=UIToolbar()
        toolbar.sizeToFit()
        
        //bar button item
        let btn_done=UIBarButtonItem(barButtonSystemItem: .done,target: nil,action: #selector (donePress_End))
        toolbar.setItems([btn_done], animated: false)
        enddate.inputAccessoryView=toolbar
        
        //
        enddate.inputView=m_enddate
        
    }
    
    func donePress_End()
    {
        let dateformatter=DateFormatter()
        dateformatter.dateStyle = .long
        dateformatter.timeStyle = .none
        dateformatter.dateFormat="dd-MM-yyyy"
        
        enddate.text=dateformatter.string(from: m_enddate.date)
        self.view.endEditing(true)
    }
    

    
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        
        navigationController?.navigationBar.barTintColor = UIColor(red: 62/255, green: 167/255, blue: 53/255, alpha: 1)
        
        self.createenddate()
        self.createstartdate()

        // Do any additional setup after loading the view.
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
