//
//  TestViewController.swift
//  OOTD_Team3
//
//  Created by Hyeonjeong Sim on 8/27/24.
//

import UIKit
import Lottie

class TestStartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 네비게이션 바 숨기기
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // 다른 화면으로 이동할 때 다시 네비게이션 바 보이기
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    private func setupUI() {
        let headlineLabel = createHeadlineLabel()
        let lottieView = createLottie()
        let bubbleImageView = createBubbleImageView()
        let startButton = createButton(title: "시작하기", action: #selector(startQuiz))
        let skipButton = createSkipButton() // Use custom method for skip button
        
        view.addSubview(headlineLabel)
        view.addSubview(bubbleImageView)
        view.addSubview(lottieView)
        view.addSubview(startButton)
        view.addSubview(skipButton)
        
        NSLayoutConstraint.activate([
            headlineLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            headlineLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            // 말풍선
            bubbleImageView.topAnchor.constraint(equalTo: headlineLabel.bottomAnchor, constant: 50),
            bubbleImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 80),
            bubbleImageView.widthAnchor.constraint(equalToConstant: 200),
            bubbleImageView.heightAnchor.constraint(equalToConstant: 200),
            
            // 로티
            lottieView.topAnchor.constraint(equalTo: headlineLabel.bottomAnchor, constant: 220),
            lottieView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lottieView.widthAnchor.constraint(equalToConstant: 200),
            lottieView.heightAnchor.constraint(equalToConstant: 200),
            
            // 버튼
            startButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -120),
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.widthAnchor.constraint(equalToConstant: 200),
            startButton.heightAnchor.constraint(equalToConstant: 50),
            
            skipButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -60),
            skipButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            skipButton.widthAnchor.constraint(equalToConstant: 200),
            skipButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func createHeadlineLabel() -> UILabel {
        let label = UILabel()
        label.text = "✦ 나만의 추구미 테스트 ✦"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    private func createLottie() -> LottieAnimationView {
        let animationView = LottieAnimationView(name: "cat")
        animationView.contentMode = .scaleAspectFit
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.loopMode = .loop
        animationView.play()
        return animationView
    }
    
    private func createBubbleImageView() -> UIImageView {
        let imageView = UIImageView(image: UIImage(named: "speechbubble"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }
    
    private func createButton(title: String, action: Selector) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.backgroundColor = .black
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
   
        let uiAction = UIAction(title: title) { _ in
            self.perform(action)
        }
        button.addAction(uiAction, for: .touchUpInside)
        
        return button
    }
    
    private func createSkipButton() -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle("건너뛰기", for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let uiAction = UIAction(title: "건너뛰기") { _ in
            self.skipToHome()
        }
        button.addAction(uiAction, for: .touchUpInside)
        
        return button
    }
    
    @objc private func startQuiz() {
        let questionViewController = TestViewController()
        // 네비게이션을 통해 다음 화면으로 전환
        navigationController?.pushViewController(questionViewController, animated: true)
    }

    @objc private func skipToHome() {
        let loginViewController = LoginViewController()
        // 네비게이션을 통해 다음 화면으로 전환
        navigationController?.pushViewController(loginViewController, animated: true)
    }
}

//#Preview {
//    TestStartViewController()
//}
