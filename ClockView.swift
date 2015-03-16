//
//  ClockView.swift
//  CircleClock
//
//  Created by lostin1 on 2015. 3. 14..
//  Copyright (c) 2015년 lostin. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore

func degreesToRadians(degrees:CGFloat) ->CGFloat {
    let pi = CGFloat(M_PI)
    var radians:CGFloat = degrees * pi
    radians = radians / CGFloat(180)
    return radians
}

class ClockView:UIImageView
{
    var hourIndicator:CALayer!
    var minuteIndicator:CALayer!
    var secondIndicator:CALayer!
    var clockFace:CALayer!
    var hrLabel:UILabel!
    var minLabel:UILabel!
    var secLabel:UILabel!
    var timer:NSTimer?
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        timer = nil
        self.defaultSetup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let frameWidth = self.frame.size.width
        let frameHeight = self.frame.size.height
        println("ClockView Frame width = \(frameWidth) height = \(frameHeight)")
        
        var width:CGFloat  //이미지의 width저장(원래사이즈)
        var height:CGFloat //이미지의 height저장(원래사이즈)
        var scale = CGFloat(1) //디바이스의 배율 저장
        var imageRatio:CGFloat //화면에 보이는 이미지와 원래 이미지의 비율
        
        if UIScreen.mainScreen().respondsToSelector(Selector("scale")) {
            scale = UIScreen.mainScreen().scale
        }
        width = CGFloat(CGImageGetWidth(clockFace.contents as CGImageRef))/scale
        height = CGFloat(CGImageGetHeight(clockFace.contents as CGImageRef))/scale
        println("ClockFace width = \(width) height = \(height)")
        
        if frameWidth > frameHeight {  //device가 landscape일때(즉 height가 기준)
            clockFace.frame = CGRect(x: 0,y: 0,width: frameHeight, height: frameHeight)
            println("before move clockFace positio x = \(clockFace.position.x) position y = \(clockFace.position.y)")
            let center:CGPoint = CGPointMake(frameHeight/2, frameHeight/2)
            hourIndicator.position = center
            minuteIndicator.position = center
            secondIndicator.position = center
            clockFace.position = CGPointMake(frameWidth/2, frameHeight/2)
            println("after clockFace positio x = \(clockFace.position.x) position y = \(clockFace.position.y)")
            imageRatio = frameHeight / height
        }
        else { //device가 portrait일때(즉 width가 기준)
            clockFace.frame = CGRect(x: 0,y: 0,width: frameWidth, height: frameWidth)
            println("before move clockFace positio x = \(clockFace.position.x) position y = \(clockFace.position.y)")
            let center:CGPoint = CGPointMake(frameWidth/2, frameWidth/2)
            hourIndicator.position = center
            minuteIndicator.position = center
            secondIndicator.position = center
            clockFace.position = CGPointMake(frameWidth/2, frameHeight/2)
            println("after move clockFace positio x = \(clockFace.position.x) position y = \(clockFace.position.y)")
            imageRatio = frameWidth / width
        }
        println("image ratio is \(imageRatio)")
        
        width = CGFloat(CGImageGetWidth(hourIndicator.contents as CGImageRef))/scale * imageRatio
        height = CGFloat(CGImageGetHeight(hourIndicator.contents as CGImageRef))/scale * imageRatio
        println("hourIndicator width = \(width) height = \(height)")
        hourIndicator.bounds = CGRectMake(0, 0, width, height)
        
        width = CGFloat(CGImageGetWidth(minuteIndicator.contents as CGImageRef))/scale * imageRatio
        height = CGFloat(CGImageGetHeight(minuteIndicator.contents as CGImageRef))/scale * imageRatio
        println("minuteIndicator width = \(width) height = \(height)")
        minuteIndicator.bounds = CGRectMake(0, 0, width, height)
        
        width = CGFloat(CGImageGetWidth(secondIndicator.contents as CGImageRef))/scale * imageRatio
        height = CGFloat(CGImageGetHeight(secondIndicator.contents as CGImageRef))/scale * imageRatio
        println("secondIndicator width = \(width) height = \(height)")
        secondIndicator.bounds = CGRectMake(0, 0, width, height)
        
        //시간표시라벨의 회전점을 객체의 중심으로 설정
        hrLabel.layer.anchorPoint = CGPointMake(0.5,0.5)
        minLabel.layer.anchorPoint = CGPointMake(0.5,0.5)
        secLabel.layer.anchorPoint = CGPointMake(0.5,0.5)
        
