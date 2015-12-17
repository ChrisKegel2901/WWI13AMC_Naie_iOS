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
    
    override func viewDidLoad() {
        TableArray = ["Anmelden", "Ideen", "Test"]
        self.view.backgroundColor = UIColor(red:0.83, green:0.33, blue:0.25, alpha:1.0)
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
        cell.backgroundColor = UIColor(red:0.83, green:0.33, blue:0.25, alpha:1.0)
        cell.textLabel?.textColor = UIColor.whiteColor()
        return cell
    }
}