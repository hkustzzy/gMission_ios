//
//  MyTaskCell.swift
//  gMission
//
//  Created by Joshua Zhao on 14-8-29.
//  Copyright (c) 2014年 Joshua Zhao. All rights reserved.
//

import UIKit

class MyTaskCell:UITableViewCell {

    @IBOutlet var contentLabel:UILabel?
    @IBOutlet var locationLabel:UILabel?
    @IBOutlet var statusLabel:UILabel?
    @IBOutlet var timeLabel:UILabel?
    
    var data :NSDictionary!

    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func layoutSubviews()
    {
        super.layoutSubviews()
        // var uid = self.data["id"] as String
//        var data = self.data as NSDictionary
        
        var content = self.data["content"] as String
//        var height = content.stringHeightWith(17,width:300)
//        self.contentLabel!.setHeight(height)
        self.contentLabel!.text = content
        
        var location = self.data["location"] as String
        self.locationLabel!.text = location
        
        var time = self.data["time"] as String
        self.timeLabel!.text = time
        
    }

    
    
}