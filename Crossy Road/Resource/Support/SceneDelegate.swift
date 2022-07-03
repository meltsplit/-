//
//  SceneDelegate.swift
//  Crossy Road
//
//  Created by 장석우 on 2022/06/26.
//

import UIKit
import SnapKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    let operationQueue = OperationQueue()
    lazy var pauseView : UIView = {
        let view = UIView(frame: window!.frame)
        view.backgroundColor = .cyan
        view.alpha = 0.5
        return view
    }()
    
    lazy var imageView = makeImageView()
    var background = false
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        print("Active") //다시 forground로 돌아왔을 때
        if(background){
            self.setUI()
            self.countDown()
        }
       
        
    }

    func sceneWillResignActive(_ scene: UIScene) {
        print("Resign") // 앱을 종료하려 할 때\
        background = true
        self.setUI()
        imageView.image = UIImage(named: "pause")
        
        // 차를 다시 멈추는 신호
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "stop"), object: true)

    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }
    
    private func setUI(){
        window?.addSubview(pauseView)
        window?.addSubview(imageView)
        imageView.image = UIImage(named: "3")
        imageView.centerXAnchor.constraint(equalTo: window!.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: window!.centerYAnchor).isActive = true
       
    }
    
    private func countDown(){
        operationQueue.addOperation {
            for i in (1..<4).reversed(){ // 3 -> 2 -> 1
                    DispatchQueue.main.async {
                        self.imageView.image = UIImage(named: String(i)) // 시간 대에 맞게 화면에 숫자 이미지 띄움
                    }
                usleep(Second.sec(1)) //for문이 1초당 한번씩 반복하게 설정. Second.sec(1)은 1초를 의미함.
                
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
                self.imageView.removeFromSuperview()
                self.pauseView.removeFromSuperview()
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "stop"), object: false)
                print("asynafter")
            })
        }
        print("count end")
    }
    
    private func makeImageView() -> UIImageView{
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.frame.size = CGSize(width: 20, height: 20)
        imageView.snp.makeConstraints {
            $0.width.height.equalTo(80)
        }
        
        return imageView
    }


}


