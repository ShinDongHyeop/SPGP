//
//  EventTableViewController.swift
//  Term Project
//
//  Created by kpugame on 2017. 5. 22..
//  Copyright © 2017년 DONGHYEOP SHIN. All rights reserved.
//

import UIKit

class EventTableViewController: UITableViewController ,XMLParserDelegate{

    @IBAction func doneToPickerViewController4(segue: UIStoryboardSegue) {
    }
    var url: String?
    @IBOutlet var tbData: UITableView!
    var parser = XMLParser()
    var posts = NSMutableArray()
    var elements = NSMutableDictionary()
    var element = NSString()
    
    var event_begin = NSMutableString()
    var event_cont = NSMutableString()
    var eventname = ""
    var eventname_utf8 = ""
    
    var XPos = NSMutableString()
    var YPos = NSMutableString()

    override func viewDidLoad() {
        super.viewDidLoad()
        beginParsing()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func beginParsing() {
        posts = []
        parser = XMLParser(contentsOf:(URL(string:"http://openapi.gg.go.kr/PerformanceEvent?key=4f589fa06a6c405b94e4cc085acb5736&Type=xml"))!)!
        parser.delegate = self
        parser.parse()
        tbData!.reloadData()
        
    }

    func parser(_ parser: XMLParser, foundCharacters string: String)
    {
        if element.isEqual(to: "EVENT_BEGIN_DE") {
            event_begin.append(string)
        }
        else if element.isEqual(to: "EVENT_CONT") {
            event_cont.append(string)
        }
        else if element.isEqual(to: "REFINE_WGS84_LOGT") {
            XPos.append(string)
        }
        else if element.isEqual(to: "REFINE_WGS84_LAT") {
            YPos.append(string)
        }
    }

    
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?,  attributes attributeDict: [String : String])
    {
        element = elementName as NSString
        if (elementName as NSString).isEqual(to: "row")
        {
            elements = NSMutableDictionary()
            elements = [:]
            event_begin = NSMutableString()
            event_begin = ""
            event_cont = NSMutableString()
            event_cont = ""
            
            // 위도 경도
            XPos = NSMutableString()
            XPos = ""
            YPos = NSMutableString()
            YPos = ""
        }
    }
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?)
    {
        if (elementName as NSString).isEqual(to: "row") {
            if !event_begin.isEqual(nil) {
                elements.setObject(event_begin, forKey: "EVENT_BEGIN_DE" as NSCopying)
            }
            if !event_cont.isEqual(nil) {
                elements.setObject(event_cont, forKey: "EVENT_CONT" as NSCopying)
            }
            
            if !XPos.isEqual(nil) {
                elements.setObject(XPos, forKey: "REFINE_WGS84_LOGT" as NSCopying)
            }
            if !YPos.isEqual(nil) {
                elements.setObject(YPos, forKey: "REFINE_WGS84_LAT" as NSCopying)
            }
            posts.add(elements)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        if segue.identifier == "segueToMapView" {
            if let mapViewController = segue.destination as? MapViewController {
                mapViewController.posts = posts
            }
        }
        
        // Lab7 선택한 row의 병원명을 utf8로 코딩
        if segue.identifier == "segueToFestivalDetail" {
            if let cell = sender as? UITableViewCell {
                let indexPath = tableView.indexPath(for: cell)
                eventname = (posts.object(at: (indexPath?.row)!) as AnyObject).value(forKey: "EVENT_CONT") as! NSString as String
                // url에서 한글을 쓸 수 있도록 코딩
                eventname_utf8 = eventname.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
                if let detailFestivalTableViewController = segue.destination as? DetailFestivalTableViewController {
                    detailFestivalTableViewController.url = url
                    print(detailFestivalTableViewController.url)
                }
                
            }
        }
    }

    
   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        if(cell.isEqual(NSNull.self)) {
            cell = Bundle.main.loadNibNamed("Cell", owner: self, options: nil)?[0] as! UITableViewCell
        }
        
        cell.textLabel?.text = (posts.object(at: indexPath.row) as AnyObject).value(forKey: "EVENT_CONT") as! NSString as String
        cell.detailTextLabel?.text = (posts.object(at: indexPath.row) as AnyObject).value(forKey: "EVENT_BEGIN_DE") as! NSString as String
        
        return cell as UITableViewCell
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
