//
//  ViewController.swift
//  CircleClock
//
//  Created by lostin1 on 2015. 3. 13..
//  Copyright (c) 2015년 lostin. All rights reserved.
//

import UIKit
import QuartzCore

class ViewController: UIViewController {
    @IBOutlet weak var ballClock: ClockView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("updateClock"), userInfo: nil, repeats: true)
        println("clock frame width = \(ballClock.frame.width) height = \(ballClock.frame.height)")
        ballClock.defaultSetup()
        ballClock.timerStart()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
/*
    func updateClock() {
        let nowDate:NSDate = NSDate()
        let dateComponent:NSDateComponents = NSCalendar.currentCalendar().components(NSCalendarUnit.HourCalendarUnit|NSCalendarUnit.MinuteCalendarUnit|NSCalendarUnit.SecondCalendarUnit, fromDate: nowDate)
        let second:Int = dateComponent.second
        let minute:Int = dateComponent.minute
        let hour:Int = dateComponent.hour
        
        let secAngle:CGFloat = degreesToRadians(CGFloat(second)/60.0*360.0)
        let minAngle:CGFloat = degreesToRadians(CGFloat(minute)/60.0*360)
        let hourAngle:CGFloat = degreesToRadians(CGFloat(hour)/12.0*360) + minAngle/12.0
        
        println("second Angle \(secAngle) minute Angle \(minAngle) hour Angle \(hourAngle)")
    }
*/
}

