//
//  AppDescriptionViewController.swift
//  OOTD_Team3
//
//  Created by Hyeonjeong Sim on 8/27/24.
//

import UIKit
import Lottie

class AppDescriptionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 배경색 설정
        view.backgroundColor = .white
        self.navigationItem.hidesBackButton = true
        
        // 로티 애니메이션 설정
        let animationView = LottieAnimationView(name: "cat")
        animationView.contentMode = .scaleAspectFit
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.loopMode = .loop
        animationView.play()
        view.addSubview(animationView)
        
        // 텍스트 레이블 설정
        let headlineLabel = UILabel()
        headlineLabel.numberOfLines = 0
        headlineLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // 헤드라인 레이블 텍스트 설정
        let headlineText = "나만의 #OOTD 완성을 위한 \n상품을 추천해 드릴게요!"
        headlineLabel.attributedText = createAttributedString(text: headlineText, font: UIFont.boldSystemFont(ofSize: 24), lineSpacing: 8)
        view.addSubview(headlineLabel)

        // 설명 레이블 설정
        let descriptionLabel = UILabel()
        descriptionLabel.numberOfLines = 0
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // 설명 레이블 텍스트 설정
        let descriptionText = """
        #OOTD는 개인화된
        패션 콘텐츠를 제공합니다.

        1️⃣ 취향에 맞는 코디를 정확하게
        추천받을 수 있어요.

        2️⃣ 나와 취향이 비슷한 스타일의
        사람들을 쉽게 찾을 수 있어요.
        """
        descriptionLabel.attributedText = createAttributedString(text: descriptionText, font: UIFont.systemFont(ofSize: 18, weight: .regular), lineSpacing: 6)
        view.addSubview(descriptionLabel)

        // 정보 레이블 설정
        let infoLabel = UILabel()
        infoLabel.numberOfLines = 0
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // 정보 레이블 텍스트 설정
        let infoText = "계속하기 버튼을 누르시면 \n개인별 맞춤 서비스를 받으실 수 있습니다."
        infoLabel.attributedText = createAttributedString(text: infoText, font: UIFont.systemFont(ofSize: 16, weight: .regular), lineSpacing: 6)
        view.addSubview(infoLabel)

        // 계속하기 버튼 설정
        let continueButton = UIButton(type: .system)
        continueButton.setTitle("계속하기", for: .normal)
        continueButton.backgroundColor = .black
        continueButton.setTitleColor(.white, for: .normal)
        continueButton.layer.cornerRadius = 8
        continueButton.translatesAutoresizingMaskIntoConstraints = false

        // 버튼에 액션 추가
        let action = UIAction(title: "계속하기") { _ in
            self.continueButtonTapped()
        }
        continueButton.addAction(action, for: .touchUpInside)
        view.addSubview(continueButton)

        // 오토 레이아웃 설정
        NSLayoutConstraint.activate([
            // 로티 애니메이션 제약조건
            animationView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -5),
            animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            animationView.widthAnchor.constraint(equalToConstant: 200),
            animationView.heightAnchor.constraint(equalToConstant: 200),
            
            // 헤드라인 레이블 제약조건
            headlineLabel.topAnchor.constraint(equalTo: animationView.bottomAnchor, constant: 30),
            headlineLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            headlineLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            // 설명 레이블 제약조건
            descriptionLabel.topAnchor.constraint(equalTo: headlineLabel.bottomAnchor, constant: 35),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            // 정보 레이블 제약조건
            infoLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 50),
            infoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            infoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            // 계속하기 버튼 제약조건
            continueButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            continueButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            continueButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            continueButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    // Attributed String 생성 함수
    private func createAttributedString(text: String, font: UIFont, lineSpacing: CGFloat) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.alignment = .center
        
        return NSAttributedString(
            string: text,
            attributes: [
                .font: font,
                .paragraphStyle: paragraphStyle,
                .foregroundColor: UIColor.darkGray
            ]
        )
    }
    
    @objc private func continueButtonTapped() {
        // 버튼 클릭 시 다음 화면으로 전환 (UINavigationController 사용)
        let testViewController = TestStartViewController()
        navigationController?.pushViewController(testViewController, animated: true)
    }
}

//#Preview {
//    AppDescriptionViewController()
//}
