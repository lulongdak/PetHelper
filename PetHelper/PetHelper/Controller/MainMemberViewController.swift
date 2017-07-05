//
//  MemberViewController.swift
//  PetHelper
//
//  Created by Allen on 7/5/17.
//  Copyright © 2017 SUAY555. All rights reserved.
//

import UIKit
import Firebase

class MainMemberViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func btnLogOut(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            //return to login view
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let controller = storyboard.instantiateViewController(withIdentifier: "Main")
            self.present(controller, animated: true, completion: nil)
            
            
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }

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
