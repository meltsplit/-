//
//  SampleData.swift
//  Crossy Road
//
//  Created by 장석우 on 2022/06/29.
//

import Foundation
import UIKit

struct Sample{
    let car1 = Car(color: UIColor.red, speed: Speed.Fast)
    let car2 =  Car(color: UIColor.orange, speed: Speed.Slow)
    let car3 = Car(color: UIColor.green, speed: Speed.Normal)
    let car4 = Car(color: UIColor.blue, speed: Speed.Fast)
    
    let bus1 = Bus(color: .yellow, speed: .Slow)
    let bus2 = Bus(color: .blue, speed: .VerySlow)
    
    let vehicles1 : [Vehicle] = [
        Car(color: UIColor.red, speed: Speed.Fast),
        Car(color: UIColor.orange, speed: Speed.Slow),
        Bus(color: .yellow, speed: .Slow),
        Car(color: UIColor.green, speed: Speed.Normal),
        Car(color: UIColor.blue, speed: Speed.Fast),
    ]
    
    let vehicles2 : [Vehicle] = [
        Car(color: .green, speed: .Fast),
        Car(color: .orange, speed: .Slow),
        Bus(color: .yellow, speed: .Slow),
        Car(color: .systemPink, speed: .Normal),
        Car(color: .blue, speed: .Fast),
    ]
    
    
//    static var road1 = Road(Vehicle.vehicles1, y: 720)
//    static var road2 = Road(Vehicle.vehicles2, y: 600)
//    static var road3 = Road(Vehicle.vehicles2, y: 540)
//    static var road4 = Road(Vehicle.vehicles2, y: 500)
//    static var road5 = Road(Vehicle.vehicles2, y: 420)
//    static var road6 = Road(Vehicle.vehicles2, y: 380)
//    
//    static var map1  = Map(roads: [
//        Road.road1,
//        Road.road2,
//        Road.road3,
//        Road.road4,
//        Road.road5,
//        Road.road6
//    ])
}
