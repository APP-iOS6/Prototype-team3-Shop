//
//  UserDetailsViewController.swift
//  OOTD_Team3
//
//  Created by Hyeonjeong Sim on 8/27/24.
//

import UIKit

class UserDetailsViewController: UIViewController {
    
    // 상단 제목 레이블
    private let titleLabel = UILabel()
    
    // 입력 텍스트 필드 및 라벨
    private let ageLabel = UILabel()
    private let ageTextField = UITextField()
    
    private let heightLabel = UILabel()
    private let heightTextField = UITextField()
    
    private let weightLabel = UILabel()
    private let weightTextField = UITextField()
    
    // 체형 정보 레이블 및 아이콘
    private let bodyTypeInfoLabel = UILabel()
    private let bodyTypeInfoButton = UIButton(type: .infoLight) // "i" 버튼 추가
    
    // 체형 선택 세그먼트 컨트롤
    private let bodyTypeSegmentedControl = UISegmentedControl(items: ["스트레이트", "웨이브", "내추럴", "모르겠어요"])
    
    // 성별 선택 세그먼트 컨트롤
    private let genderSegmentedControl = UISegmentedControl(items: ["🚹남성", "🚺여성", "기타", "선택하지 않음"])
    
    // 개인정보 사용 동의 레이블
    private let infoLabel = UILabel()
    
    // 버튼
    private let signUpButton = UIButton(type: .system)
    private let skipButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 배경색 설정
        view.backgroundColor = .white
        
        // 제목 레이블 설정
        titleLabel.text = "정확한 취향 분석과\n스타일을 추천해드릴게요"
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        // 나이 라벨 및 텍스트 필드 설정
        ageLabel.text = "나이"
        ageLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        ageLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(ageLabel)
        
        ageTextField.placeholder = "세"
        ageTextField.borderStyle = .roundedRect
        ageTextField.keyboardType = .numberPad
        ageTextField.textAlignment = .right
        ageTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(ageTextField)
        
        // 키 라벨 및 텍스트 필드 설정
        heightLabel.text = "키"
        heightLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        heightLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(heightLabel)
        
        heightTextField.placeholder = "cm"
        heightTextField.borderStyle = .roundedRect
        heightTextField.keyboardType = .numberPad
        heightTextField.textAlignment = .right
        heightTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(heightTextField)
        
        // 몸무게 라벨 및 텍스트 필드 설정
        weightLabel.text = "몸무게"
        weightLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        weightLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(weightLabel)
        
        weightTextField.placeholder = "kg"
        weightTextField.borderStyle = .roundedRect
        weightTextField.keyboardType = .numberPad
        weightTextField.textAlignment = .right
        weightTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(weightTextField)
        
