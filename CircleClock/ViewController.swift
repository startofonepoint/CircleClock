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
}

