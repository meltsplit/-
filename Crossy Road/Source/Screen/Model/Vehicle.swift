//
//  Car.swift
//  Crossy Road
//
//  Created by 장석우 on 2022/06/27.
//

import Foundation
import UIKit

protocol movable{
    func moveRight()
    func moveLeft()
}

class Vehicle : movable{
    var body = UIView()
    let color : UIColor
    let speed : Speed
    var width : CGFloat?
    
    init(/*y : CGFloat, */color : UIColor,speed : Speed){
        //self.y = y
        self.speed = speed
        self.color = color
        
        self.body.frame.origin.x = -11111
        self.body.backgroundColor = color
    }
    
    func moveRight() {
        var x : CGFloat = -self.width!
        DispatchQueue.global().async {
            while (x < 414){
                x =  x + 1
                DispatchQueue.main.async {
                    self.body.frame = CGRect(origin: CGPoint(x: x,y: self.body.frame.origin.y), size: self.body.frame.size)
                }
                usleep(self.speed.rawValue)
               
            }
        }
    }
    
    func moveLeft() {
        var x : CGFloat = 414
        DispatchQueue.global().async {
            while (x > -self.width!){
                x = x - 1
                DispatchQueue.main.async {
                    self.body.frame = CGRect(origin: CGPoint(x: x,y: self.body.frame.origin.y), size: self.body.frame.size)
                }
                usleep(self.speed.rawValue)
               
            }
        }
    }
    
}

class Car : Vehicle{
    override init(color: UIColor, speed: Speed) {
        super.init(color: color, speed: speed)
        body.frame.size = CGSize(width: 40, height: 40)
        width = body.frame.size.width
    }
}

class Bus : Vehicle{
    override init( color: UIColor, speed: Speed) {
        super.init(color: color, speed: speed)
        body.frame.size = CGSize(width: 80, height: 40)
        width = body.frame.size.width
    }
}

extension Vehicle{
    static var vehicles1 = [
        Car(color: UIColor.red, speed: Speed.Fast),
        Car(color: UIColor.orange, speed: Speed.Slow),
        Bus(color: UIColor.yellow, speed: Speed.Fast),
        Car(color: UIColor.green, speed: Speed.Normal),
        Car(color: UIColor.blue, speed: Speed.Fast)
    ]
    static var vehicles2 = [
        Car(color: UIColor.purple, speed: Speed.Fast),
        Bus(color: UIColor.systemPink, speed: Speed.Fast),
        Car(color: UIColor.cyan, speed: Speed.VeryFast),
        Car(color: UIColor.brown, speed: Speed.Slow),
        Car(color: UIColor.red, speed: Speed.VeryFast)
    ]
    static var vehicles3 = [
        Car(color: UIColor.red, speed: Speed.Fast),
        Car(color: UIColor.orange, speed: Speed.Slow),
        Bus(color: UIColor.yellow, speed: Speed.Fast),
        Car(color: UIColor.green, speed: Speed.Normal),
        Car(color: UIColor.blue, speed: Speed.Fast)
    ]
    static var vehicles4 = [
        Car(color: UIColor.purple, speed: Speed.Fast),
        Bus(color: UIColor.systemPink, speed: Speed.Fast),
        Car(color: UIColor.cyan, speed: Speed.VeryFast),
        Car(color: UIColor.brown, speed: Speed.Slow),
        Car(color: UIColor.red, speed: Speed.VeryFast)
    ]
    static var vehicles5 = [
        Car(color: UIColor.purple, speed: Speed.Fast),
        Bus(color: UIColor.systemPink, speed: Speed.Fast),
        Car(color: UIColor.cyan, speed: Speed.VeryFast),
        Car(color: UIColor.brown, speed: Speed.Slow),
        Car(color: UIColor.red, speed: Speed.VeryFast)
    ]
    static var vehicles6 = [
        Car(color: UIColor.red, speed: Speed.Fast),
        Car(color: UIColor.orange, speed: Speed.Slow),
        Bus(color: UIColor.yellow, speed: Speed.Fast),
        Car(color: UIColor.green, speed: Speed.Normal),
        Car(color: UIColor.blue, speed: Speed.Fast)
    ]

}
