//
//  RESTClient.swift
//  gMission
//
//  Created by Joshua Zhao on 14-7-19.
//  Copyright (c) 2014年 Joshua Zhao. All rights reserved.
//

import Foundation

@objc
protocol APIControllerProtocol {
    func didReceiveAPIResults(results: NSDictionary)
}

let URL_BASE = "http://gmission-asia.cloudapp.net/gmission"
let URL_REST = "/rest"
let URL_IMAGE = "/image"
let URL_VIDEO = "/video"
let URL_AUDIO = "/audio"
let URL_COMMENT = "/answer_comment"
var URL_ORIGINAL = "/original"

var URL = URL_BASE + URL_BASE

class RESTClient{
    
    var delegate:APIControllerProtocol?
    
    init(delegate: APIControllerProtocol?){
        self.delegate = delegate
    }
    
    
    let URL_BASE = "http://gmission-asia.cloudapp.net/gmission"
    let URL_REST = "/rest"
    let URL_IMAGE = "/image"
    let URL_VIDEO = "/video"
    let URL_AUDIO = "/audio"
    let URL_COMMENT = "/answer_comment"
    var URL_ORIGINAL = "/original"
    
//    var URL = URL_BASE + URL_BASE
    
    let URL_IMAGE_ORI = "http://gmission-asia.cloudapp.net/gmission/image/original"
    let URL_VIDEO_ORI =  "http://gmission-asia.cloudapp.net/gmission/video/original"
    let URL_AUDIO_ORI = "http://gmission-asia.cloudapp.net/gmission/audio/original"
    let URL_VIDEO_THUMB = "http://gmission-asia.cloudapp.net/gmission/video/thumb"

    let URL_AUTH = "http://gmission-asia.cloudapp.net/gmission/user/login"
    let URL_REG = "http://gmission-asia.cloudapp.net/gmission/user/register"
    
    
    func getCheckins(){
        get(URL_BASE + URL_REST + "/checkin")
    }

    //Task
    func getTaskList(){
        get(URL_BASE + URL_REST + "/task")
    }
    
    func getTaskList(query:String){
//        println(query)
//        println(URL_BASE + URL_REST + "/task?q=" + query)
        get(URL_BASE + URL_REST + "/task?q=" + query)
    }
    
    func createTask(task: Task){
        
//        task.print()
//        var sampletask:Task = Task()
        
        var URLString:NSString = URL_BASE + URL_REST + "/task"
//        var parameters:NSDictionary = task.toDictionary()
//        var err: NSError?
//        var serializer:AFHTTPRequestSerializer = AFHTTPRequestSerializer()
//        let req:NSMutableURLRequest = serializer.requestWithMethod("POST", URLString: URLString, parameters: parameters, error: nil)
//        
//        var manager:AFURLSessionManager = AFURLSessionManager(
//            sessionConfiguration: NSURLSessionConfiguration.defaultSessionConfiguration());
//        let progress:NSProgress = NSProgress()


        JSONHTTPClient.postJSONFromURLWithString(URLString, bodyString: task.toJSONString(), completion: {
            response, err in
            if(err != nil){
                println(err)
            }
            if((response) != nil){
                println(response)
            }
            })
    }
    
    
    //Location
    func getLocationList(query:String){
        var urlString = URL_BASE + URL_REST + "/location"
        get(urlString + "?q=" + query)
    }
    
    func getLocationById(id:Int,completionHandler:(data:AnyObject)->Void){
        var urlString = URL_BASE + URL_REST + "/location/\(id)"
//        requestWithURL(urlString,completionHandler)
    }
    
    func getCategoryList(){
        var urlString = URL_BASE + URL_REST + "/category"
        get(urlString)
    }
    
    //task
    
        
    func upload(path:String){

        var urlString = URL_BASE + URL_IMAGE + "/upload"
        
        var url:NSURL = NSURL(fileURLWithPath: path)
        var file:NSData = NSData(contentsOfURL: url)
        
        let requestSuccess = {
            (operation :AFHTTPRequestOperation!, responseObject :AnyObject!) -> Void in
            
//            self.photos = responseObject.objectForKey("photos").objectForKey("photo") as Array
//            self.collectionView.reloadData()
            NSLog("requestSuccess \(responseObject)")
        }
        let requestFailure = {
            (operation :AFHTTPRequestOperation!, error :NSError!) -> Void in
            NSLog("requestFailure: \(error)")
        }

        
        var manage:AFHTTPRequestOperationManager = AFHTTPRequestOperationManager()
        manage.responseSerializer.acceptableContentTypes = manage.responseSerializer.acceptableContentTypes.setByAddingObject("text/html")
        manage.POST(urlString, parameters: nil, constructingBodyWithBlock: { data -> Void in
            data.appendPartWithFileData(file, name: "file", fileName: "image.jpg", mimeType: "image/jpeg")
            }, success: requestSuccess, failure: requestFailure)
        
    }
    
    
    func requestWithURL(urlString:String, completionHandler:(data:AnyObject)->Void){
        var URL = NSURL.URLWithString(urlString)
        var req = NSURLRequest(URL: URL)
        var queue = NSOperationQueue();
        NSURLConnection.sendAsynchronousRequest(req, queue: queue, completionHandler: { response, data, error in
            if (error != nil)
            {
                dispatch_async(dispatch_get_main_queue(),
                    {
                        println(error)
                        completionHandler(data:NSNull())
                    })
            }
            else
            {
                let jsonData = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
                
                dispatch_async(dispatch_get_main_queue(),
                    {
                        completionHandler(data:jsonData)
                        
                    })
            }
            })
    }
    
    
    func get(path: String){
        println(path)
        let url = NSURL(string: path)
        println(url==nil)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url, completionHandler: {data, response, error -> Void in
        println("Task completed")
            if(error != nil) {
                    // If there is an error in the web request, print it to the console
                    println(error.localizedDescription)
                    return
            }
                var err: NSError?
                var jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &err) as NSDictionary
                if(err != nil) {
                    // If there is an error parsing JSON, print it to the console
                    println("JSON Error (err!.localizedDescription)")
                }
//                println(jsonResult)
                self.delegate?.didReceiveAPIResults(jsonResult)
                })
            
            task.resume()
    }
    

}