        //시간표시기의 회전점을 객체 하단 중앙으로 설정
        hourIndicator.anchorPoint = CGPointMake(0.5, 1)
        minuteIndicator.anchorPoint = CGPointMake(0.5, 1)
        secondIndicator.anchorPoint = CGPointMake(0.5, 1)
    }
    //기본화면 설정 함수
    func defaultSetup() {
        timer = nil
        clockFace = CALayer()
        hourIndicator = CALayer()
        minuteIndicator = CALayer()
        secondIndicator = CALayer()
        
        //시간 표시 라벨 설정
        hrLabel = UILabel()
        minLabel = UILabel()
        secLabel = UILabel()
        hrLabel.textAlignment = NSTextAlignment.Center
        minLabel.textAlignment = NSTextAlignment.Center
        secLabel.textAlignment = NSTextAlignment.Center
        hrLabel.textColor = UIColor.whiteColor()
        minLabel.textColor = UIColor.whiteColor()
        secLabel.textColor = UIColor.whiteColor()
        let labelFont = UIFont(name: "Helvetica neue", size: CGFloat(25))
        hrLabel.font = labelFont
        minLabel.font = labelFont
        secLabel.font = labelFont
        hrLabel.text = "12"
        minLabel.text = "0"
        secLabel.text = "0"
        
        //bright base로 설정
        clockFace.borderColor = UIColor.clearColor().CGColor
        clockFace.borderWidth = 0.0
        clockFace.cornerRadius = 0.0
        
        hourIndicator.borderColor = UIColor.clearColor().CGColor
        hourIndicator.borderWidth = 0.0
        hourIndicator.cornerRadius = 0.0
        
        minuteIndicator.borderColor = UIColor.clearColor().CGColor
        minuteIndicator.borderWidth = 0.0
        minuteIndicator.cornerRadius = 0.0
        
        secondIndicator.borderColor = UIColor.clearColor().CGColor
        secondIndicator.borderWidth = 0.0
        secondIndicator.cornerRadius = 0.0
        
        //기본이미지 설정
        clockFace.contents = UIImage(named: "CircleClockFace_b")?.CGImage
        hourIndicator.contents = UIImage(named: "HourBall")?.CGImage
        minuteIndicator.contents = UIImage(named: "MinBall")?.CGImage
        secondIndicator.contents = UIImage(named: "SecBall")?.CGImage
        
        //라벨 frame설정
        let width = CGFloat(CGImageGetWidth(hourIndicator.contents as CGImageRef))
        hrLabel.frame = CGRectMake(0, 0, width, width)
        minLabel.frame = CGRectMake(0, 0, width, width)
        secLabel.frame = CGRectMake(0, 0, width, width)
        
        //각 라벨을 시간 표시기 layer에 추가한다.
        hourIndicator.addSublayer(hrLabel.layer)
        minuteIndicator.addSublayer(minLabel.layer)
        secondIndicator.addSublayer(secLabel.layer)
        
        //시간표시기layer를 시계바탕에 추가한다.
        clockFace.addSublayer(hourIndicator)
        clockFace.addSublayer(minuteIndicator)
        clockFace.addSublayer(secondIndicator)
        //시계바탕을 view의 layer에 추가한다.
        self.layer.addSublayer(clockFace)
    }
    
    //시계바탕 이미지를 설정하는 함수
    func setClockFaceImage(image:CGImageRef) {
        clockFace.borderColor = UIColor.clearColor().CGColor
        clockFace.borderWidth = 0.0
        clockFace.cornerRadius = 0.0
        clockFace.contents = image
    }
    //타이머 시작함수
    func timerStart() {
        println("called timeStart Function")
        self.updateClock()
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("updateClock"), userInfo: nil, repeats: true)
    }
    //타이머 종료함수
    func timerStop() {
        timer?.invalidate()
        timer = nil
    }
    //타이머가 1초마다 호출하는 함수
    func updateClock() {
        let nowDate:NSDate = NSDate()
        let dateComponent:NSDateComponents = NSCalendar.currentCalendar().components(NSCalendarUnit.HourCalendarUnit|NSCalendarUnit.MinuteCalendarUnit|NSCalendarUnit.SecondCalendarUnit, fromDate: nowDate)
        let second:Int = dateComponent.second
        let minute:Int = dateComponent.minute
        let hour:Int = dateComponent.hour
        //시간을 label에 저장
        hrLabel.text = "\(hour)"
        minLabel.text = "\(minute)"
        secLabel.text = "\(second)"
        //시간에 따른 각도를 구함
        let secAngle:CGFloat = degreesToRadians(CGFloat(second)/60.0*360.0)
        let minAngle:CGFloat = degreesToRadians(CGFloat(minute)/60.0*360)
        let hourAngle:CGFloat = degreesToRadians(CGFloat(hour)/12.0*360) + minAngle/12.0
        
        //println("second Angle \(secAngle) minute Angle \(minAngle) hour Angle \(hourAngle)")
        
        //시간라벨을 수평으로 유지하도록 시간표시기가 회전하는 각도만큼 원래대로 돌린다.
        hrLabel.layer.transform = CATransform3DMakeRotation(-hourAngle, 0, 0, 1)
        minLabel.layer.transform = CATransform3DMakeRotation(-minAngle, 0, 0, 1)
        secLabel.layer.transform = CATransform3DMakeRotation(-secAngle, 0, 0, 1)
        //시간표시기를 회전시킨다.
        hourIndicator.transform = CATransform3DMakeRotation(hourAngle, 0, 0, 1)
        minuteIndicator.transform = CATransform3DMakeRotation(minAngle, 0, 0, 1)
        secondIndicator.transform = CATransform3DMakeRotation(secAngle, 0, 0, 1)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.defaultSetup()
    }
}