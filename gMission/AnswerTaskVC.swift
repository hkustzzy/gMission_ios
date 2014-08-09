//
//  AnswerTaskVC.swift
//  gMission
//
//  Created by Joshua Zhao on 14-7-30.
//  Copyright (c) 2014年 Joshua Zhao. All rights reserved.
//

import Foundation

class AnswerTaskVC: UIViewController, RKTabViewDelegate, UINavigationControllerDelegate,UIImagePickerControllerDelegate, UIActionSheetDelegate, APIControllerProtocol{
    
    var task:Task?
    
    @IBOutlet var locationLable:UILabel!
    @IBOutlet var contentLable:UILabel!
    @IBOutlet var answerView:UIView!
    @IBOutlet var addAttachBtn:UIButton!
    @IBOutlet var textAnswerTf:UITextField!
    @IBOutlet var thumbNailIV:UIImageView!
    
    
    var tabView:RKTabView!
    var flag:Bool = false
    var attachmentView:UIView!
    var sheet:UIActionSheet!
    var isFullScreen:Bool = false
    
    let kSuccessTitle = "Congratulations"
    let kErrorTitle = "Connection error"
    let kNoticeTitle = "Notice"
    let kWarningTitle = "警告"
    let kInfoTitle = "Info"
    let kSubtitle = "请输入内容"
    
    
    lazy var api: RESTClient = RESTClient(delegate:self)

    
    @IBAction func sendClicked(){
        
//        iToast.makeText("send clicked").show()
        
        if(flag && self.thumbNailIV.image != nil){ //have attachment
            
            println("have attachment")
            
        }else if(textAnswerTf.text == ""){
            
            SCLAlertView().showWarning(self, title: kWarningTitle, subTitle: kSubtitle)
            
        }else{
         
            SCLAlertView().showInfo(self, title: "info", subTitle: "yes")
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        attachmentView = UIView(frame: CGRectMake(20, 240, 280, 100))
        
        tabView = RKTabView()
        tabView.frame = CGRectMake(0, 0, 280, 45)
        tabView.backgroundColor = UIColor.lightTextColor()
        
        var cameraTabItem:RKTabItem = RKTabItem.createUsualItemWithImageEnabled(UIImage(named: "camera_enabled"), imageDisabled: UIImage(named:"camera_disabled"))
        var videoTabItem:RKTabItem = RKTabItem.createUsualItemWithImageEnabled(UIImage(named: "camera_enabled"), imageDisabled: UIImage(named:"camera_disabled"))
        var audioTabItem:RKTabItem = RKTabItem.createUsualItemWithImageEnabled(UIImage(named: "camera_enabled"), imageDisabled: UIImage(named:"camera_disabled"))
        
        self.tabView.horizontalInsets = HorizontalEdgeInsets(left: 40,right: 40)
        self.tabView.enabledTabBackgrondColor = UIColor(red:103.0/256.0, green: 87.0/256.0, blue: 226.0/256.0, alpha: 0.5)
        self.tabView.tabItems = [cameraTabItem, videoTabItem, audioTabItem]
        
        attachmentView.addSubview(tabView)
        
        
        thumbNailIV = UIImageView(frame: CGRectMake(120, 295, 80, 100))
//        thumbNailIV.backgroundColor = UIColor(red:103.0/256.0, green: 87.0/256.0, blue: 226.0/256.0, alpha: 0.5)
        thumbNailIV.backgroundColor = UIColor.clearColor()
//        self.view.addSubview(thumbNailIV)
        
    }
    
    override func viewWillAppear(animated: Bool) {
//        self.tabView.removeFromSuperview()
    }
    
    func tabView(tabView: RKTabView!, tabBecameDisabledAtIndex index: Int32, tab tabItem: RKTabItem!) {
        println("tab \(index) disenabled ")
    }
    
    func tabView(tabView: RKTabView!, tabBecameEnabledAtIndex index: Int32, tab tabItem: RKTabItem!) {
        println("tab \(index) enabled ")
        
        if(index == 0){
            
            if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)){
                
                sheet = UIActionSheet(title: "选择", delegate: self, cancelButtonTitle: nil, destructiveButtonTitle: "取消", otherButtonTitles: "拍照","从相册选择")
                
            }else{
                sheet = UIActionSheet(title: "选择", delegate: self, cancelButtonTitle: nil, destructiveButtonTitle: "取消", otherButtonTitles: "从相册选择")
            }
            
            sheet.tag = 255
            sheet.showInView(self.view)
        
        }
        
    }
    
    @IBAction func addAttachClicked(){
        
        if(!flag){
            println(self.tabView.tabItems.count)
//            self.answerView.addSubview(self.tabView)
            self.view.addSubview(self.attachmentView)
            self.view.addSubview(thumbNailIV)
            self.tabView.delegate = self
        }
        else{
            self.attachmentView.removeFromSuperview()
            self.thumbNailIV.removeFromSuperview()
        }
        flag = !flag
    }
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]!) {
        println("imagePickerController,didFinishPickingMediaWithInfo")
        picker.dismissViewControllerAnimated(true, completion: {})
        var string:NSObject = NSObject()
        string = UIImagePickerControllerOriginalImage;
        
        var image:UIImage = info[UIImagePickerControllerOriginalImage] as UIImage
        saveImage(image, imageName: "image.jpg")
        
        var fullPath:NSString = NSHomeDirectory().stringByAppendingPathComponent("Documents").stringByAppendingPathComponent("image.jpg")
        
        var savedImage:UIImage = UIImage(contentsOfFile: fullPath)
        
        println(fullPath)
        isFullScreen = false
        self.thumbNailIV.image = savedImage
        self.thumbNailIV.tag = 100
        
        self.view.addSubview(thumbNailIV)
        self.view.bringSubviewToFront(thumbNailIV)
        
        api.upload(fullPath)
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController!) {
        
    }
    
    func actionSheet(actionSheet: UIActionSheet!, clickedButtonAtIndex buttonIndex: Int){
        
        if (actionSheet.tag == 255) {
            
            var sourceType:UIImagePickerControllerSourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum;
            
            if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)){
                switch (buttonIndex) {
                case 0: // 取消
                    return;
                case 1: // 相机
                    sourceType = UIImagePickerControllerSourceType.Camera;
                    break;
                case 2: // 相册
                    sourceType = UIImagePickerControllerSourceType.PhotoLibrary;
                    break;
                default:
                    break
                }
            }
            else {
                if (buttonIndex == 0) {
                    return;
                } else {
                    sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum;
                }
            }
            
            var picker:UIImagePickerController = UIImagePickerController()
            picker.delegate = self
            picker.allowsEditing = true
            picker.sourceType = sourceType
            self.presentViewController(picker, animated: false, completion: {})
            
        }
        
    }
    
    
    func saveImage(currentImage:UIImage, imageName:NSString){
        
        var imageData:NSData = UIImageJPEGRepresentation(currentImage,0.5)
        var fullPath = NSHomeDirectory().stringByAppendingPathComponent("Documents").stringByAppendingPathComponent(imageName)
        imageData.writeToFile(fullPath, atomically: false)
        
    }
    
    override func touchesBegan(touches: NSSet!, withEvent event: UIEvent!) {
        
        println("touchesBegan")
        isFullScreen = !isFullScreen
        var touch:UITouch = touches.anyObject() as UITouch
        var touchPoint:CGPoint = touch.locationInView(self.view)
        var imagePoint:CGPoint = self.thumbNailIV.frame.origin
        
        if(imagePoint.x <= touchPoint.x && imagePoint.x + self.thumbNailIV.frame.size.width >= touchPoint.x && imagePoint.y <=  touchPoint.y && imagePoint.y+self.thumbNailIV.frame.size.height >= touchPoint.y){
            
            println("hello")
            
            UIView.beginAnimations(nil, context: nil)
            
            UIView.setAnimationDuration(0.5)
            
            if(isFullScreen){
                self.view.bringSubviewToFront(thumbNailIV)
                self.thumbNailIV.frame = CGRectMake(0, 0, 320, 480)
                self.view.bringSubviewToFront(thumbNailIV)

            }else{
                self.thumbNailIV.frame = CGRectMake(100, 295, 80, 100)
            }
            
            UIView.commitAnimations()
        }
        
    }
    
    func photoFromCamera(){
        
        if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)){
            var sourceType:UIImagePickerControllerSourceType = UIImagePickerControllerSourceType.Camera
            var picker:UIImagePickerController = UIImagePickerController()
            picker.delegate = self
            picker.allowsEditing = true
            picker.sourceType = sourceType
            self.presentViewController(picker, animated: false, completion: {})
            
            
//            var overLayImag:UIImage =[UIImage imageNamed:@"zhaoxiangdingwei.png"];
//            UIImageView *bgImageView=[[UIImageView alloc]initWithImage:overLayImag];
//            [overLayView addSubview:bgImageView];
//            picker.cameraOverlayView=overLayView;
//            picker.cameraDevice=UIImagePickerControllerCameraDeviceFront;//选择前置摄像头或后置摄像头
//            [self presentViewController:picker animated:YES completion:^{
//            }];
            
        
        }
    }
    
    func didReceiveAPIResults(results: NSDictionary) {
    
    }
    
    
}