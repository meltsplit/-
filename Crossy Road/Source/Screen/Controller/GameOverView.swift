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
    
    var delegate : GameOverDelegate?
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK: - Custom Method
    @IBAction func settingBtnPressed(_ sender: UIButton) {
    }
    
    @IBAction func regameBtnPressed(_ sender: UIButton) {
        dismiss(animated: true)
        delegate?.resetGame()
    }
}
