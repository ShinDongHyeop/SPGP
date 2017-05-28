//
//  FestivalTableViewController.swift
//  Term Project
//
//  Created by KPUGAME on 2017. 5. 21..
//  Copyright © 2017년 DONGHYEOP SHIN. All rights reserved.
//

import UIKit

class FestivalTableViewController: UITableViewController, XMLParserDelegate{

    @IBAction func doneToPickerViewController3(segue: UIStoryboardSegue) {
    }
    
    @IBOutlet var tbData: UITableView!
    var url: String?
    
    var parser = XMLParser()
    var posts = NSMutableArray()
    var elements = NSMutableDictionary()
    var element = NSString()
    
    var festival_begin = NSMutableString()
    var festival_cont = NSMutableString()
    
    
    var festivalcont = ""
    var festivalbegin = ""
    var festivalend = ""
    var openmeetplc = ""
    var refien = ""
    var telno = ""
    var addr = ""
    var mngt = ""
    var promoter = ""
    var suprt = ""
    
    var festivalname_utf8 = ""
    
    var FASTVL_BEGIN_DE = NSMutableString()
    var FASTVL_CONT = NSMutableString()
    var FASTVL_END_DE = NSMutableString()
    var OPENMEET_PLC = NSMutableString()
    
    var REFINE_ROADNM_ADDR = NSMutableString()
    
    var MNGT_INST_TELNO = NSMutableString()
    
    var HMPG_ADDR = NSMutableString()
    
    var MNGT_INST_NM = NSMutableString()
    
    var PROMOTER_INST_NM = NSMutableString()
    
