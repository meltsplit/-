//
//  Car.swift
//  Crossy Road
//
//  Created by 장석우 on 2022/06/27.
//

import UIKit

protocol movable{
    func moveRight()
    func moveLeft()
}

class Vehicle : movable {
   
    var stop: Bool = false
    let operationq = OperationQueue()
    var body = UIImageView()
    let image : String
    let speed : Speed
    var width : CGFloat?
    
    init(image : String,speed : Speed){
        self.speed = speed
        self.image = image
        
        self.body.frame.origin.x = -11111
        self.body.image = UIImage(named: image)
        
        NotificationCenter.default.addObserver(self, selector: #selector(toggleStop), name: NSNotification.Name(rawValue: "stop"), object: nil)
    }
    
    func moveRight() {
        var x : CGFloat = -self.width!
        operationq.addOperation {
            while (x < 414){
                if (!self.stop){
                    
                
                    x =  x + 1
                OperationQueue.main.addOperation {
                        self.body.frame = CGRect(origin: CGPoint(x: x,y: self.body.frame.origin.y), size: self.body.frame.size)
                    }
                    usleep(self.speed.rawValue)
                }
                
            }
            
        }
    }
    
    func moveLeft() {
        var x : CGFloat = 414
        operationq.addOperation {
            while (x > -self.width!){
                if (!self.stop){
                    x = x - 1
                    OperationQueue.main.addOperation {
                        self.body.frame = CGRect(origin: CGPoint(x: x,y: self.body.frame.origin.y), size: self.body.frame.size)
                    }
                    usleep(self.speed.rawValue)
                }
               
            }
        }
    }
    @objc func toggleStop(_ notification : NSNotification){
        stop = notification.object as? Bool ?? false
        operationq.cancelAllOperations()
    }
    
}

class Car : Vehicle{
    override init(image: String, speed: Speed) {
        super.init(image: image, speed: speed)
        body.frame.size = CGSize(width: 80, height: 40)
        width = body.frame.size.width
    }
}

class Bus : Vehicle{
    override init(image: String, speed: Speed) {
        super.init(image: image, speed: speed)
        body.frame.size = CGSize(width: 80, height: 40)
        width = body.frame.size.width
    }
}

class Train : Vehicle{
    override init(image: String, speed: Speed) {
        super.init(image: image, speed: speed)
        body.frame.size = CGSize(width: 306, height: 40)
        body.image = UIImage(named: Image.train)
        width = body.frame.size.width
    }
}

extension Vehicle{
    static var vehicles1 = [
        Car(image: Image.car3_left, speed: Speed.Fast),
        Car(image: Image.car2_left, speed: Speed.Slow),
        Bus(image: Image.bus_left, speed: Speed.Fast),
        Car(image: Image.car3_left, speed: Speed.Normal),
        Car(image: Image.car1_left, speed: Speed.Fast)
    ]
    static var vehicles2 = [
        Car(image: Image.car2, speed: Speed.VeryFast),
        Bus(image: Image.bus, speed: Speed.Fast),
        Car(image: Image.car2, speed: Speed.VeryFast),
        Car(image: Image.car3, speed: Speed.Fast),
        Car(image: Image.car2, speed: Speed.VeryFast)
    ]
    static var vehicles3 = [
        Car(image: Image.car2_left, speed: Speed.Fast),
        Car(image: Image.car2_left, speed: Speed.Slow),
        Bus(image: Image.bus_left, speed: Speed.Fast),
        Car(image: Image.car2_left, speed: Speed.Normal),
        Car(image: Image.car3_left, speed: Speed.Fast)
    ]
    static var vehicles4 = [
        Car(image: Image.car1, speed: Speed.Fast),
        Bus(image: Image.car1, speed: Speed.Fast),
        Car(image: Image.car3, speed: Speed.VeryFast),
        Car(image: Image.car2, speed: Speed.Slow),
        Car(image: Image.car1, speed: Speed.VeryFast)
    ]
    static var vehicles5 = [
        Car(image: Image.car2_left, speed: Speed.Fast),
        Car(image: Image.car2_left, speed: Speed.Slow),
        Bus(image: Image.bus_left, speed: Speed.Fast),
        Car(image: Image.car2_left, speed: Speed.Normal),
        Car(image: Image.car3_left, speed: Speed.Fast)
    ]
    static var vehicles6 = [
        Car(image: Image.car3, speed: Speed.Fast),
        Bus(image: Image.car1, speed: Speed.Fast),
        Car(image: Image.car3, speed: Speed.VeryFast),
        Car(image: Image.car2, speed: Speed.Fast),
        Car(image: Image.car1, speed: Speed.VeryFast)
    ]
    
    
    
    
    
//    static var vehicles5 = [
//        Car(color: UIColor.purple, speed: Speed.Fast),
//        Bus(color: UIColor.systemPink, speed: Speed.Fast),
//        Car(color: UIColor.cyan, speed: Speed.VeryFast),
//        Car(color: UIColor.brown, speed: Speed.Slow),
//        Car(color: UIColor.red, speed: Speed.VeryFast)
//    ]
//    static var vehicles6 = [
//        Car(color: UIColor.red, speed: Speed.Fast),
//        Car(color: UIColor.orange, speed: Speed.Slow),
//        Bus(color: UIColor.yellow, speed: Speed.Fast),
//        Car(color: UIColor.green, speed: Speed.Normal),
//        Car(color: UIColor.blue, speed: Speed.Fast)
//    ]

}
