//
//  Road.swift
//  Crossy Road
//
//  Created by 장석우 on 2022/06/29.
//

import Foundation
import UIKit
struct Road{
    let vehicles : [Vehicle]
}
extension Road{
    static var road1 = Road(vehicles: vehicles1)
    static var road2 = Road(vehicles: vehicles2)
    static var vehicles1 = [
        Car(y: 720, color: UIColor.red, speed: Speed.Fast),
        Car(y: 720, color: UIColor.orange, speed: Speed.Slow),
        Bus(y: 720, color: UIColor.yellow, speed: Speed.Fast),
        Car(y: 720, color: UIColor.green, speed: Speed.Normal),
        Car(y: 720, color: UIColor.blue, speed: Speed.Fast)
    ]
    static var vehicles2 = [
        Car(y: 600, color: UIColor.purple, speed: Speed.Fast),
        Bus(y: 600, color: UIColor.systemPink, speed: Speed.Fast),
        Car(y: 600, color: UIColor.cyan, speed: Speed.VeryFast),
        Car(y: 600, color: UIColor.brown, speed: Speed.Slow),
        Car(y: 600, color: UIColor.red, speed: Speed.VeryFast)
    ]

}
