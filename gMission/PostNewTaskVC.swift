//
//  PostNewTaskVC.swift
//  gMission
//
//  Created by Joshua Zhao on 14-7-22.
//  Copyright (c) 2014年 Joshua Zhao. All rights reserved.
//

import UIKit


class PostNewTaskVC: UIViewController,UITextViewDelegate,APIControllerProtocol {

    @IBOutlet var btnAskQuestion:UIButton!
    @IBOutlet var tvTaskContent: UITextView!
    @IBOutlet var lbTaskLocation: UILabel!
    
    lazy var api: RESTClient = RESTClient(delegate:self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tvTaskContent.keyboardType = UIKeyboardType.Default
        self.tvTaskContent.returnKeyType = UIReturnKeyType.Default
        self.tvTaskContent.scrollEnabled = true
        self.tvTaskContent.layer.cornerRadius = 10
        
        self.lbTaskLocation.layer.cornerRadius = 10
        
        self.view.addSubview(tvTaskContent)
        self.view.addSubview(lbTaskLocation)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func textViewDidBeginEditing(textView: UITextView!) {
        println("edit begin editing")
    }
    
    func textViewDidEndEditing(textView: UITextView!) {
        println(textView.text)
    }
    
    @IBAction func btnAsk_clicked(){
        println(self.tvTaskContent.text)
        
        var task: Task = Task(brief: self.tvTaskContent.text)
        println(task.toJSONString())
    
        api.createTask(task)
        
        var err: NSError?
        var configuration:NSURLSessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
        var manager:AFURLSessionManager = AFURLSessionManager(sessionConfiguration: configuration)
        var URL:NSURL = NSURL.URLWithString("http://example.com/upload")
        var req:NSURLRequest = NSURLRequest(URL:URL)
        var dd:NSData?
        
//        let dataTask:NSURLSessionUploadTask = manager.uploadTaskWithRequest(req, fromData: dd, progress: nil, completionHandler: { response:NSURLResponse data: NSData error:NSError -> Void
//            })
    }
    
    func didReceiveAPIResults(results: NSDictionary){
    }
    
   
}
