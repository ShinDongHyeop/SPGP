//
//  ViewController.swift
//  Term Project
//
//  Created by KPUGAME on 2017. 5. 21..
//  Copyright © 2017년 DONGHYEOP SHIN. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBAction func done(segue:UIStoryboardSegue) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    var url : String = "http://openapi.gg.go.kr/CultureFestival?Key=8c1c7bdeab4842f981dd047006ad6886&type=xml"
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        if segue.identifier == "segueToTableView" {
            if let navController = segue.destination as? UINavigationController {
                if let festivalTableViewController = navController.topViewController as? FestivalTableViewController {
                    festivalTableViewController.url = url
                }
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func doneToPickerViewController(segue: UIStoryboardSegue) {
    }
    @IBAction func doneToPickerViewController2(segue: UIStoryboardSegue) {
    }


}
