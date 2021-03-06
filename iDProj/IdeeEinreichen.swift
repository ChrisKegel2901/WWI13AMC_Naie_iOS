//
//  IdeeEinreichen.swift
//  iDProj
//
//  Created by wilabor on 13.01.16.
//  Copyright © 2016 Patrick Gutting. All rights reserved.
//

import Foundation

class IdeeEinreichen: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{
    
    @IBOutlet weak var ideaDescription: UITextView!
    @IBOutlet weak var ideaTitle: UITextField!
    @IBOutlet weak var ideaCategory: UIPickerView!
    var categories1:[String] = []
    var category: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //Speichern des Programmübergreifenden Kategorien-Array
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        //Übergabe des Kategorie-Arrays aus dem Cache
        let categories = prefs.arrayForKey("CATEGORIES")
        
        //Übergabe der Cachewerte an lokales Array
        for (var i = 0; i < categories?.count ; i++ )
        {
          categories1.append(categories![i] as! String)
        }
        
        //Initialisierung für UIPickerView für Kategorieauswahl
        self.ideaCategory.dataSource = self;
        self.ideaCategory.delegate = self;
        
        //Recognizer für Menüband Slide
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        //Check Tap um Tastatur auszublenden
        let tapGesture = UITapGestureRecognizer(target: self, action: "tap")
        self.view.addGestureRecognizer(tapGesture)
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
    
    //Implementierung PickerView
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    //Ermitteln der Anzahl der PickerView Eintraege
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories1.count
    }
    //PickerVIew befuellen
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String!{
        category = categories1[row]
        return categories1[row]
    }
    
    func tap() {
        print("Tapped!")
        self.view.endEditing(true)
    }
    
}