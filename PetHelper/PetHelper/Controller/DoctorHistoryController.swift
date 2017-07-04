//
//  HistoryController.swift
//  PetHelper
//
//  Created by Lu Tam Long on 6/27/17.
//  Copyright © 2017 SUAY555. All rights reserved.
//

import UIKit
import Firebase

class DoctorHistoryController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    @IBOutlet weak var mytable: UITableView!
    var table_data = [cell_history_deal]()
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
        let condition = rootRef.child("doctor")
        condition.observe( DataEventType.value, with: { (snapshot: DataSnapshot) in
            self.table_data.removeAll()
            let deal = snapshot.value as? [String:[String: AnyObject]]
            if (deal != nil)
            {
                arr_key = [String](deal!.keys)
                arr_key.forEach { key in
                    let user_id = deal![key]!["user_id"] as! String
                    if (user_id == Auth.auth().currentUser!.uid)
                    {
                        
                        var foster_history = cell_history_foster()
                        let startdate = deal![key]!["startdate"] as! String
                        let enddate  = deal![key]!["enddate"] as! String
                        foster_history.id! = key
                        foster_history.time! = startdate + " - " + enddate
                        
                    }
                }
                
                
            }
            
            
        })

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

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
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
