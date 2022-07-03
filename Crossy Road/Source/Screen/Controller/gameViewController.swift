//
//  Test2VC.swift
//  Crossy Road
//
//  Created by 장석우 on 2022/06/27.
//

import UIKit
import SnapKit
import AVFoundation

class GameViewController : UIViewController,GameOverDelegate {
  
    @IBOutlet weak var scoreLabel: UILabel!
    
    var audioPlayer = AVAudioPlayer()
    var backgroundAudioPlayer = AVAudioPlayer()
    
    lazy var player : UIImageView = {
        let view = UIImageView(frame: startRect)
        view.image = UIImage(named: "duck_back")
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
    var train = Train(image: "train", speed: Speed.VeryVeryFast).body
    
    let gameOverVC : GameOverViewController = {
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GameOverViewController") as! GameOverViewController
        vc.modalPresentationStyle = .overCurrentContext
        return vc
    }()
    
    let trees = Tree.trees
    var treePoints : [CGPoint]?
    let chicken = Chicken(axis: CGPoint(x: 200, y: 80)).body
    
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
        NotificationCenter.default.addObserver(self, selector: #selector(stopSound), name: NSNotification.Name(rawValue: "stop"), object: nil)
        gameOverVC.delegate = self
        playRoadSound()
        
        view.addSubview(player)
        view.addSubviews(map)
        view.addSubViews(trees)
        view.addSubview(train)
        view.addSubview(chicken)
        
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
        moveCar(map.roads[6], Direction.Right, delay: Second.sec(5))
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
                            self.playSound("break")
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
        var playerImage : UIImage
        
        switch(to){
        case .SwipeUp:
            rect = CGPoint(x: self.player.frame.minX, y: self.player.frame.minY - 40)
            playerImage = UIImage(named: Image.duck_back)!
        case .SwipeDown: rect = CGPoint(x: self.player.frame.minX, y: self.player.frame.minY + 40)
            playerImage = UIImage(named: Image.duck_back)!
        case .SwipeLeft: rect = CGPoint(x: self.player.frame.minX - 40, y: self.player.frame.minY)
            playerImage = UIImage(named: Image.duck_left)!
        case .SwipeRight: rect =  CGPoint(x: self.player.frame.minX + 40, y: self.player.frame.minY)
            playerImage = UIImage(named: Image.duck_right)!
            
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
        
        player.image = playerImage
        
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            usingSpringWithDamping: 0.5,
            initialSpringVelocity: 0.5,
            animations: {self.player.frame.origin = rect}
        )
        print(self.player.frame.origin.y)
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
                usleep(Second.sec(1))
                UIView.animate(
                    withDuration: 0.5,
                    animations: {
                        self.logoImageView.frame = CGRect(x: -200, y: 350,width: 200,height: 200)
                        self.skyBlueView.alpha = 0
                    }
                )
                
            }
        
        
    }
    
    private func playSound(_ soundName : String){
        let url = Bundle.main.url(forResource: soundName, withExtension: "mp3")
        audioPlayer = try! AVAudioPlayer(contentsOf: url!)
        audioPlayer.play()
    }
    
    private func playRoadSound(){
        let url = Bundle.main.url(forResource: "road", withExtension: "mp3")
        backgroundAudioPlayer = try! AVAudioPlayer(contentsOf: url!)
        backgroundAudioPlayer.play()
        backgroundAudioPlayer.numberOfLoops = .max
    }
    
    @objc func stopSound(_ notification : NSNotification){
        let stop = notification.object as? Bool ?? false
        if stop {
            backgroundAudioPlayer.stop()
        }else{
            backgroundAudioPlayer.play()
        }
        
    }
    
    
    //MARK: - IBAction
    @IBAction func tap(_ sender: Any) {
        print("tap")
        movePlayer(to: .SwipeUp)
        calculateScore()
        playSound("jump")
    }
    
    @IBAction func swipeUp(_ sender: Any) {
        movePlayer(to: .SwipeUp)
        calculateScore()
        playSound("jump")
    }
    
    @IBAction func swipeDown(_ sender: Any) {
        movePlayer(to: .SwipeDown)
        playSound("jump")
    }
    
    @IBAction func swipeLeft(_ sender: Any) {
        movePlayer(to: .SwipeLeft)
        playSound("jump")
    }
    
    @IBAction func swipeRight(_ sender: Any) {
        movePlayer(to: .SwipeRight)
        playSound("jump")
    }
    
    
    
}
