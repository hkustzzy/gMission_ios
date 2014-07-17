//
//  GeneralVCViewController.swift
//  gMission
//
//  Created by Joshua Zhao on 14-7-16.
//  Copyright (c) 2014年 Joshua Zhao. All rights reserved.
//

import UIKit

class GeneralVCViewController: UIViewController {

    @IBOutlet var myImage: UIImageView
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        myImage.image = UIImage(named: "simpleMenuButton")
    }

    
    override func viewWillAppear(animated: Bool) {
        self.navigationController.navigationBar.barTintColor = colorize(0x4F97B9,alpha: 1)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
