//
//  DetailEventTableViewController.swift
//  Term Project
//
//  Created by kpugame on 2017. 5. 22..
//  Copyright © 2017년 DONGHYEOP SHIN. All rights reserved.
//

import UIKit

class DetailEventTableViewController: UITableViewController , XMLParserDelegate{

    @IBOutlet var detailTableView: UITableView!
    @IBAction func doneToPickerViewController6(segue: UIStoryboardSegue) {
    }
    var url : String?
    var name : String?
    var test : String?
    var parser = XMLParser()
    let postsname : [String] = ["행사이름","행사내용", "행사시작일", "행사종료일", "개최장소", "도로명주소", "전화번호", "홈페이지", "주관기관", "주최기관", "후원기관"]
    var posts : [String] = ["","","","","","","","","","",""]
    
    var element = NSString()
    
    var EVENT_CONT : String?
    var EVENT_TITLE : String?

    var EVENT_BEGIN_DE : String?
    var EVENT_END_DE  : String?
    var OPENMEET_PLC : String?
    var REFINE_ROADNM_ADDR : String?
    var MNGT_INST_TELNO : String?
    var HMPG_ADDR : String?
    var MNGT_INST_NM : String?
    var PROMOTER_INST_NM : String?
    var SUPRT_INST_NM : String?
    
    
    func beginParsing() {
        
        posts[0] = EVENT_TITLE!
        posts[1] = EVENT_CONT!
        posts[2] = EVENT_BEGIN_DE!
        posts[3] = EVENT_END_DE!
        posts[4] = OPENMEET_PLC!
        posts[5] = REFINE_ROADNM_ADDR!
        posts[6] = MNGT_INST_TELNO!
        posts[7] = HMPG_ADDR!
        posts[8] = MNGT_INST_NM!
        posts[9] = PROMOTER_INST_NM!
        posts[10] = SUPRT_INST_NM!

        detailTableView.reloadData()
    }
    
    // parser가 새로운 element를 발견하면 변수를 생성한다.
       // title과 pubDate를 발견하면 title1과 date에 완성한다.
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
        var cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "EventCell")!
        if(cell.isEqual(NSNull.self)) {
            cell = Bundle.main.loadNibNamed("EventCell", owner: self, options: nil)?[0] as! UITableViewCell
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