    var SUPRT_INST_NM = NSMutableString()
    
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
        parser = XMLParser(contentsOf:(URL(string:"http://openapi.gg.go.kr/CultureFestival?Key=8c1c7bdeab4842f981dd047006ad6886&Type=xml"))!)!
        parser.delegate = self
        parser.parse()
        tbData!.reloadData()
        
    }
    
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?,  attributes attributeDict: [String : String])
    {
        element = elementName as NSString
        if (elementName as NSString).isEqual(to: "row")
        {
            elements = NSMutableDictionary()
            elements = [:]
            festival_begin = NSMutableString()
            festival_begin = ""
            
            festival_cont = NSMutableString()
            festival_cont = ""
            FASTVL_BEGIN_DE = NSMutableString()
            FASTVL_BEGIN_DE = ""
            FASTVL_CONT = NSMutableString()
            FASTVL_CONT = ""
            // 위도 경도
            XPos = NSMutableString()
            XPos = ""
            YPos = NSMutableString()
            YPos = ""
        
            FASTVL_END_DE = NSMutableString()
            FASTVL_END_DE = ""
            
            OPENMEET_PLC = NSMutableString()
            OPENMEET_PLC = ""
            
            REFINE_ROADNM_ADDR = NSMutableString()
            REFINE_ROADNM_ADDR = ""
            
            MNGT_INST_TELNO = NSMutableString()
            MNGT_INST_TELNO = ""
            
            HMPG_ADDR = NSMutableString()
            HMPG_ADDR = ""
            
            MNGT_INST_NM = NSMutableString()
            MNGT_INST_NM = ""
            
            PROMOTER_INST_NM = NSMutableString()
            PROMOTER_INST_NM = ""
            
            SUPRT_INST_NM = NSMutableString()
            SUPRT_INST_NM = ""

        
        
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String)
    {
        if element.isEqual(to: "FASTVL_BEGIN_DE") {
            festival_begin.append(string)
            if festival_begin.hasPrefix("2017") {
                FASTVL_BEGIN_DE.append(string)
                print("FASTVL_BEGN : " , FASTVL_BEGIN_DE)
            }
            else {
            }
        }
        else if element.isEqual(to: "FASTVL_CONT") {
            if festival_begin.hasPrefix("2017") {
            festival_cont.append(string)
            }
        }
        else if element.isEqual(to: "REFINE_WGS84_LOGT") {
            XPos.append(string)
        }
        else if element.isEqual(to: "REFINE_WGS84_LAT") {
            YPos.append(string)
        }
        else if element.isEqual(to: "FASTVL_END_DE") {
            FASTVL_END_DE.append(string)
        }
        else if element.isEqual(to: "OPENMEET_PLC") {
            OPENMEET_PLC.append(string)
        }
        else if element.isEqual(to: "REFINE_ROADNM_ADDR") {
            REFINE_ROADNM_ADDR.append(string)
        }
        else if element.isEqual(to: "MNGT_INST_TELNO") {
            MNGT_INST_TELNO.append(string)
        }
        else if element.isEqual(to: "HMPG_ADDR") {
            HMPG_ADDR.append(string)
        }
        else if element.isEqual(to: "MNGT_INST_NM") {
            MNGT_INST_NM.append(string)
        }
        else if element.isEqual(to: "PROMOTER_INST_NM") {
            SUPRT_INST_NM.append(string)
        }
        else if element.isEqual(to: "SUPRT_INST_NM") {
            SUPRT_INST_NM.append(string)
        }

    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?)
    {
        if (elementName as NSString).isEqual(to: "row") {
            if !FASTVL_BEGIN_DE.isEqual(nil) {
                elements.setObject(FASTVL_BEGIN_DE, forKey: "FASTVL_BEGIN_DE" as NSCopying)
            }
            if !festival_cont.isEqual(nil) {
                elements.setObject(festival_cont, forKey: "FASTVL_CONT" as NSCopying)
            }
            if !XPos.isEqual(nil) {
                elements.setObject(XPos, forKey: "REFINE_WGS84_LOGT" as NSCopying)
            }
            if !YPos.isEqual(nil) {
                elements.setObject(YPos, forKey: "REFINE_WGS84_LAT" as NSCopying)
            }
            if !FASTVL_END_DE.isEqual(nil) {
                elements.setObject(FASTVL_END_DE, forKey: "FASTVL_END_DE" as NSCopying)
            }
            if !OPENMEET_PLC.isEqual(nil) {
                elements.setObject(OPENMEET_PLC, forKey: "OPENMEET_PLC" as NSCopying)
            }
            if !REFINE_ROADNM_ADDR.isEqual(nil) {
                elements.setObject(REFINE_ROADNM_ADDR, forKey: "REFINE_ROADNM_ADDR" as NSCopying)
            }
            if !MNGT_INST_TELNO.isEqual(nil) {
                elements.setObject(MNGT_INST_TELNO, forKey: "MNGT_INST_TELNO" as NSCopying)
            }
            if !HMPG_ADDR.isEqual(nil) {
                elements.setObject(HMPG_ADDR, forKey: "HMPG_ADDR" as NSCopying)
            }
            if !MNGT_INST_NM.isEqual(nil) {
                elements.setObject(MNGT_INST_NM, forKey: "MNGT_INST_NM" as NSCopying)
            }
            if !SUPRT_INST_NM.isEqual(nil) {
                elements.setObject(SUPRT_INST_NM, forKey: "PROMOTER_INST_NM" as NSCopying)
            }
            if !SUPRT_INST_NM.isEqual(nil) {
                elements.setObject(SUPRT_INST_NM, forKey: "SUPRT_INST_NM" as NSCopying)
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
                festivalcont = (posts.object(at: (indexPath?.row)!) as AnyObject).value(forKey: "FASTVL_CONT") as! NSString as String
                
                festivalbegin = (posts.object(at: (indexPath?.row)!) as AnyObject).value(forKey: "FASTVL_BEGIN_DE") as! NSString as String
                festivalend = (posts.object(at: (indexPath?.row)!) as AnyObject).value(forKey: "FASTVL_END_DE") as! NSString as String
                openmeetplc = (posts.object(at: (indexPath?.row)!) as AnyObject).value(forKey: "OPENMEET_PLC") as! NSString as String
                refien = (posts.object(at: (indexPath?.row)!) as AnyObject).value(forKey: "REFINE_ROADNM_ADDR") as! NSString as String
                
                telno = (posts.object(at: (indexPath?.row)!) as AnyObject).value(forKey: "MNGT_INST_TELNO") as! NSString as String
                addr = (posts.object(at: (indexPath?.row)!) as AnyObject).value(forKey: "HMPG_ADDR") as! NSString as String
                mngt = (posts.object(at: (indexPath?.row)!) as AnyObject).value(forKey: "MNGT_INST_NM") as! NSString as String
                promoter = (posts.object(at: (indexPath?.row)!) as AnyObject).value(forKey: "PROMOTER_INST_NM") as! NSString as String
                suprt = (posts.object(at: (indexPath?.row)!) as AnyObject).value(forKey: "SUPRT_INST_NM") as! NSString as String

                // url에서 한글을 쓸 수 있도록 코딩
               
            if let navController = segue.destination as? UINavigationController {
                    if let detailFestivalTableViewController = navController.topViewController as? DetailFestivalTableViewController {
                        detailFestivalTableViewController.FASTVL_CONT = festivalcont
                        detailFestivalTableViewController.FASTVL_BEGIN_DE = festivalbegin
                        detailFestivalTableViewController.FASTVL_END_DE = festivalend
                        detailFestivalTableViewController.OPENMEET_PLC = openmeetplc
                        detailFestivalTableViewController.REFINE_ROADNM_ADDR = refien
                        detailFestivalTableViewController.MNGT_INST_TELNO = telno
                        detailFestivalTableViewController.HMPG_ADDR = addr
                        detailFestivalTableViewController.MNGT_INST_NM = mngt
                        detailFestivalTableViewController.PROMOTER_INST_NM = promoter
                        detailFestivalTableViewController.SUPRT_INST_NM = suprt

                    }
                }
                
                
            }
        }
    }
    

    // row의 개수는 posts 배열 원소의 개수
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        if(cell.isEqual(NSNull.self)) {
            cell = Bundle.main.loadNibNamed("Cell", owner: self, options: nil)?[0] as! UITableViewCell
        }
        
        cell.textLabel?.text = (posts.object(at: indexPath.row) as AnyObject).value(forKey: "FASTVL_CONT") as! NSString as String
        cell.detailTextLabel?.text = (posts.object(at: indexPath.row) as AnyObject).value(forKey: "FASTVL_BEGIN_DE") as! NSString as String
        
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
