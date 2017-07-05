//
//  ActionMemController.swift
//  PetHelper
//
//  Created by Lu Tam Long on 7/5/17.
//  Copyright © 2017 SUAY555. All rights reserved.
//

import UIKit

class ActionMemController: UIViewController {

    @IBAction func Menu(_ sender: Any) {
        let storyboard = UIStoryboard(name: "MemberView", bundle: Bundle.main)
        let controller = storyboard.instantiateViewController(withIdentifier: "MemberBoard")
        self.present(controller, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

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
