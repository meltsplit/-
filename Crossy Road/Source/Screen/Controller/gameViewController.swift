//
//  ViewController.swift
//  Crossy Road
//
//  Created by 장석우 on 2022/06/26.
//

import UIKit
import SnapKit

class gameViewController: UIViewController {
    
    @IBOutlet weak var line17: UIView!
    @IBOutlet weak var player: UIView!
    @IBOutlet weak var car1: UIView!
    
    let view1 : UIView = {
        let view = UIView(frame: CGRect(x: 200, y: 400, width: 30, height: 40))
        view.backgroundColor = .orange
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
    }
    
    func moveRight(){
        
        while(true){
            var x = 0
            x = x + 1
            
            
            
        }
    }


}

