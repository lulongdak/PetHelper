//
//  HistoryMember_Foster_Controller.swift
//  PetHelper
//
//  Created by Lu Tam Long on 7/4/17.
//  Copyright © 2017 SUAY555. All rights reserved.
//

import UIKit
import Firebase

class HistoryMember_Foster_Controller: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var mytable: UITableView!
    var table_data = [cell_history_foster]()
    let rootRef = Database.database().reference()
    override func viewDidLoad() {
        
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = UIColor(red: 62/255, green: 167/255, blue: 53/255, alpha: 1)
        // Do any additional setup after loading the view.
        self.mytable.dataSource = self
        self.mytable.delegate = self
        
        var arr_key:[String]=[]
        let condition = rootRef.child("foster_pet")
        condition.observe( DataEventType.value, with: { (snapshot: DataSnapshot) in
            self.table_data.removeAll()
            let foster = snapshot.value as? [String:[String: AnyObject]]
            if (foster != nil)
            {
                print(foster)
                arr_key = [String](foster!.keys)
                arr_key.forEach { key in
                    let user_id = Auth.auth().currentUser!.uid
                    let adopter_list = foster![key]!["adopterList"] as! String
                    if (adopter_list.range(of: user_id) != nil)
                    {
                        
                        var foster_history = cell_history_foster()
                        let startdate = foster![key]!["startDate"] as! String
                        let enddate  = foster![key]!["endDate"] as! String
                        foster_history.id = key
                        foster_history.time = startdate + " to " + enddate
                        self.table_data.insert(foster_history, at: 0)
                        self.mytable.reloadData()
                        
                        
                    }
                }
                
                
            }
            
        })
        
        
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return table_data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = table_data[indexPath.row].time
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
                Update_role_View.id = table_data[index].id
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
