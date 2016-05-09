//
//  IdeeKategorien.swift
//  iDProj
//
//  Created by wilabor on 13.01.16.
//  Copyright © 2016 Patrick Gutting. All rights reserved.
//

import Foundation

class IdeeKategorien: UIViewController{
    
    @IBAction func go(sender: AnyObject) {
        self.revealViewController().revealToggle(self)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //Speichern des Programmübergreifenden Kategorien-Array
        
        //Übergabe der Cachewerte an lokales Array
        
               //Recognizer für Menüband Slide
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        //Check Tap um Tastatur auszublenden
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(IdeeKategorien.tap))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
        func tap() {
        print("Tapped!")
        self.view.endEditing(true)
    }
    
}