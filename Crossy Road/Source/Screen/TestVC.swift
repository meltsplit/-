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
    lazy var cars = [car1,car2]
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(car2)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.global().async {
            for car in self.cars {
                self.moveCarRight(car: car!, y: 200, size: CGSize(width: 80, height: 40), nextCarStartPointX: 200)
                usleep(3000000)
            }
           
        }
    }
        
    
    
    private func moveCarRight(car: UIView, y:Int, size : CGSize, nextCarStartPointX : CGFloat){
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
