//
//  Bubble.swift
//  gMission
//
//  Created by Joshua Zhao on 14-7-29.
//  Copyright (c) 2014年 Joshua Zhao. All rights reserved.
//

import Foundation
import UIKit

@objc(LocationBubble)
class LocationBubble:UIView{

    @IBOutlet var nameLabel:UILabel!
    @IBOutlet var locationLabel:UILabel!
    @IBOutlet var timeLabel:UILabel!
    @IBOutlet var askBtn:UIButton!
    @IBOutlet var naviBtn:UIButton!
    
    required init(coder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        naviBtn.backgroundColor = UIColor.blueColor()
        naviBtn.layer.cornerRadius = 4
    }
    
    @IBAction func AskBtnClicked(){
    
    }
    
    @IBAction func NaviBtnClicked(){
        
    }
    
}