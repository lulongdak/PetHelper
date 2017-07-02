//
//  AdminManagerController.swift
//  PetHelper
//
//  Created by Lu Tam Long on 7/2/17.
//  Copyright © 2017 SUAY555. All rights reserved.
//

import UIKit
import Firebase

class AdminManagerController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var mytable: UITableView!
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    var table_data = [table_account]()
    let rootRef = Database.database().reference()
    var table_email = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mytable.delegate = self
        self.mytable.dataSource = self
        // Do any additional setup after loading the view.
        //var arr = getkeyOfDictionary(child: "user_info")
        print("list key")
        //self.table_data = getkeyOfDictionary(child: "user_info")
        //print(table_data)
        var arr_key:[String] = []
        let condition = rootRef.child("user_info")
        //var arr_list = [table_account]()
       /* condition.queryOrderedByKey().observe(DataEventType.childAdded, with: {(snapshot: DataSnapshot) in
            let snapshotValue = snapshot.value as? NSDictionary
            let email = snapshotValue?["email"] as? String
            print("email......")
            self.table_email.insert(email!, at: 0)
            self.mytable.reloadData()
        })*/
        condition.observe( DataEventType.value, with: { (snapshot: DataSnapshot) in
            self.table_data.removeAll()
            let user = snapshot.value as? [String:[String: AnyObject]]
            if (user != nil)
            {
                arr_key = [String](user!.keys)
                arr_key.forEach { key in
                    if (key != Auth.auth().currentUser!.uid)
                    {
                    
                    var tmp_tbl_acc = table_account()
                    tmp_tbl_acc.email = user![key]!["email"] as! String
                    tmp_tbl_acc.id = key
                    //arr_list.insert(tmp_tbl_acc, at: 0)
                    self.table_data.insert(tmp_tbl_acc, at: 0)
                    self.mytable.reloadData()
                    //arr_list.append(tmp_tbl_acc)
                    //print(tmp_tbl_acc)
                
                    }
                }
                
                
            }
            //arr_key.append("accc")
            //print(arr_list)
            // return arr_list
            
        })
        //print(self.table_email)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        print(self.table_data)
    }
    /*func getkeyOfDictionary(child: String) -> [table_account]
    {
                //print(arr_key)
     //   return arr_list
    }*/
    
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = table_data[indexPath.row].email
        return cell
    }
    var index = -1
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //curStudent=List_Students[indexPath.row]
        //let index=indexPath.row
        index = indexPath.row
        if (index > -1){
            //main_navigation.rightBarButtonItem?.isEnabled=true
            performSegue(withIdentifier: "AccountInfo", sender: nil)
        }
        
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
