//
//  HistoryMember_Sales_Controller.swift
//  PetHelper
//
//  Created by Lu Tam Long on 7/4/17.
//  Copyright © 2017 SUAY555. All rights reserved.
//

import UIKit

class HistoryMember_Sales_Controller: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var mytable: UITableView!
    var table_data:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return table_data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        //cell.textLabel?.text = table_data[indexPath.row].time
        return cell
    }
    var index = -1
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //curStudent=List_Students[indexPath.row]
        //let index=indexPath.row
        index = indexPath.row
        /*if (index > -1){
         //main_navigation.rightBarButtonItem?.isEnabled=true
         performSegue(withIdentifier: "", sender: nil)
         }*/
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (index > -1)
        {
            if (segue.identifier == "AccountInfo")
            {
                let Update_role_View = segue.destination as! UpdateRoleController
               // Update_role_View.id = table_data[index].id
            }
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
