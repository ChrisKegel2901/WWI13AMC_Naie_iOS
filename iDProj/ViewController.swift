//
//  ViewController.swift
//  iDProj
//
//  Created by wilabor on 15.12.15.
//  Copyright © 2015 Patrick Gutting. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var UserName: UITextField!
    
    @IBOutlet weak var Password: UITextField!

   
    @IBOutlet weak var ErrorText: UITextView!
    var returnValue: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let tapGesture = UITapGestureRecognizer(target: self, action: "tap")
        self.view.addGestureRecognizer(tapGesture)
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //////
    
    @IBAction func Login(sender: AnyObject) {
    
        let username = UserName.text
        let password = Password.text
        
        ErrorText.text = ""
        if username! == "Detlef" && password == "123" {
          returnValue = true
        }
        
        if returnValue
        {
            self.performSegueWithIdentifier("showTable", sender: self)
        }
        else{
            ErrorText.text = "Der Benutzername oder das Passwort ist nicht korrekt. Bitte versuche es erneut."
        }
        
        print(username)
        print(password)
    }
    
    func tap() {
        print("Tapped!")
        self.view.endEditing(true)
    }
    
}

