//
//  HistoryMember_Deal_Controller.swift
//  PetHelper
//
//  Created by Lu Tam Long on 7/4/17.
//  Copyright © 2017 SUAY555. All rights reserved.
//

import UIKit
import Firebase

class HistoryMember_Deal_Controller: UIViewController, UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var mytable: UITableView!
    var table_data = [cell_history_foster]()
    let rootRef = Database.database().reference()
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = UIColor(red: 62/255, green: 167/255, blue: 53/255, alpha: 1)
        self.mytable.delegate = self
        self.mytable.dataSource = self
        
        var arr_key:[String]=[]
        let condition = rootRef.child("surgery_pet")
        condition.observe( DataEventType.value, with: { (snapshot: DataSnapshot) in
            self.table_data.removeAll()
            let deal = snapshot.value as? [String:[String: AnyObject]]
            if (deal != nil)
            {
                arr_key = [String](deal!.keys)
                arr_key.forEach { key in
                    let user_id = Auth.auth().currentUser!.uid
                    let patient_list = deal![key]!["patientList"] as! String
                    
                    if ((patient_list.range(of: user_id)) != nil)
                    {
                        
                        var deal_history = cell_history_foster()
                        let startdate = deal![key]!["startDate"] as! String
                        let enddate  = deal![key]!["endDate"] as! String
                        deal_history.id = key
                        deal_history.time = startdate + " to " + enddate
                        self.table_data.insert(deal_history, at: 0)
                        self.mytable.reloadData()
                        
                    }
                }
                
                
            }
            
            
        })
        
    }

   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return mangMH.count
        return table_data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        //cell.textLabel?.text=mangMH[indexPath.row]
        //cell.textLabel?.text=List_Students[indexPath.row].ID
        cell.textLabel?.text = table_data[indexPath.row].time
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //curStudent=List_Students[indexPath.row]
        /*index=indexPath.row
         Clang.text=List_Students[indexPath.row].firstname+" "+List_Students[indexPath.row].lastname
         if (index > -1){
         main_navigation.rightBarButtonItem?.isEnabled=true
         performSegue(withIdentifier: "EditInfo", sender: nil)
         }*/
        
        
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
