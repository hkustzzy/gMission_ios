//
//  RightMenuViewController.swift
//  gMission
//
//  Created by Joshua Zhao on 14-7-15.
//  Copyright (c) 2014年 Joshua Zhao. All rights reserved.
//

import UIKit

class RightMenuViewController: AMSlideMenuRightTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        println(segue.identifier)
    }
    
    
}
