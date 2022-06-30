//
//  Test2VC.swift
//  Crossy Road
//
//  Created by 장석우 on 2022/06/27.
//

import UIKit
import SnapKit

class GameViewController : UIViewController,GameOverDelegate {
  
    @IBOutlet weak var scoreLabel: UILabel!
    
    lazy var player : UIView = {
        let view = UIView(frame: startRect)
        view.backgroundColor = .red
        return view
    }()
    
    let startRect = CGRect(x: 200, y: 800, width: 40, height: 40)
    var stop = false
    var score = 0{
        didSet{
            scoreLabel.text = String(score)
        }
    }
    var howFar : CGFloat = 800
    
    var map = Map.map1
    
    let gameOverVC : GameOverViewController = {
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GameOverViewController") as! GameOverViewController
        vc.modalPresentationStyle = .overCurrentContext
        return vc
    }()
    
    let trees = Tree.trees
    var treePoints : [CGPoint]?
    
    var logoImageView : UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: -200, y: 350, width: 200, height: 200))
        imageView.image = UIImage(named: "crossroad")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    var skyBlueView : UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 414, height: 1000))
        view.backgroundColor = UIColor(named: "skyblueColor")
        view.alpha = 0
        return view
    }()
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setting()
        gameStart()
    }
    
    private func setting(){
        gameOverVC.delegate = self
        
        view.addSubview(player)
        view.addSubviews(map)
        view.addSubViews(trees)
        
        view.addSubview(skyBlueView)
        view.addSubview(logoImageView)
        
    }
    
    private func gameStart(){
        
        moveCar(map.roads[0], Direction.Left,delay: Second.sec(4))
        moveCar(map.roads[1], Direction.Right,delay: Second.sec(4))
        moveCar(map.roads[2], Direction.Left,delay: Second.sec(6))
        moveCar(map.roads[3], Direction.Right,delay: Second.sec(3))
        moveCar(map.roads[4], Direction.Left,delay: Second.sec(5))
        moveCar(map.roads[5], Direction.Right,delay: Second.sec(2))
        checkAccident()
    }
    
    private func moveCar(_ road : Road,_ direction : Direction ,delay : UInt32){
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
                    for car in self.map.wholeCar{
                        if (self.player.center == car.body.center){
                            print("교통사고!")
                            dead = true
                            self.gameOverVC.score = self.score
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
            howFar = self.player.layer.frame.origin.y
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
        
        
        let allowXPoint = 0 <= rect.x && rect.x <= 360
        let allowYPoint = 80 <= rect.y && rect.y <= 800
        let checkTree : Bool = {
            var bool = true
            for t in trees{
                if rect == t.axis{
                    bool = false
                }
            }
            return bool
        }()
            
        
        if (!allowXPoint || !allowYPoint || !checkTree){
            rect = CGPoint(x: self.player.frame.minX, y: self.player.frame.minY)
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
        
        loadingView()
        self.player.frame = self.startRect
        score = 0
        howFar = 800
        checkAccident()
    }
    
    private func loadingView(){
        
        
        UIView.animate(
            withDuration: 0.6,
            animations: {
                self.logoImageView.center = self.view.center
                self.skyBlueView.alpha = 1
            }) { finished in
                usleep(1000000)
                UIView.animate(
                    withDuration: 0.5,
                    animations: {
                        self.logoImageView.frame = CGRect(x: -200, y: 350,width: 200,height: 200)
                        self.skyBlueView.alpha = 0
                    }
                )
                
            }
        
//        self.logoImageView.snp.remakeConstraints {
//            $0.trailing.equalTo(self.view.snp.leading)
//          $0.size.equalTo(240)
//        }
//
//        self.skyBlueView.snp.remakeConstraints {
//            $0.width.equalTo(414)
//            $0.height.equalTo(1000)
//            $0.center.equalToSuperview().inset(414)
//        }
//        UIView.animate(
//            withDuration: 0.5,
//            animations: self.view.layoutIfNeeded
//        )
        
        
    }
    
    
    //MARK: - IBAction
    @IBAction func tap(_ sender: Any) {
        print("tap")
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
