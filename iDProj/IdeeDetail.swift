//
//  IdeeDetail.swift
//  DHBW iD
//
//  Created by Christian Kegelmann on 04.02.16.
//  Copyright © 2016 Patrick Gutting. All rights reserved.
//
import Foundation
import UIKit

class IdeeDetail: UIViewController, UITextViewDelegate{
    
    @IBOutlet weak var ideaDescription: UITextView!
    @IBOutlet weak var ideaTitle: UITextField!
    
    @IBOutlet weak var Kategorie: UILabel!
    
    var category: String = ""
    var titel: String = ""
    var beschreibung: String = ""
    @IBAction func go(sender: AnyObject) {
        let tmpController :UIViewController! = self.presentingViewController;
        
        self.dismissViewControllerAnimated(false, completion: {()->Void in
            
            tmpController.dismissViewControllerAnimated(false, completion: nil);
        });
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //Speichern des Programmübergreifenden Kategorien-Array
        
        ideaTitle.text = titel
        //Übergabe der Cachewerte an lokales Array
        
        
        //Initialisierung für UIPickerView für Kategorieauswahl
        ideaDescription.text = beschreibung
        ideaDescription.delegate = self
        
        if ideaDescription.text != "" {
            ideaDescription.textColor = UIColor.blackColor()
            ideaDescription.editable = false
        }
        //Recognizer für Menüband Slide
        
        
        //Check Tap um Tastatur auszublenden
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func ideaSend(sender: AnyObject) {
        
        //Übergabe der erfassten werte
        let title = ideaTitle.text
        let description = ideaDescription.text
        
        //toDo: Übergabe an API
        print("Senden Anfang")
        print(title)
        print(category)
        print(description)
        print("Senden Ende")
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        if ideaDescription.textColor == UIColor.lightGrayColor() {
            ideaDescription.text = nil
            ideaDescription.textColor = UIColor.blackColor()
        }
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        if ideaDescription.text.isEmpty {
            ideaDescription.text = "Beschreibung"
            ideaDescription.textColor = UIColor.lightGrayColor()
        }
    }
    func tap() {
        print("Tapped!")
        self.view.endEditing(true)
    }
    
}