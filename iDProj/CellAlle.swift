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
     
    
    @IBOutlet weak var labelDate: UILabel!
    @IBAction func downVote(sender: AnyObject) {
    }
    @IBAction func upVote(sender: AnyObject) {
    }
   
    
    @IBOutlet weak var anzahlBewertungen: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var beschreibung: UILabel!
    @IBOutlet weak var kategorieImage: UIImageView!
    
    var datum2: String = ""
    var kat: String = ""
    
   
   
    override func awakeFromNib() {
        self.backgroundColor = UIColor.clearColor()
       
        
        super.awakeFromNib()
        // Initialization code
    }
    
    
}