        // 체형 정보 레이블 및 아이콘 설정
        bodyTypeInfoLabel.text = "체형이란 무엇인가요?"
        bodyTypeInfoLabel.font = UIFont.systemFont(ofSize: 14, weight: .light)
        bodyTypeInfoLabel.textColor = .gray
        bodyTypeInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bodyTypeInfoLabel)
        
        bodyTypeInfoButton.translatesAutoresizingMaskIntoConstraints = false
        bodyTypeInfoButton.addTarget(self, action: #selector(showBodyTypeInfo), for: .touchUpInside)
        view.addSubview(bodyTypeInfoButton)
        
        // 체형 선택 세그먼트 컨트롤 설정
        bodyTypeSegmentedControl.selectedSegmentIndex = 0
        bodyTypeSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bodyTypeSegmentedControl)
        
        
        // 성별 선택 세그먼트 컨트롤 설정
        genderSegmentedControl.selectedSegmentIndex = 0
        genderSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(genderSegmentedControl)
        
        // 개인정보 사용 동의 레이블 설정
        infoLabel.text = "입력하신 내용은\n맞춤 서비스 제공 및 마케팅 정보에 활용됩니다."
        infoLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        infoLabel.textAlignment = .center
        infoLabel.numberOfLines = 0
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(infoLabel)
        
        // 가입하기 버튼 설정
        signUpButton.setTitle("#OOTD 시작하기", for: .normal)
        signUpButton.backgroundColor = .black
        signUpButton.setTitleColor(.white, for: .normal)
        signUpButton.layer.cornerRadius = 8
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.addAction(UIAction { [weak self] _ in
            self?.signUpButtonTapped()
        }, for: .touchUpInside)
        view.addSubview(signUpButton)
        
        // 건너뛰기 버튼 설정
        skipButton.setTitle("건너뛰기", for: .normal)
        skipButton.setTitleColor(.black, for: .normal)
        skipButton.backgroundColor = .clear
        skipButton.layer.cornerRadius = 8
        skipButton.layer.borderWidth = 1
        skipButton.translatesAutoresizingMaskIntoConstraints = false
        skipButton.addAction(UIAction { [weak self] _ in
            self?.signUpButtonTapped()
        }, for: .touchUpInside)
        view.addSubview(skipButton)
        
        // 오토 레이아웃 설정
        NSLayoutConstraint.activate([
            // 제목 레이블 제약조건
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            // 나이 라벨 제약조건
            ageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            ageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            // 나이 입력 텍스트 필드 제약조건
            ageTextField.topAnchor.constraint(equalTo: ageLabel.bottomAnchor, constant: 5),
            ageTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            ageTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            ageTextField.heightAnchor.constraint(equalToConstant: 40),
            
            // 키 라벨 제약조건
            heightLabel.topAnchor.constraint(equalTo: ageTextField.bottomAnchor, constant: 30),
            heightLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            // 키 입력 텍스트 필드 제약조건
            heightTextField.topAnchor.constraint(equalTo: heightLabel.bottomAnchor, constant: 5),
            heightTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            heightTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            heightTextField.heightAnchor.constraint(equalToConstant: 40),
            
            // 몸무게 라벨 제약조건
            weightLabel.topAnchor.constraint(equalTo: heightTextField.bottomAnchor, constant: 30),
            weightLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            // 몸무게 입력 텍스트 필드 제약조건
            weightTextField.topAnchor.constraint(equalTo: weightLabel.bottomAnchor, constant: 5),
            weightTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            weightTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            weightTextField.heightAnchor.constraint(equalToConstant: 40),
            
            // 체형 정보 레이블 및 아이콘 제약조건
            bodyTypeInfoLabel.topAnchor.constraint(equalTo: weightTextField.bottomAnchor, constant: 30),
            bodyTypeInfoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            bodyTypeInfoButton.centerYAnchor.constraint(equalTo: bodyTypeInfoLabel.centerYAnchor),
            bodyTypeInfoButton.leadingAnchor.constraint(equalTo: bodyTypeInfoLabel.trailingAnchor, constant: 5),
            
            // 체형 선택 세그먼트 컨트롤 제약조건
            bodyTypeSegmentedControl.topAnchor.constraint(equalTo: bodyTypeInfoLabel.bottomAnchor, constant: 19),
            bodyTypeSegmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            bodyTypeSegmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            
            // 성별 선택 세그먼트 컨트롤 제약조건
            genderSegmentedControl.topAnchor.constraint(equalTo: bodyTypeSegmentedControl.bottomAnchor, constant: 30), // 수정된 부분
            genderSegmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            genderSegmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            // 개인정보 사용 동의 레이블 제약조건
            infoLabel.topAnchor.constraint(equalTo: genderSegmentedControl.bottomAnchor, constant: 70),
            infoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            infoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            // 가입하기 버튼 제약조건
            signUpButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -70),
            signUpButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            signUpButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            signUpButton.heightAnchor.constraint(equalToConstant: 50),
            
            // 건너뛰기 버튼 제약조건
            skipButton.bottomAnchor.constraint(equalTo: signUpButton.bottomAnchor, constant: 70),
            skipButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            skipButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            skipButton.heightAnchor.constraint(equalToConstant: 50),
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
    
    @objc private func showBodyTypeInfo() {
        let infoViewController = BodyTypeInfoViewController()
        infoViewController.modalPresentationStyle = .overFullScreen
        present(infoViewController, animated: true, completion: nil)
    }
    
    private func signUpButtonTapped() {
        let loginViewController = LoginViewController()
        // 네비게이션을 통해 로그인 화면으로 전환
        navigationController?.pushViewController(loginViewController, animated: true)
    }
}

//#Preview {
//    UserDetailsViewController()
//}
