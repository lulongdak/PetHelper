//
//  ViewController.swift
//  PetHelper
//
//  Created by Lu Tam Long on 6/10/17.
//  Copyright © 2017 SUAY555. All rights reserved.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController {

        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
        
    @IBAction func Gotomap(_ sender: Any) {
        let storyboar = UIStoryboard(name: "MapView", bundle: Bundle.main)
        let controller = storyboar.instantiateViewController(withIdentifier: "MapView")
        self.present(controller, animated: true, completion: nil)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

