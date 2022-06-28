//
//  Test2VC.swift
//  Crossy Road
//
//  Created by 장석우 on 2022/06/27.
//

import Foundation
import UIKit

class Test2VC : UIViewController , GameOverDelegate{
  
    @IBOutlet weak var scoreLabel: UILabel!
    
    let startRect = CGRect(x: 208, y: 800, width: 40, height: 40)
    
    var score = 0{
        didSet{
            scoreLabel.text = String(score)
        }
    }
    var howFar : CGFloat = 800
    
    let player = UIView()
    
    var wholeCar : [Vehicle]!
    
    var map = Map.map1
    
    let gameOverVC : GameOverViewController = {
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GameOverViewController") as! GameOverViewController
        vc.modalPresentationStyle = .overCurrentContext
        return vc
    }()
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        wholeCar = map.wholeCars()
        
        view.addSubview(player)
        view.addSubviews(map)
        
        
        gameOverVC.delegate = self
        
        player.frame = startRect
        player.backgroundColor = .red
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        moveCar(map.roads[0], Direction.Left,delay: Second.sec(4))
        moveCar(map.roads[1], Direction.Right,delay: Second.sec(4))
        moveCar(map.roads[2], Direction.Left,delay: Second.sec(6))
        moveCar(map.roads[3], Direction.Right,delay: Second.sec(3))
        moveCar(map.roads[4], Direction.Left,delay: Second.sec(5))
        moveCar(map.roads[5], Direction.Right,delay: Second.sec(10))
        checkAccident()
    }
    
    private func moveCar(_ road : Road,_ direction : Direction ,delay : useconds_t){
        DispatchQueue.global().async {
            while true {
                for car in road.vehicles {
                    switch(direction){
                    case Direction.Right : car.moveRight()
                    case Direction.Left  : car.moveLeft()
                    }
                usleep(delay)
                }
            }
        }
    }
    
    private func checkAccident() {
        var dead = false
        DispatchQueue.global().async {
            while (!dead){
                DispatchQueue.main.async {
                    for car in self.wholeCar{
                        if (self.player.center == car.body.center){
                            print("교통사고!")
                            dead = true
                            self.present(self.gameOverVC, animated: false)
                        }
                    }
                }
                usleep(Speed.VeryFast.rawValue)
            }
        }
    }
    
    private func calculateScore(){
        if ( self.player.frame.origin.y < self.howFar ){
            score += 1
        }
    }
    
    private func movePlayer(to : SwipeDir){
        
        var rect : CGPoint
        switch(to){
        case .SwipeUp: rect = CGPoint(x: self.player.frame.minX, y: self.player.frame.minY - 40)
        case .SwipeDown: rect = CGPoint(x: self.player.frame.minX, y: self.player.frame.minY + 40)
        case .SwipeLeft: rect = CGPoint(x: self.player.frame.minX - 40, y: self.player.frame.minY)
        case .SwipeRight: rect =  CGPoint(x: self.player.frame.minX + 40, y: self.player.frame.minY)
        }
        
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            usingSpringWithDamping: 0.5,
            initialSpringVelocity: 0.5,
            animations: {self.player.frame.origin = rect}
        )
    }
    
    func resetGame() {
        self.player.frame = self.startRect
        score = 0
        checkAccident()
    }
    
    //MARK: - IBAction
    @IBAction func tap(_ sender: Any) {
        movePlayer(to: .SwipeUp)
        calculateScore()
    }
    @IBAction func swipeUp(_ sender: Any) {
        movePlayer(to: .SwipeUp)
        calculateScore()
        
    }
    @IBAction func swipeDown(_ sender: Any) {
        movePlayer(to: .SwipeDown)
       
    }
    @IBAction func swipeLeft(_ sender: Any) {
        movePlayer(to: .SwipeLeft)
    }
    @IBAction func swipeRight(_ sender: Any) {
        movePlayer(to: .SwipeRight)
    }
    
    
    
}
