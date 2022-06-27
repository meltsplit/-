//
//  Test2VC.swift
//  Crossy Road
//
//  Created by 장석우 on 2022/06/27.
//

import Foundation
import UIKit

class Test2VC : UIViewController{
  
    let player = UIView(frame: CGRect(x: 300, y: 200, width: 40, height: 40))
    
    let car1 = Car(y: 200, color: UIColor.orange, speed: Speed.Fast)
    let car2 = Car(y: 200, color: UIColor.green, speed: Speed.Normal)
    let bus1 = Bus(y: 400, color: UIColor.blue, speed: Speed.Slow)
    let car3 = Car(y: 400, color: UIColor.orange, speed: Speed.Fast)
    
    var road1 : [Vehicle]?
    var road2 : [Vehicle]?
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        player.backgroundColor = .red
        
        view.addSubview(player)
        view.addSubview(car1.body)
        view.addSubview(car2.body)
        view.addSubview(car3.body)
        view.addSubview(bus1.body)
        
        road1 = [car1,car2]
        road2 = [car3,bus1]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        moveCar(road1!, Direction.Left,delay: Second.sec(4))
        moveCar(road2!, Direction.Right,delay: Second.sec(2))
    }
        
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkAccident()
    }
    
    private func moveCar(_ road : [Vehicle],_ direction : Direction ,delay : useconds_t){
        DispatchQueue.global().async {
                for car in road {
                    car.move(direction)
                    usleep(delay)
                }
        }
    }
    
    private func checkAccident(){
        DispatchQueue.global().async {
            while true{
                DispatchQueue.main.async {
                    if (self.player.center == self.car1.body.center){
                        print("crash Boom!!")
                    }
                }
                usleep(Speed.VerySlow.rawValue)
            }
            
        }
    }
    
//    private func moveCarRight(car: UIView, y:Int, size : CGSize){
//        DispatchQueue.global().async {
//            var x = -80
//            while (true){
//                x = x + 1
//                DispatchQueue.main.async {
//                    car.frame = CGRect(origin: CGPoint(x: x,y: y), size: size)
//                    self.checkAccident(car: car)
//                }
//                usleep(8000)
//               
//            }
//        }
    }
