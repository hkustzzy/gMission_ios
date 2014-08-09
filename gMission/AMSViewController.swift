//
//  AMSViewController.swift
//  gMission
//
//  Created by Joshua Zhao on 14-7-15.
//  Copyright (c) 2014年 Joshua Zhao. All rights reserved.
//

import UIKit


func colorize (hex: Int, alpha: Double = 1.0) -> UIColor {
    let red = Double((hex & 0xFF0000) >> 16) / 255.0
    let green = Double((hex & 0xFF00) >> 8) / 255.0
    let blue = Double((hex & 0xFF)) / 255.0
    var color: UIColor = UIColor( red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha:CGFloat(alpha) )
    return color
}

class AMSViewController: AMSlideMenuMainViewController{

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.disableSlidePanGestureForLeftMenu()
        self.disableSlidePanGestureForRightMenu()
        
        println("\(self.rightPanDisabled),\(self.rightPanDisabled)")
        
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController.navigationBar.barTintColor = colorize(0x4F97B9,alpha: 1)
        
//        self.leftPanDisabled = true
//        self.rightPanDisabled = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func segueIdentifierForIndexPathInLeftMenu(indexPath: NSIndexPath!) -> String! {
        println("LeftMenu index: \(indexPath.row)")
        return "leftContent"
    }
    
    override func segueIdentifierForIndexPathInRightMenu(indexPath: NSIndexPath!) -> String! {
        println("RightMenu index: " + indexPath.row.description)
        return "rightContent"
    }
    
    override func deepnessForLeftMenu() -> Bool {
        return true
    }
    
    override func panGestureWarkingAreaPercent() -> CGFloat {
        return 0.5
    }
    
    
//    override func disableSlidePanGestureForLeftMenu() {
//        self.leftPanDisabled = true
//    }
//
//    override func disableSlidePanGestureForRightMenu() {
//        self.rightPanDisabled  = true
//    }
    
    
    override func configureLeftMenuButton(button: UIButton!) {
//        CGRect frame = button.frame;
        println("configureLeftMenuButton")
        button.frame = CGRectMake(0, 0, 25, 25);
        button.backgroundColor = UIColor.clearColor();
        button.setImage(UIImage(named: "v3_ic_action_user"), forState: UIControlState.Normal)
        
    }
    
    override func configureRightMenuButton(button: UIButton!) {
        println("configureRightMenuButton")
//        button = UIButton.buttonWithType(UIButtonType.System) as UIButton
        button.frame = CGRectMake(0, 0, 25, 20);
        button.backgroundColor = UIColor.clearColor();
        button.setImage(UIImage(named: "v3_ic_action_list"), forState: UIControlState.Normal)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject) {
        println("prepareForSegue: " + segue.identifier)

//        if(segue.identifier == "leftMenu"){
////            var navigationController: UINavigationController = segue.destinationViewController as UINavigationController
//            println("choose left")
//            var leftMenu :LeftMenuViewController = segue.destinationViewController as LeftMenuViewController
////            self.navigationController.pushViewController(leftMenu, animated: false)
//
//        }else if(segue.identifier == "rightMenu"){
////            var navigationController: UINavigationController = segue.destinationViewController as UINavigationController
//            println("choose right")
//            var rightMenu :RightMenuViewController = segue.destinationViewController as RightMenuViewController
//        }
    }
    
}
