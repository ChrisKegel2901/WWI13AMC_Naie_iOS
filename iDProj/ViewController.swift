//
//  ViewController.swift
//  iDProj
//
//  Created by wilabor on 15.12.15.
//  Copyright © 2015 Patrick Gutting. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var Username: UITextField!
    @IBOutlet weak var Password: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let tapGesture = UITapGestureRecognizer(target: self, action: "tap")
        self.view.addGestureRecognizer(tapGesture)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func Login(sender: AnyObject) {
        let username = Username.text
        let password = Password.text
        
        print(username)
        print(password)
    }
    
    func tap() {
        print("Tapped!")
        self.view.endEditing(true)
    }
    
}

