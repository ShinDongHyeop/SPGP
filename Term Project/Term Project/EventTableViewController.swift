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
    
    
    var event_title = ""
    var event_cont2 = ""
    var event_begin_de = ""
    
    var event_end_de = ""
    var openmeet_plc = ""
    
    var refine_roadnm_addr = ""
    var mngt_inst_telno = ""
    
    var hmpg_addr = ""
    var mngt_inst_nm = ""
    var promoter_inst_nm = ""
    var suprt_inst_nm = ""
    
    var XPos = NSMutableString()
    var YPos = NSMutableString()
    
    var eevent_title = NSMutableString()
    
  
    var emngt_inst_telno = NSMutableString()
    var eevent_end_de = NSMutableString()
    var eopenmeet_plc = NSMutableString()
    var erefine_roadnm_addr = NSMutableString()

    var ehmpg_addr = NSMutableString()
    var emngt_inst_nm = NSMutableString()
    var epromoter_inst_nm = NSMutableString()

    var esuprt_inst_nm = NSMutableString()

    

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
        if element.isEqual(to: "EVENT_TITLE") {
            eevent_title.append(string)
        }

        else if element.isEqual(to: "EVENT_BEGIN_DE") {
            event_begin.append(string)
        }
        else if element.isEqual(to: "EVENT_CONT") {
            event_cont.append(string)
        }
        else if element.isEqual(to: "MNGT_INST_TELNO") {
            emngt_inst_telno.append(string)
        }

        else if element.isEqual(to: "REFINE_WGS84_LOGT") {
            XPos.append(string)
        }
        else if element.isEqual(to: "REFINE_WGS84_LAT") {
            YPos.append(string)
        }
        else if element.isEqual(to: "EVENT_END_DE") {
            eevent_end_de.append(string)
        }
        else if element.isEqual(to: "EVENT_PLC") {
            eopenmeet_plc.append(string)
        }
        else if element.isEqual(to: "REFINE_ROADNM_ADDR") {
            erefine_roadnm_addr.append(string)
        }
        else if element.isEqual(to: "HMPG_ADDR") {
            ehmpg_addr.append(string)
        }
        else if element.isEqual(to: "MNGT_INST_NM") {
            emngt_inst_nm.append(string)
        }
        else if element.isEqual(to: "SUPRT_INST_NM") {
            esuprt_inst_nm.append(string)
        }
        else if element.isEqual(to: "PROMOTER_INST_NM") {
            epromoter_inst_nm.append(string)
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
            eevent_title = NSMutableString()
            eevent_title = ""
            
            emngt_inst_telno = NSMutableString()
            emngt_inst_telno = ""
            eevent_end_de = NSMutableString()
            eevent_end_de = ""
            eopenmeet_plc = NSMutableString()
            eopenmeet_plc = ""
            erefine_roadnm_addr = NSMutableString()
            erefine_roadnm_addr = ""
            
            ehmpg_addr = NSMutableString()
            ehmpg_addr =  ""
            emngt_inst_nm = NSMutableString()
            emngt_inst_nm = ""

            epromoter_inst_nm = NSMutableString()
            epromoter_inst_nm = ""
            esuprt_inst_nm = NSMutableString()
            esuprt_inst_nm = ""
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
          
            if !eevent_title.isEqual(nil) {
                elements.setObject(eevent_title, forKey: "EVENT_TITLE" as NSCopying)
            }

            if !eevent_end_de.isEqual(nil) {
                elements.setObject(eevent_end_de, forKey: "EVENT_END_DE" as NSCopying)
            }
            if !eopenmeet_plc.isEqual(nil) {
                elements.setObject(eopenmeet_plc, forKey: "EVENT_PLC" as NSCopying)
            }

            if !erefine_roadnm_addr.isEqual(nil) {
                elements.setObject(erefine_roadnm_addr, forKey: "REFINE_ROADNM_ADDR" as NSCopying)
            }

            if !ehmpg_addr.isEqual(nil) {
                elements.setObject(ehmpg_addr, forKey: "HMPG_ADDR" as NSCopying)
            }

            if !emngt_inst_nm.isEqual(nil) {
                elements.setObject(emngt_inst_nm, forKey: "MNGT_INST_NM" as NSCopying)
            }

            if !epromoter_inst_nm.isEqual(nil) {
                elements.setObject(epromoter_inst_nm, forKey: "PROMOTER_INST_NM" as NSCopying)
            }

            if !esuprt_inst_nm.isEqual(nil) {
                elements.setObject(esuprt_inst_nm, forKey: "SUPRT_INST_NM" as NSCopying)
            }
            if !emngt_inst_telno.isEqual(nil) {
                elements.setObject(emngt_inst_telno, forKey: "MNGT_INST_TELNO" as NSCopying)
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
        if segue.identifier == "segueToEventDetail" {
            if let cell = sender as? UITableViewCell {
                let indexPath = tableView.indexPath(for: cell)
                event_title = (posts.object(at: (indexPath?.row)!) as AnyObject).value(forKey: "EVENT_TITLE") as! NSString as String
                event_cont2 = (posts.object(at: (indexPath?.row)!) as AnyObject).value(forKey: "EVENT_CONT") as! NSString as String
                event_begin_de = (posts.object(at: (indexPath?.row)!) as AnyObject).value(forKey: "EVENT_BEGIN_DE") as! NSString as String
                event_end_de = (posts.object(at: (indexPath?.row)!) as AnyObject).value(forKey: "EVENT_END_DE") as! NSString as String
                openmeet_plc = (posts.object(at: (indexPath?.row)!) as AnyObject).value(forKey: "EVENT_PLC") as! NSString as String
                refine_roadnm_addr = (posts.object(at: (indexPath?.row)!) as AnyObject).value(forKey: "REFINE_ROADNM_ADDR") as! NSString as String
                mngt_inst_telno = (posts.object(at: (indexPath?.row)!) as AnyObject).value(forKey: "MNGT_INST_TELNO") as! NSString as String
                hmpg_addr = (posts.object(at: (indexPath?.row)!) as AnyObject).value(forKey: "HMPG_ADDR") as! NSString as String
                mngt_inst_nm = (posts.object(at: (indexPath?.row)!) as AnyObject).value(forKey: "MNGT_INST_NM") as! NSString as String
                promoter_inst_nm = (posts.object(at: (indexPath?.row)!) as AnyObject).value(forKey: "PROMOTER_INST_NM") as! NSString as String
                suprt_inst_nm = (posts.object(at: (indexPath?.row)!) as AnyObject).value(forKey: "SUPRT_INST_NM") as! NSString as String
                
                // url에서 한글을 쓸 수 있도록 코딩
                eventname_utf8 = eventname.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!

                if let navController = segue.destination as? UINavigationController {
                    if let detailEventTableViewController = navController.topViewController as? DetailEventTableViewController {
                        detailEventTableViewController.EVENT_TITLE = event_title
                        detailEventTableViewController.EVENT_CONT = event_cont2
                        detailEventTableViewController.EVENT_BEGIN_DE = event_begin_de
                        detailEventTableViewController.EVENT_END_DE = event_end_de
                        detailEventTableViewController.OPENMEET_PLC = openmeet_plc
                        detailEventTableViewController.REFINE_ROADNM_ADDR = refine_roadnm_addr
                        detailEventTableViewController.MNGT_INST_TELNO = mngt_inst_telno
                        detailEventTableViewController.HMPG_ADDR = hmpg_addr
                        detailEventTableViewController.MNGT_INST_NM = mngt_inst_nm
                        detailEventTableViewController.PROMOTER_INST_NM = promoter_inst_nm
                        detailEventTableViewController.SUPRT_INST_NM = suprt_inst_nm

                    }
                }

            }}
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
        
        cell.textLabel?.text = (posts.object(at: indexPath.row) as AnyObject).value(forKey: "EVENT_TITLE") as! NSString as String
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
