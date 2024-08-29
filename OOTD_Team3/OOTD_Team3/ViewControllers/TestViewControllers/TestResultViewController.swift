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
        navigationItem.hidesBackButton = true
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
        let descriptionText = """
            클래식하면서도 고급스러움을
            자아내는 프레피룩과 어울립니다.
            
            화려하게 눈에 띄는 스타일보다는,
            단정한 매력으로 사람들에게 근사한
            인상을 남길 수 있는 패션입니다.
            
            대표적인 브랜드로는\n#랄프로렌, #타미힐피거, #메종키츠네 입니다.
            """
            
        // NSMutableAttributedString으로 텍스트 생성
        let attributedText = NSMutableAttributedString(string: descriptionText)

        // 기본 스타일 설정 (일반 텍스트에 대한 행간 조절)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 8 // 행간을 8 포인트로 설정
        let normalTextRange = (descriptionText as NSString).range(of: "클래식하면서도 고급스러움을\n자아내는 프레피룩과 어울립니다.\n\n화려하게 눈에 띄는 스타일보다는,\n단정한 매력으로 사람들에게 근사한\n인상을 남길 수 있는 패션입니다.\n\n대표적인 브랜드로는\n")
        attributedText.addAttributes([
            .font: UIFont.systemFont(ofSize: 15, weight: .regular), // 일반 글씨체
            .foregroundColor: UIColor.darkGray, // 기존 색상
            .paragraphStyle: paragraphStyle // 행간 스타일 추가
        ], range: normalTextRange)

        // 특정 텍스트 범위를 설정하여 밑줄과 진한색으로 설정
        let emphasizedRange = (descriptionText as NSString).range(of: "#랄프로렌, #타미힐피거, #메종키츠네 입니다.")
        attributedText.addAttributes([
            .font: UIFont.boldSystemFont(ofSize: 15), // 진한 글씨체
            .foregroundColor: UIColor.black, // 진한 글씨색
            .underlineStyle: NSUnderlineStyle.single.rawValue // 밑줄
        ], range: emphasizedRange)

        // 레이블의 속성 텍스트 설정
        descriptionLabel.attributedText = attributedText
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
            testResultImageView.heightAnchor.constraint(equalTo: testResultImageView.widthAnchor, multiplier: 0.8),
            
            // 설명 레이블 제약조건
            descriptionLabel.topAnchor.constraint(equalTo: testResultImageView.bottomAnchor, constant: 60),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            // 스택 뷰 제약조건
            actionStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            actionStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            actionStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            actionStackView.heightAnchor.constraint(equalToConstant: 50)
        ])
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
    
    // 버튼 클릭 시 테스트 처음 화면으로
    private func restartButtonTapped() {
        let testViewController = TestStartViewController()
        // 네비게이션을 통해 처음 화면으로 전환
        navigationController?.pushViewController(testViewController, animated: true)
    }
    
    // 버튼 클릭 시 OOTD 시작 화면으로 전환
    private func appStartButtonTapped() {
        let userDetailsViewController = UserDetailsViewController()
        // 네비게이션을 통해 추가 정보 입력 화면으로 전환
        navigationController?.pushViewController(userDetailsViewController, animated: true)
    }
}

//#Preview {
//    TestResultViewController()
//}
