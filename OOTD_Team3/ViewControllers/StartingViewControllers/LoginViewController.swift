
//
//  LoginViewController.swift
//  OOTD_Team3
//
//  Created by Hyeonjeong Sim on 8/27/24.
//

import UIKit

class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        // 로고 이미지
        let logoImageView = UIImageView(image: UIImage(named: "White"))
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(logoImageView)
        
        // 이메일 텍스트 필드
        let emailTextField = UITextField()
        emailTextField.placeholder = "Enter your email"
        emailTextField.borderStyle = .roundedRect
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(emailTextField)
        
        // 비밀번호 텍스트 필드
        let passwordTextField = UITextField()
        passwordTextField.placeholder = "Enter your password"
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.isSecureTextEntry = true
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(passwordTextField)
        
        // 로그인 버튼
        let loginButton = UIButton(type: .system)
        loginButton.setTitle("Login", for: .normal)
        loginButton.backgroundColor = .black
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.layer.cornerRadius = 8
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.addAction(UIAction { [weak self] _ in
            self?.goToHomeScreen()
        }, for: .touchUpInside)
        view.addSubview(loginButton)
        
        // 로그인 없이 둘러보기 버튼
        let browseWithoutLoginButton = UIButton(type: .system)
        browseWithoutLoginButton.setTitle("로그인 없이 둘러보기", for: .normal)
        browseWithoutLoginButton.setTitleColor(.black, for: .normal)
        browseWithoutLoginButton.layer.borderWidth = 1
        browseWithoutLoginButton.layer.cornerRadius = 8
        browseWithoutLoginButton.translatesAutoresizingMaskIntoConstraints = false
        browseWithoutLoginButton.addAction(UIAction { [weak self] _ in
            self?.goToHomeScreen()
        }, for: .touchUpInside)
        view.addSubview(browseWithoutLoginButton)
        
        // 카카오로 로그인 버튼
        let kakaoLoginButton = UIButton(type: .system)
        kakaoLoginButton.setTitle("카카오로 로그인", for: .normal)
        kakaoLoginButton.setTitleColor(.black, for: .normal)
        kakaoLoginButton.backgroundColor = .systemYellow
        kakaoLoginButton.layer.cornerRadius = 8
        kakaoLoginButton.translatesAutoresizingMaskIntoConstraints = false
        kakaoLoginButton.addAction(UIAction { [weak self] _ in
            self?.goToHomeScreen()
        }, for: .touchUpInside)
        view.addSubview(kakaoLoginButton)
        
        // Apple로 로그인 버튼
        let appleLoginButton = UIButton(type: .system)
        appleLoginButton.setTitle("Apple로 로그인", for: .normal)
        appleLoginButton.backgroundColor = .black
        appleLoginButton.setTitleColor(.white, for: .normal)
        appleLoginButton.layer.cornerRadius = 8
        appleLoginButton.translatesAutoresizingMaskIntoConstraints = false
        appleLoginButton.addAction(UIAction { [weak self] _ in
            self?.goToHomeScreen()
        }, for: .touchUpInside)
        view.addSubview(appleLoginButton)
        
        // 오토 레이아웃 설정
        NSLayoutConstraint.activate([
            // 로고 이미지 제약조건
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -30),
            logoImageView.widthAnchor.constraint(equalToConstant: 200),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            
            // 이메일 텍스트 필드 제약조건
            emailTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 20),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            emailTextField.heightAnchor.constraint(equalToConstant: 44),
            
            // 비밀번호 텍스트 필드 제약조건
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            passwordTextField.heightAnchor.constraint(equalToConstant: 44),
            
            // 로그인 버튼 제약조건
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            
            // 로그인 없이 둘러보기 버튼 제약조건
            browseWithoutLoginButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 100),
            browseWithoutLoginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            browseWithoutLoginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            browseWithoutLoginButton.heightAnchor.constraint(equalToConstant: 50),
            
            
            // 카카오로 로그인 버튼 제약조건
            kakaoLoginButton.topAnchor.constraint(equalTo: browseWithoutLoginButton.bottomAnchor, constant: 20),
            kakaoLoginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            kakaoLoginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            kakaoLoginButton.heightAnchor.constraint(equalToConstant: 50),
            
            // Apple로 로그인 버튼 제약조건
            appleLoginButton.topAnchor.constraint(equalTo: kakaoLoginButton.bottomAnchor, constant: 20),
            appleLoginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            appleLoginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            appleLoginButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func goToHomeScreen() {
        let tabBarController = MainTabBarController()
        // 네비게이션을 통해 홈 화면으로 전환
        navigationController?.pushViewController(tabBarController, animated: true)
    }
}


#Preview {
    LoginViewController()
}
