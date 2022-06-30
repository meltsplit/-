//
//  GameOverView.swift
//  Crossy Road
//
//  Created by 장석우 on 2022/06/29.
//

import Foundation
import UIKit
protocol GameOverDelegate{
    func resetGame()
}
class GameOverViewController : UIViewController{
    
    //MARK: - Properties
    @IBOutlet weak var currentScoreLabel: UILabel!
    @IBOutlet weak var highestScoreLabel: UILabel!
    
    var delegate : GameOverDelegate?
    var score = 0
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        var highestScore = UserDefaults.standard.integer(forKey: "highestScore")
        if ( score > highestScore )
        {
            highestScore = score
            UserDefaults.standard.set(score, forKey: "highestScore")
            
        }
        currentScoreLabel.text = "현재 점수 : \(score)"
        highestScoreLabel.text = "최고 기록 : \(highestScore)"
    }
    
    //MARK: - Custom Method
    @IBAction func settingBtnPressed(_ sender: UIButton) {
        
    }
    
    @IBAction func regameBtnPressed(_ sender: UIButton) {
        dismiss(animated: true)
        delegate?.resetGame()
    }
}
