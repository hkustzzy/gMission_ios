//
//  QueryObject.swift
//  gMission
//
//  Created by Joshua Zhao on 14-7-21.
//  Copyright (c) 2014年 Joshua Zhao. All rights reserved.
//

import Foundation

var jd:JSONDecoder = JSONDecoder()


struct FilterObject{
    
    var dict:NSDictionary
    
    init(name:String, op:String, val:String){
        self.dict = NSDictionary(dictionary: [
            "name":name,
            "op":op,
            "val":val
            ])
    }
    
    func getJson() ->String{
        
            return dict.JSONString()
//        }else{
//            println("dict is nil")
//            return nil
//        }
    }
}

struct OrderObject{
    
    var dict:NSDictionary?
    init(field:String, direction:String){
        dict = NSDictionary(dictionary: [
            "field":field,
            "direction":direction
            ])
    }
    
    func getJson() ->String{
        return self.dict!.JSONString()
    }
}
class QueryObject{
    
    var filters:[String] = []
    var order_by:[String] = []
    
    var query:Dictionary<String, [AnyObject]> = [
        "filters":[],
        "order_by":[]
        ]

    
    func appendFilter(filter:FilterObject!){
            filters.append(filter.getJson())
    }
    func  setOrder(order:OrderObject!){
//        var order_by:[OrderObject] = (self.query["order_by"] as [OrderObject])
//        order_by.append(order)
        self.order_by.append(order.getJson())
    }
    
    func getQuery() -> String{
        var dict:NSDictionary = ["filters": self.filters, "order_by":self.order_by]
        return "{\"filters\":\(self.filters),\"order_by\":\(self.order_by)}".stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
    }

}