//
//  CustomCell.swift
//  iDProj
//
//  Created by Christian Kegelmann on 12.01.16.
//  Copyright © 2016 Patrick Gutting. All rights reserved.
//

import Foundation
import UIKit

class CellAlle: UITableViewCell{
    
    
    @IBAction func downVote(sender: AnyObject) {
    }
    @IBAction func upVote(sender: AnyObject) {
    }
    @IBOutlet weak var anzahlBewertungen: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var beschreibung: UILabel!
    
    var datum: Double = 0.0
    
    
    override func awakeFromNib() {
        
        
        super.awakeFromNib()
        // Initialization code
    }
    
}
