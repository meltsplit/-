//
//  TestVC.swift
//  Crossy Road
//
//  Created by 장석우 on 2022/06/27.
//

import Foundation
import UIKit

class TestVC :UIViewController{
    
    @IBOutlet weak var player: UIView!
    @IBOutlet weak var car1: UIView!
    
    @IBOutlet weak var carss: UIView!
    let car2: UIView = {
        let view = UIView(frame: CGRect(x: -79, y: 200, width: 80, height: 40))
        view.backgroundColor = .orange
        return view
    }()
    let car3: UIView = {
        let view = UIView(frame: CGRect(x: -79, y: 400, width: 80, height: 40))
        view.backgroundColor = .green
        return view
    }()
    let car4: UIView = {
        let view = UIView(frame: CGRect(x: -79, y: 400, width: 80, height: 40))
        view.backgroundColor = .blue
        return view
    }()
    var cars : [UIView]?
    var cars2 : [UIView]?
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cars = [car1,car2]
        cars2 = [car3,car4]
        
        view.addSubview(car2)
        view.addSubview(car3)
        view.addSubview(car4)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        moveCar(cars!,delay: 3000000,yAxis: 200)
        moveCar(cars2!,delay: 2000000,yAxis: 400)
    }
        
    private func moveCar(_ carList : [UIView], delay : useconds_t, yAxis : Int ){
        DispatchQueue.global().async {
            for car in carList {
                self.moveCarRight(car: car, y: yAxis, size: CGSize(width: 80, height: 40))
                usleep(delay)
            }
        }
    }
    
    private func moveCarRight(car: UIView, y:Int, size : CGSize){
        DispatchQueue.global().async {
            var x = -80
            while (true){
                x = x + 1
                DispatchQueue.main.async {
                    car.frame = CGRect(origin: CGPoint(x: x,y: y), size: size)
                    self.checkAccident(car: car)
                }
                usleep(8000)
               
            }
        }
    }
    
    private func checkAccident(car: UIView){
        if car.center == player.center {
            print("충돌!!!!!!!!!")
        }
    }
    
    //MARK: - IBAction
    
    @IBAction func swipeUp(_ sender: Any) {
        print("Up")
        player.frame = CGRect(x: player.frame.minX, y: player.frame.minY - 40, width: 40, height: 40)
    }
    
    @IBAction func swipeDown(_ sender: Any) {
        print("Down")
        player.frame = CGRect(x: player.frame.minX, y: player.frame.minY + 40, width: 40, height: 40)
    }
    
    @IBAction func swipeRight(_ sender: Any) {
        print("Right")
        player.frame = CGRect(x: player.frame.minX + 40, y: player.frame.minY , width: 40, height: 40)
    }
    
    @IBAction func swipeLeft(_ sender: Any) {
        print("Left")
        player.frame = CGRect(x: player.frame.minX - 40, y: player.frame.minY , width: 40, height: 40)
    }
    
}
