//
//  BackTableVC.swift
//  iDProj
//
//  Created by wilabor on 15.12.15.
//  Copyright © 2015 Patrick Gutting. All rights reserved.
//

import Foundation

class BackTableVC: UITableViewController {
    
    var TableArray = [String]()
    
    @IBOutlet weak var user: UILabel!
   
    override func viewDidLoad() {
        TableArray = ["Alle Ideen", "Idee einreichen","Kategorien", "Meine Ideen", "Logout"]
        //self.view.backgroundColor = UIColor.lightGrayColor()
       
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let username = prefs.stringForKey("USERNAME")
        user.text = username!
    }
    //Rückgabe der Anzahl der Zeilen innerhalb der Tabelle
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TableArray.count
    }
    
    //Zelle für zurückgegebene Zeile erstellen
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(TableArray[indexPath.row], forIndexPath: indexPath) as UITableViewCell
        //erstellte Zelle zurückgeben
        
        cell.textLabel?.text = TableArray[indexPath.row]
        cell.backgroundColor = UIColor.whiteColor()
        cell.textLabel?.textColor = UIColor.blackColor()
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "logoutSegue"{
            let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()

            prefs.setObject("", forKey: "USERNAME")
            
            //prefs.setObject(self.vorname, forKey: "VORNAME")
            prefs.setInteger(0, forKey: "ISLOGGEDIN")

        }
    }
    
}