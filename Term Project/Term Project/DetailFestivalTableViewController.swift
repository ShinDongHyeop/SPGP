//
//  detailFestivalTableViewController.swift
//  Term Project
//
//  Created by KPUGAME on 2017. 5. 21..
//  Copyright © 2017년 DONGHYEOP SHIN. All rights reserved.
//

import UIKit

class DetailFestivalTableViewController: UITableViewController, XMLParserDelegate {

    @IBOutlet var detailTableView: UITableView!
    
    var url : String?
    
    var parser = XMLParser()
    let postsname : [String] = ["축제내용", "축제시작일", "축제종료일", "개최장소", "도로명주소", "전화번호", "홈페이지", "주관기관", "주최기관", "후원기관"]
    var posts : [String] = ["","","","","","","","","",""]
    
    var element = NSString()
    
    var FASTVL_CONT = NSMutableString()
    var FASTVL_BEGIN_DE = NSMutableString()
    var FASTVL_END_DE = NSMutableString()
    var OPENMEET_PLC = NSMutableString()
    var REFINE_ROADNM_ADDR = NSMutableString()
    var MNGT_INST_TELNO = NSMutableString()
    var HMPG_ADDR = NSMutableString()
    var MNGT_INST_NM = NSMutableString()
    var PROMOTER_INST_NM = NSMutableString()
    var SUPRT_INST_NM = NSMutableString()
    
    
    func beginParsing() {
        posts = []
        parser = XMLParser(contentsOf:(URL(string:"http://openapi.gg.go.kr/CultureFestival?Key=8c1c7bdeab4842f981dd047006ad6886&Type=xml"))!)!
        parser.delegate = self
        parser.parse()
        detailTableView.reloadData()
    }
    
    // parser가 새로운 element를 발견하면 변수를 생성한다.
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?,  attributes attributeDict: [String : String])
    {
        element = elementName as NSString
        
        if (elementName as NSString).isEqual(to: "row")
        {
            posts = ["","","","","","","","","",""]

            FASTVL_CONT = NSMutableString()
            FASTVL_CONT = ""
            FASTVL_BEGIN_DE = NSMutableString()
            FASTVL_BEGIN_DE = ""
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
    
    // title과 pubDate를 발견하면 title1과 date에 완성한다.
    func parser(_ parser: XMLParser, foundCharacters string: String)
    {
        if element.isEqual(to: "FASTVL_CONT") {
            FASTVL_CONT.append(string)
        }
        else if element.isEqual(to: "FASTVL_BEGIN_DE") {
            FASTVL_BEGIN_DE.append(string)
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
            PROMOTER_INST_NM.append(string)
        }
        else if element.isEqual(to: "SUPRT_INST_NM") {
            SUPRT_INST_NM.append(string)
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?)
    {
        if (elementName as NSString).isEqual(to: "row") {
            if !FASTVL_CONT.isEqual(nil) {
                posts[0] = FASTVL_CONT as String
            }
            if !FASTVL_BEGIN_DE.isEqual(nil) {
                posts[1] = FASTVL_BEGIN_DE as String
            }
            if !FASTVL_END_DE.isEqual(nil) {
                posts[2] = FASTVL_END_DE as String
            }
            if !OPENMEET_PLC.isEqual(nil) {
                posts[3] = OPENMEET_PLC as String
            }
            if !REFINE_ROADNM_ADDR.isEqual(nil) {
                posts[4] = REFINE_ROADNM_ADDR as String
            }
            if !MNGT_INST_TELNO.isEqual(nil) {
                posts[5] = MNGT_INST_TELNO as String
            }
            if !HMPG_ADDR.isEqual(nil) {
                posts[6] = HMPG_ADDR as String
            }
            if !MNGT_INST_NM.isEqual(nil) {
                posts[7] = MNGT_INST_NM as String
            }
            if !PROMOTER_INST_NM.isEqual(nil) {
                posts[8] = PROMOTER_INST_NM as String
            }
            if !SUPRT_INST_NM.isEqual(nil) {
                posts[9] = SUPRT_INST_NM as String
            }
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        beginParsing()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return postsname.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "FestivalCell")!
        if(cell.isEqual(NSNull.self)) {
            cell = Bundle.main.loadNibNamed("FestivalCell", owner: self, options: nil)?[0] as! UITableViewCell
        }
        cell.textLabel?.text = postsname[indexPath.row]
        cell.detailTextLabel?.text = posts[indexPath.row]
        
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
