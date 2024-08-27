//
//  TestResultViewController.swift
//  OOTD_Team3
//
//  Created by Hyeonjeong Sim on 8/27/24.
//

import UIKit
import Lottie

class TestResultViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 배경색 설정
        view.backgroundColor = .white
        
        // 텍스트 레이블 설정
        let headlineLabel = UILabel()
        headlineLabel.text = "♣️ 클래식한 프래피룩 미니멀 한 스쿱 ♣️"
        headlineLabel.font = UIFont.boldSystemFont(ofSize: 20)
        headlineLabel.textAlignment = .center
        headlineLabel.numberOfLines = 0
        headlineLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(headlineLabel)
        
        //테스트 결과 스타일 이미지 뷰 설정
        let testResultImageView = UIImageView(image: UIImage(named: "preppylook"))
        testResultImageView.contentMode = .scaleAspectFit
        testResultImageView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(testResultImageView)
        
        // 설명 레이블 설정
        let descriptionLabel = UILabel()
        descriptionLabel.text = """
            클래식하면서도 고급스러움을
            자아내는 프레피룩과 어울립니다.
            
            화려하게 눈에 띄는 스타일보다는,
            단정한 매력으로 사람들에게 근사한
            인상을 남길 수 있는 패션입니다.
            
            대표적인 브랜드로는
            
            #랄프로렌, #타미힐피거, #메종키츠네 입니다.
            """
        descriptionLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular) // 진한 회색글씨, 첫번째 레이블보다 큼
        descriptionLabel.textColor = .darkGray
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 0
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(descriptionLabel)
        

 
        // 취향 재설정 버튼 설정(테스트 다시시작)
        let restartButton = UIButton(type: .system)
        restartButton.setTitle("취향 재설정", for: .normal)
        restartButton.backgroundColor = .clear
        restartButton.setTitleColor(.black, for: .normal)
        restartButton.layer.cornerRadius = 8
        restartButton.layer.borderWidth = 1
        restartButton.translatesAutoresizingMaskIntoConstraints = false
        restartButton.addAction(UIAction(title: "취향 재설정") { _ in
            self.restartButtonTapped()
        }, for: .touchUpInside)
        
        // OOTD 시작 버튼 설정
        let appStartButton = UIButton(type: .system)
        appStartButton.setTitle("추가정보 입력하기", for: .normal)
        appStartButton.backgroundColor = .black
        appStartButton.setTitleColor(.white, for: .normal)
        appStartButton.layer.cornerRadius = 8
        appStartButton.translatesAutoresizingMaskIntoConstraints = false
        appStartButton.addAction(UIAction(title: "추가정보 입력하기") { _ in
            self.appStartButtonTapped()
        }, for: .touchUpInside)
        
        // 버튼들을 담을 UIStackView 설정
        let actionStackView = UIStackView(arrangedSubviews: [restartButton, appStartButton])
        actionStackView.axis = .horizontal
        actionStackView.spacing = 10
        actionStackView.distribution = .fillEqually
        actionStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(actionStackView)
        
        // 오토 레이아웃 설정
        NSLayoutConstraint.activate([
            // 헤드라인 레이블 제약조건
            headlineLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            headlineLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            headlineLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            // 이미지 뷰 제약조건
            testResultImageView.topAnchor.constraint(equalTo: headlineLabel.bottomAnchor, constant: 20),
            testResultImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            testResultImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            testResultImageView.heightAnchor.constraint(equalTo: testResultImageView.widthAnchor),
            
            // 설명 레이블 제약조건
            descriptionLabel.topAnchor.constraint(equalTo: testResultImageView.bottomAnchor, constant: 50),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            // 스택 뷰 제약조건
            actionStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            actionStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            actionStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            actionStackView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    // 버튼 클릭 시 테스트 처음 화면으로
    private func restartButtonTapped() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            let testViewController = TestStartViewController()
            
            window.rootViewController = testViewController
            UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: {
                window.rootViewController = testViewController
            }, completion: nil)
        }
    }
    
    // 버튼 클릭 시 OOTD 시작 화면으로 전환
    // 앱 홈화면으로 재설정 필요~!!
    private func appStartButtonTapped() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            let userDetailsViewController = UserDetailsViewController()
            
            window.rootViewController = userDetailsViewController
            UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: {
                window.rootViewController = userDetailsViewController
            }, completion: nil)
        }
    }
}

