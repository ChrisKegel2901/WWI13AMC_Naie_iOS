//
//  ViewController3.swift
//  iDProj
//
//  Created by wilabor on 15.12.15.
//  Copyright © 2015 Patrick Gutting. All rights reserved.
//

import Foundation

class ViewController3: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var TableData:Array< datastruct > = Array < datastruct >()
    var TableDataFiltered:Array< datastruct > = Array < datastruct >()
    var json_data_url = "http://www.chriskegel2901.bplaced.net/images/uploads/service_new.php"
    let dateFormatter = NSDateFormatter()
    var counter: Int = 0
    @IBAction func filterAction(sender: UISegmentedControl) {
        
        if (counter == 0){
       TableData.sortInPlace{ (element1, element2) -> Bool in

            return element1.date > element2.date
        }
        counter = 1
        tableViewOutlet.reloadData()
        }
        else{
            TableData.sortInPlace{ (element1, element2) -> Bool in
                
                return element1.votes > element2.votes
            }
            counter = 0
            tableViewOutlet.reloadData()

        }
        
        
    }
    struct datastruct
    {
        var title:String?
        var description:String?
        var date:String?
        var votes:String?
        init(add: NSDictionary)
        {
            title = add["name"] as? String
            description = add["strasse"] as? String
            date = add["plz"] as? String
            votes = add["bewertung"] as? String
        }
    }

    @IBOutlet weak var filter: UISegmentedControl!
    @IBOutlet weak var tableViewOutlet: UITableView!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableViewOutlet.dataSource = self
        tableViewOutlet.delegate = self
        get_data_from_url(json_data_url)

        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        TableData.sortInPlace{ (element1, element2) -> Bool in
            
            return element1.date > element2.date
        }
        
        tableViewOutlet.reloadData()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(tableView: UITableView, var cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! CustomCell
        var data = TableData[indexPath.row]
        cell.title.text = data.title
        cell.beschreibung.text = data.description
        cell.anzahlBewertungen.text = data.votes
       // dateFormatter.dateFormat = Short
        
        cell.datum = Double(data.date!)!
        
        return cell
        
    }
    func tableView(tableView: UITableView, sectionForSectionIndexTitle title: String, atIndex index: Int) -> Int {
        return 1
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
      
            
            return TableData.count
        
        
    }
    func get_data_from_url(url:String)
    {
        
        let url:NSURL = NSURL(string: url)!
        let session = NSURLSession.sharedSession()
        
        let request = NSMutableURLRequest(URL: url)
        
        request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
        request.HTTPMethod = "GET"
        
        let task = session.dataTaskWithRequest(request) {
            (
            let data, let response, let error) in
            
            guard let _:NSData = data, let _:NSURLResponse = response  where error == nil else {
                print("error1")
                return
            }
            
            dispatch_async(dispatch_get_main_queue(), {
                let json = NSString(data: data!, encoding: NSASCIIStringEncoding)
                self.extract_json(json!)
                return
            })
            
        }
        
        task.resume()
        
    }
    
    
    func extract_json(data:NSString)
    {
        var parseError: NSError?
        let jsonData:NSData = data.dataUsingEncoding(NSASCIIStringEncoding)!
        let json: AnyObject?
        do {
            json = try NSJSONSerialization.JSONObjectWithData(jsonData, options: [])
        } catch let error as NSError {
            parseError = error
            print("fehler")
            json = nil
        }
        if (parseError == nil)
        {
            if let list = json as? NSArray
            {
                for (var i = 0; i < list.count ; i++ )
                {
                    if let data_block = list[i] as? NSDictionary
                    {
                        
                        TableData.append(datastruct(add: data_block))
                    }
                }
                
                
                
                
                
            }
            
            do_table_refresh()
            
        }
        
        
        
        
    }
    
    
    func do_table_refresh()
    {
        dispatch_async(dispatch_get_main_queue(), {
            self.tableViewOutlet.reloadData()
            
        })
        
    }
    



    
}