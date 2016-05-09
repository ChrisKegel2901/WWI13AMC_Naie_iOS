//
//  IdeeMeine.swift
//  iDProj
//
//  Created by wilabor on 15.12.15.
//  Copyright © 2015 Patrick Gutting. All rights reserved.
// Startseite - Liste
//

import Foundation

class IdeeMeine: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var TableData:Array< datastruct > = Array < datastruct >()
    var TableDataFiltered:Array< datastruct > = Array < datastruct >()
    var json_data_url = "http://thaspeedy.de:1194/api/idea/own"
    let dateFormatter = NSDateFormatter()
    var counter: Int = 0
    var test: UIImageView?
    
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
        var id:String?
        var medialink:String?
        var title:String?
        var description:String?
        var date:String?
        var votes:String?
        var kat:String?
        var user:String?
        init(add: NSDictionary)
        {
            id = add["ideaid"] as? String
            medialink = add["medialink"] as? String
            title = add["titel"] as? String
            description = add["description"] as? String
            date = add["ideadate"] as? String
            // votes = add["bewertung"] as? String
            kat = add["catid"] as? String
            user = add["userid"] as? String
        }
    }
    
    @IBOutlet weak var filter: UISegmentedControl!
    @IBOutlet weak var tableViewOutlet: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableViewOutlet.dataSource = self
        tableViewOutlet.delegate = self
        let bild = UIImage(named: "background")
        test = UIImageView(image: bild)
        tableViewOutlet.backgroundView = test
        tableViewOutlet.backgroundColor = UIColor.clearColor()
        get_data_from_url(json_data_url)
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        TableData.sortInPlace{ (element1, element2) -> Bool in
            
            return element1.date > element2.date
        }
        tableViewOutlet.reloadData()
        
    }
    @IBAction func go(sender: UIBarButtonItem) {
        self.revealViewController().revealToggle(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! CellAlle
        let data = TableData[indexPath.row]
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSSSSS"
        let datum = formatter.dateFromString(data.date!)
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        dateFormatter.timeZone = NSTimeZone(name: "MEZ")
        let dateFertig = dateFormatter.stringFromDate(datum!)
        var a:String = ""
        a = dateFertig
        
        cell.labelDate.text = a
        cell.title.text = data.title
        cell.beschreibung.text = data.description
        cell.anzahlBewertungen.text = data.votes
        if(data.kat == "1" || data.kat == "2" || data.kat == "3" || data.kat == "9" || data.kat == "10" ){
            cell.kategorieImage.image = UIImage(named: "Steckdose_50x50px.png")
        }
        else if(data.kat == "4" || data.kat == "5"){
            cell.kategorieImage.image = UIImage(named: "Messer_Gabel_50x50px.png")
        }
        else if(data.kat == "6" || data.kat == "7" || data.kat == "8"){
            cell.kategorieImage.image = UIImage(named: "Gluehbirne_50x50px.png")
        }
        else if(data.kat == "11"){
            cell.kategorieImage.image = UIImage(named: "SocialLife_50x50px.png")
        }
        
        
        cell.kategorieImage.layer.cornerRadius = cell.kategorieImage.frame.size.width / 2
        cell.kategorieImage.clipsToBounds = true
        
        
        
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
                
                self.extract_json(data!)
                return
            })
        }
        task.resume()
    }
    
    func extract_json(data:NSData)
    {
        
        
        do{
            
            let json = try NSJSONSerialization.JSONObjectWithData(data, options:.AllowFragments)
            
            
            if let list = json as? NSArray
            {
                for i in 0 ... (list.count - 1)
                {
                    if let data_block = list[i] as? NSDictionary
                    {
                        
                        TableData.append(datastruct(add: data_block))
                    }
                }
            }
            do_table_refresh()
            
            
            
        }catch {
            print("Error with Json: \(error)")
        }
        
    }
    func do_table_refresh()
    {
        dispatch_async(dispatch_get_main_queue(), {
            self.tableViewOutlet.reloadData()
        })
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "detailSegue" {
            let nextScene =  segue.destinationViewController as! IdeeDetail
            let holder = tableViewOutlet.indexPathForSelectedRow
            let cell = tableViewOutlet.cellForRowAtIndexPath(holder!) as! CellAlle
            
            // Pass the selected object to the new view controller.
            nextScene.titel = cell.title.text!
            nextScene.category = cell.kat
            nextScene.beschreibung = cell.beschreibung.text!
            
            
        }
    }
}