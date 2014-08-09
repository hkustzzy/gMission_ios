//
//  Checkin.swift
//  gMission
//
//  Created by Joshua Zhao on 14-7-20.
//  Copyright (c) 2014年 Joshua Zhao. All rights reserved.
//

import UIKit

class Checkin: NSObject {

    var attachment_id:Int?
    var content:String?
    var created_on:String?
    var id:Int?
    var location_id:Int?
    var type:String?
    var user_id:Int?
    
    var checkinMapping:NSDictionary = NSDictionary(dictionary: [
            "attachment_id":"attachment_id",
            "content":"content",
            "created_on":"created_on",
            "id":"id",
            "location_id":"location_id",
            "type":"type",
            "user_id":"user_id"
        ])
    
    init() {
        
    }
    
    init(dict: NSDictionary){
//        var checkin:Checkin = Checkin()
        if dict["attachment_id"]{
            self.attachment_id = dict["attachment_id"] as? Int
            self.content = dict["content"] as? String
            self.created_on = dict["created_on"] as? String
            self.location_id = dict["location_id"] as? Int
        }
    }
    
//    init(json : NSDictionary!){
//        println(json)
//        println(checkinMapping)
//        var checkin:Checkin = Checkin.objectFromJSONObject(json, mapping: checkinMapping) as Checkin
//    }
    
    func display(){
        if attachment_id{
            println(attachment_id)
        }else{
            println("nope~")
        }
        println("\(attachment_id) , \(self.content), created_on:\(self.created_on) , location_id: \(self.location_id)" )
    
    }
    
}
