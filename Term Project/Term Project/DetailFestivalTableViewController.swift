//
//  detailFestivalTableViewController.swift
//  Term Project
//
//  Created by KPUGAME on 2017. 5. 21..
//  Copyright © 2017년 DONGHYEOP SHIN. All rights reserved.
//

import UIKit

class DetailFestivalTableViewController: UITableViewController, XMLParserDelegate {

    @IBAction func doneToPickerViewController5(segue: UIStoryboardSegue) {
    }
    @IBOutlet var detailTableView: UITableView!

    var parser = XMLParser()
    let postsname : [String] = ["축제내용", "축제시작일", "축제종료일", "개최장소", "도로명주소", "전화번호", "홈페이지", "주관기관", "주최기관", "후원기관"]
    var posts : [String] = ["","","","","","","","","",""]
    
    var element = NSString()
    var posts2 = NSMutableArray()
    var fastvl_cont = String()
    var FASTVL_BEGIN_DE = String()
    var FASTVL_END_DE = String()
    var OPENMEET_PLC = String()
    var REFINE_ROADNM_ADDR = String()
    var MNGT_INST_TELNO = String()
    var HMPG_ADDR = String()
    var MNGT_INST_NM = String()
    var PROMOTER_INST_NM = String()
    var SUPRT_INST_NM = String()
    var XPOS = String()
    var YPOS = String()
    
    func beginParsing() {
        posts[0] = fastvl_cont as String
        posts[1] = FASTVL_BEGIN_DE as String
        posts[2] = FASTVL_END_DE
        posts[3] = OPENMEET_PLC
        posts[4] = REFINE_ROADNM_ADDR
        posts[5] = MNGT_INST_TELNO
        posts[6] = HMPG_ADDR
        posts[7] = MNGT_INST_NM
        posts[8] = PROMOTER_INST_NM
        posts[9] = SUPRT_INST_NM
        detailTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                        print("detail XPOS : ", XPOS)
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
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        if segue.identifier == "segueToMapView" {
            if let mapViewController = segue.destination as? MapViewController {
                mapViewController.XPos = XPOS
                mapViewController.YPos = YPOS
                mapViewController.CONT = fastvl_cont
                mapViewController.BEGIN_DE = FASTVL_BEGIN_DE
            }
        }
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
