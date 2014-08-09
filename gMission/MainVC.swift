//
//  GeneralVCViewController.swift
//  gMission
//
//  Created by Joshua Zhao on 14-7-16.
//  Copyright (c) 2014年 Joshua Zhao. All rights reserved.
//

import UIKit

class MainVC: UIViewController, BMKLocationServiceDelegate, APIControllerProtocol, BMKMapViewDelegate {
    
    
    //view element
    @IBOutlet var myImage: UIImageView!
    @IBOutlet var btAskQuestion: UIButton!
    @IBOutlet var mapView : BMKMapView!
    @IBOutlet var options: UISegmentedControl!
    
    
    //element action
    @IBAction func btnAsk_Clicked(){
        
    }
    @IBAction func optionChanged(){
        println(options.selectedSegmentIndex)
        clearMap()
        loadData()
    }
    
    //data structure
    var locationService:BMKLocationService?
    var tasks:[Task] = []
    var locations:[Location] = []
    var categories:[LocationCategory] = []
    var calloutMapAnnotation:CalloutMapAnnotation?

    
    lazy var api: RESTClient = RESTClient(delegate:self)
    
    let selections:Dictionary<String, Array<String>> = ["景点":["亚洲区","美洲区","世界广场","雕塑园","出入口","非洲区","欧洲区"],"表演":["欧洲区"],"餐饮":["购物","餐饮","出入口","售票处"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        println("viewDidLoad")
        
        locationService = BMKLocationService()
        locationService?.startUserLocationService()
        self.disableSlidePanGestureForLeftMenu();
        self.disableSlidePanGestureForRightMenu();
//        self.view = self.mapView
    }
    
    func setup(){
        println("setup")
        self.mapView.scrollEnabled = true
        var center:CLLocationCoordinate2D = CLLocationCoordinate2DMake(22.540134,113.979451)
        self.mapView.centerCoordinate = center
        self.mapView.zoomLevel = 16
        api.getCategoryList()
    }
    
    
    func didUpdateUserHeading(userLocation: BMKUserLocation!) {
        mapView?.updateLocationData(userLocation)
        println(userLocation.location.description)
    }
    
    func didUpdateUserLocation(userLocation: BMKUserLocation!) {
        mapView?.updateLocationData(userLocation)
        println(userLocation.location.description)
    }
    
    func didFailToLocateUserWithError(error: NSError!) {
        println(error)
    }
    
    override func viewDidAppear(animated: Bool) {
        println("viewDidAppear")
//        self.mapView.showsUserLocation = true
        
        setup()
        
    }
    
//    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
//        if(segue.identifier == "AnswerTask"){
//            var at:AnswerTaskVC =  segue.destinationViewController as AnswerTaskVC
//        }else{
//            
//        }
//    
//    }
//    
    func mapView(mapView: BMKMapView!, viewForAnnotation annotation: BMKAnnotation!) -> BMKAnnotationView! {
        
        println("viewForAnnotation start ")
        var annotationIdentifier:NSString = "customAnnotation";
        if (annotation.isKindOfClass(CustomPointAnnotation)) {
            println("this is CustomPointAnnotation")
            
            var annotationview:BMKPinAnnotationView = BMKPinAnnotationView(annotation:annotation,
                reuseIdentifier:annotationIdentifier)
            println("options index\(options.selectedSegmentIndex)")
            switch(options.selectedSegmentIndex){
            case 0:
                annotationview.image = UIImage(named:"v3_location_4")
                break
            case 1:
                annotationview.image = UIImage(named:"v3_location_show")
                break
            case 2:
                annotationview.image = UIImage(named:"v3_location_canteen")
                break
            default:
                annotationview.image = UIImage(named:"v3_task_1")
                break
            }
            annotationview.canShowCallout = false;
            return annotationview;
            
        }
        else if (annotation.isKindOfClass(CalloutMapAnnotation.classForCoder())){
            println("this is CalloutMapAnnotation")
            //此时annotation就是我们calloutview的annotation
            var ann:CalloutMapAnnotation = annotation as CalloutMapAnnotation;
            
//            //如果可以重用
//            var calloutannotationview:CallOutAnnotationView = mapView.dequeueReusableAnnotationViewWithIdentifier("calloutview") as CallOutAnnotationView;
//            var calloutannotationview:CallOutAnnotationView?
            //否则创建新的calloutView
//            if (calloutannotationview == nil) {
//
            var calloutannotationview = CallOutAnnotationView(annotation:annotation,reuseIdentifier:"calloutview");
            var cell:Bubble = NSBundle.mainBundle().loadNibNamed("Bubble", owner: self, options: nil)[0] as Bubble
            
            cell.naviButton.backgroundColor = UIColor.blueColor()
            cell.naviButton.layer.cornerRadius = 5

            cell.askButton.backgroundColor = UIColor.blueColor()
            cell.askButton.layer.cornerRadius = 5

            calloutannotationview.contentView.addSubview(cell)
            calloutannotationview.busInfoView = cell

            //开始设置添加marker时的赋值
            
            switch(options.selectedSegmentIndex){
            case 3:
                if(ann.locationInfo["location_name"]){
                    calloutannotationview.busInfoView.locationLabel.text = ann.locationInfo["location_name"] as NSString;
                }
                calloutannotationview.busInfoView.nameLabel.text = ann.locationInfo["brief"] as NSString;

                break
            default:
                println(ann.locationInfo)
                if(ann.locationInfo["category_name"]){
                    calloutannotationview.busInfoView.locationLabel.text = ann.locationInfo["category_name"] as NSString;
                }
                calloutannotationview.busInfoView.nameLabel.text = ann.locationInfo["name"] as NSString;
                break
            }

            return calloutannotationview;
            
        }else{
            println("none of above")
        }
        
        return BMKAnnotationView()

    }
    
    
    func mapView(mapView: BMKMapView!, didSelectAnnotationView view: BMKAnnotationView!) {
        
        println("didSelectAnnotationView")
        
        if(view.annotation){
            
        if(view.annotation.isKindOfClass(CustomPointAnnotation)){
            var annn:CustomPointAnnotation = view.annotation as CustomPointAnnotation
            println("this annotation is CustomPointAnnotation")
            
            if(calloutMapAnnotation?.coordinate.latitude == view.annotation.coordinate.latitude &&
                calloutMapAnnotation?.coordinate.longitude == view.annotation.coordinate.longitude){
                    println("already pop out this calloutMapAnnotation")
                    return
            }
            
            if(calloutMapAnnotation){
                println("already has one calloutMapAnnotation, remove it")
                self.mapView.removeAnnotation(calloutMapAnnotation)
                calloutMapAnnotation = nil
            }
            
            calloutMapAnnotation = CalloutMapAnnotation(latitude: view.annotation.coordinate.latitude, andLongitude: view.annotation.coordinate.longitude)
            calloutMapAnnotation!.locationInfo = annn.pointCalloutInfo
            self.mapView.addAnnotation(calloutMapAnnotation)
            self.mapView.centerCoordinate = view.annotation.coordinate
            
        }else if(view.annotation.isKindOfClass(CalloutMapAnnotation)){
            var annn:CalloutMapAnnotation = view.annotation as CalloutMapAnnotation
            println("\(annn.locationInfo) + clicked")
            self.performSegueWithIdentifier("AnswerTask", sender: self)
        }
            
        }else{
            println("view.annotation is null")
        }
    }
    
    func mapView(mapView: BMKMapView!, annotationViewForBubble view: BMKAnnotationView!) {
        println("annotationViewForBubble")
        
    }
    
    
    func mapView(mapView: BMKMapView!, didDeselectAnnotationView view: BMKAnnotationView!) {
        println("didDeselectAnnotationView")
        println(view.isKindOfClass(CallOutAnnotationView))
        
        if(calloutMapAnnotation){
            return
        }
        
        if(calloutMapAnnotation && !view.isKindOfClass(CallOutAnnotationView)){
            
            println("into didDeselectAnnotationView")
            if(calloutMapAnnotation?.coordinate.latitude == view.annotation.coordinate.latitude &&
                calloutMapAnnotation?.coordinate.longitude == view.annotation.coordinate.longitude){
                    println("remove calloutMapAnnotation inside didDeselectAnnotationView")
                    self.mapView.removeAnnotation(calloutMapAnnotation)
                    calloutMapAnnotation = nil
            }
            
        }
    }

    func mapView(mapView: BMKMapView!, onClickedMapBlank coordinate: CLLocationCoordinate2D) {
        println("click mapViewblank with coor: \(coordinate.latitude),\(coordinate.longitude)")
        if(calloutMapAnnotation){
            self.mapView.removeAnnotation(calloutMapAnnotation)
            calloutMapAnnotation = nil
        }
    }
    
    
    override func viewWillAppear(animated: Bool) {
        
        println("viewWillAppear")
        self.navigationController.navigationBar.barTintColor = colorize(0x4F97B9,alpha: 50)
//         self.navigationController.navigationBar.backgroundColor = UIColor.blueColor()
        
        self.mapView.viewWillAppear()
        self.mapView.delegate = self
        self.options.selected = false

    }
    
    override func viewWillDisappear(animated: Bool) {
        
        println("viewWillDisappear")
//        self.mapView.viewWillDisappear()
//        self.mapView.delegate = nil
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func didReceiveAPIResults(results: NSDictionary){
        var results =  results["objects"] as NSArray
        println("number: \(results.count)" )
        
        var dic:NSDictionary = results[0] as NSDictionary
        if(!dic.objectForKey("category_id") && !dic.objectForKey("location_id")){
            var err:AutoreleasingUnsafePointer<NSError?> = AutoreleasingUnsafePointer()
            for result in results{
                var category = LocationCategory(dictionary: result as NSDictionary, error: err)
                println(category.toDictionary())
                self.categories.append(category)
            }
            return
        }
        
        switch(options.selectedSegmentIndex){
        case 3:
            var err:AutoreleasingUnsafePointer<NSError?> = AutoreleasingUnsafePointer()
            for result in results{
                var task = Task(dictionary: result as NSDictionary, error: err)
                println(task.toDictionary())
                if(task.location_id != nil){
                    var url = "http://gmission-asia.cloudapp.net/gmission/rest/location/\(task.location_id)"
                        api.requestWithURL(url,completionHandler:{ data in
                        if data as NSObject == NSNull()
                        {
//                                            UIView.showAlertView("提示",message:"加载失败")
                            println("error")
                            return
                        }
                        var arr = data as NSDictionary
                        var loc:Location = Location(dictionary: arr,error:nil)
                        task.location = loc
                        task.location_name = loc.name
                        println("get location \(task.location_name)")
//                        self.tasks.append(task)
                        self.addTaskMarker(task)
                    })
                }
//                addTaskMarker(task)
            }
            break
        default:
            var err:AutoreleasingUnsafePointer<NSError?> = AutoreleasingUnsafePointer()
            for result in results{
                var location = Location(dictionary: result as NSDictionary, error: err)
                println(location.toDictionary())
                
//                if(self.categories.count > 0){
//
//                }
//                
//                if(location.category_id)
                
//                self.locations.append(location)
                addLocationMarker(location)
            }
            break
        }
    }
    
    
    func loadData()
    {
        switch(self.options.selectedSegmentIndex){
        case 3:
                    var query:QueryObject = QueryObject()
                    query.appendFilter(FilterObject(name: "status", op: "eq", val: "open"))
                    query.appendFilter(FilterObject(name: "location_id", op: "is_not_null", val: ""))
                    query.appendFilter(FilterObject(name: "status", op: "eq", val: "open"))
                    query.setOrder(OrderObject(field: "id", direction: "desc"))
                    var string = query.getQuery()
                    api.getTaskList(string)
            break
        default:
            var query:QueryObject = QueryObject()
            var filter:FilterObject = FilterObject(name: "category_id", op: "is_not_null", val: "")
            query.appendFilter(filter)
            api.getLocationList(query.getQuery())
            
            break
        }
    }
    
    
    func clearMap(){
        println("map clear")
        var array:NSArray  = NSArray(array: self.mapView.annotations)
        self.mapView.removeAnnotations(array)
    }

    func addTaskMarker(task:Task){
        
        if(!task.location){
            println("no location")
            return
        }
        var center:CLLocationCoordinate2D  = CLLocationCoordinate2DMake(
            task.location!.latitude, task.location!.longitude)
        
        var pointAnnotation:CustomPointAnnotation = CustomPointAnnotation();
        pointAnnotation.coordinate = center
        task.attachment_id = nil
        task.location = nil
        task.end_time = nil
        task.created_on = nil
        task.begin_time = nil
        println(".........\(task.toDictionary())")
        pointAnnotation.pointCalloutInfo = task.toDictionary()
//        pointAnnotation.pointCalloutInfo = NSDictionary(dictionary: ["title":task.brief])
        self.mapView.addAnnotation(pointAnnotation);
        
    }
    
    func addLocationMarker(loc:Location){
        
        if(self.categories.count > 0){
            for cate in self.categories{
                if(cate.id == loc.category_id.intValue){
                    loc.category_name = cate.name
                    break
                }
            }
        }else{
            println("!!!!!!!!!!!!no categories")
        }
        
        if(loc.category_name){
            if(addLocation(loc.category_name)){
                var center:CLLocationCoordinate2D  = CLLocationCoordinate2DMake(
                    loc.latitude, loc.longitude)
                var pointAnnotation:CustomPointAnnotation = CustomPointAnnotation();
                pointAnnotation.pointCalloutInfo = loc.toDictionary()
                println(".........\(loc.toDictionary())")
                pointAnnotation.coordinate = center
                    self.mapView.addAnnotation(pointAnnotation);
            }
        }
    }
    
    func addLocation(catename:NSString) -> Bool{
        switch(options.selectedSegmentIndex){
        case 0:
            var list = selections["景点"]! as NSArray
            if (list.containsObject(catename)){
                return true
            }
            break
        case 1:
            var list:NSArray = selections["表演"]!
            if (list.containsObject(catename)){
                return true
            }
            break
        case 2:
            var list:NSArray = selections["餐饮"]!
            if (list.containsObject(catename)){
                return true
            }
            break
        default:
            break
        }
        return false
    }
}
