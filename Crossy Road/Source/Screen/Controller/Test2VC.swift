//
//  Test2VC.swift
//  Crossy Road
//
//  Created by 장석우 on 2022/06/27.
//

import Foundation
import UIKit

class Test2VC : UIViewController{
  
    let player = UIView(frame: CGRect(x: 212, y: 200, width: 40, height: 40))
    
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
        
     
        
        road1 = [car1,car2]
        road2 = [car3,bus1]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        view.addSubview(player)
        view.addSubview(car1.body)
        view.addSubview(car2.body)
        view.addSubview(car3.body)
        view.addSubview(bus1.body)
        view.willRemoveSubview(car1.body)
        view.willRemoveSubview(car2.body)
        view.willRemoveSubview(car3.body)
        view.willRemoveSubview(bus1.body)
        moveCar(road1!, Direction.Left,delay: Second.sec(4))
        moveCar(road2!, Direction.Right,delay: Second.sec(4))
        checkAccident()
    }
    
    private func moveCar(_ road : [Vehicle],_ direction : Direction ,delay : useconds_t){
        DispatchQueue.global().async {
            while(true){
                for car in road {
                    switch(direction){
                    case Direction.Right : car.moveRight()
                    case Direction.Left  : car.moveLeft()
                    }
                usleep(delay)
                }
            }
        }
    }
    
    private func checkAccident(){
        DispatchQueue.global().async {
            while true{
                DispatchQueue.main.async {
                    for car in self.road1!{
                        if (self.player.center == car.body.center){
                            print("교통사고!")
                        }
                    }
                    for car in self.road2!{
                        if (self.player.center == car.body.center){
                            print("교통사고!")
                        }
                    }
                }
                usleep(Speed.VeryFast.rawValue)
            }
            
        }
    }
    
    //MARK: - IBAction
    @IBAction func tap(_ sender: Any) {
        
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            usingSpringWithDamping: 0.5,
            initialSpringVelocity: 0.5,
          animations: {self.player.frame = CGRect(x: self.player.frame.minX, y: self.player.frame.minY - 40, width: 40, height: 40)}
        )
    }
    @IBAction func swipeUp(_ sender: Any) {
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            usingSpringWithDamping: 0.5,
            initialSpringVelocity: 0.5,
          animations: {self.player.frame = CGRect(x: self.player.frame.minX, y: self.player.frame.minY - 40, width: 40, height: 40)}
        )
        
    }
    @IBAction func swipeDown(_ sender: Any) {
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            usingSpringWithDamping: 0.5,
            initialSpringVelocity: 0.5,
          animations: {self.player.frame = CGRect(x: self.player.frame.minX, y: self.player.frame.minY + 40, width: 40, height: 40)}
        )
       
    }
    @IBAction func swipeLeft(_ sender: Any) {
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            usingSpringWithDamping: 0.5,
            initialSpringVelocity: 0.5,
          animations: {self.player.frame = CGRect(x: self.player.frame.minX - 40, y: self.player.frame.minY, width: 40, height: 40)}
        )
    }
    @IBAction func swipeRight(_ sender: Any) {
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            usingSpringWithDamping: 0.5,
            initialSpringVelocity: 0.5,
          animations: {self.player.frame = CGRect(x: self.player.frame.minX + 40, y: self.player.frame.minY, width: 40, height: 40)}
        )
    }
    
    
}
