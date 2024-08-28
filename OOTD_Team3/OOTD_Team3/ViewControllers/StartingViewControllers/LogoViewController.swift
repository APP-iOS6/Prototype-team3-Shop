//
//  LogoViewController.swift
//  OOTD_Team3
//
//  Created by Hyeonjeong Sim on 8/27/24.
//

import UIKit

class LogoViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 배경색 설정
        view.backgroundColor = .white
        
        // UIImageView를 생성하여 로고 이미지를 설정
        let logoImageView = UIImageView(image: UIImage(named: "White"))
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        // UIImageView를 현재 View에 추가
        view.addSubview(logoImageView)
        
        // 오토 레이아웃 제약조건을 설정하여 중앙에 위치하도록 합니다.
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 200),
            logoImageView.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        // 로고 화면을 2초 동안 표시
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.transitionToAppDescriptionScreen()
        }
    }
    
    private func transitionToAppDescriptionScreen() {
        // 앱 설명 화면으로 전환
        if let window = UIApplication.shared.windows.first {
            let appDescriptionViewController = AppDescriptionViewController()
            appDescriptionViewController.modalPresentationStyle = .fullScreen
            
            window.rootViewController = appDescriptionViewController
            UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: {
                window.rootViewController = appDescriptionViewController
            }, completion: nil)
        }
    }
}
