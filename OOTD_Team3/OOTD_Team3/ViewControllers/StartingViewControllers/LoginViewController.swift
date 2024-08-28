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
        
        // 이메일로 가입하기 버튼
        let signUpButton = UIButton(type: .system)
        signUpButton.setTitle("이메일로 가입하기", for: .normal)
        signUpButton.setTitleColor(.black, for: .normal)
        signUpButton.layer.borderWidth = 1
        signUpButton.layer.cornerRadius = 8
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.addAction(UIAction { [weak self] _ in
            self?.goToHomeScreen()
        }, for: .touchUpInside)
        view.addSubview(signUpButton)
        
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
            
            // 이메일로 가입하기 버튼 제약조건
            signUpButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 140),
            signUpButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            signUpButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            signUpButton.heightAnchor.constraint(equalToConstant: 50),
            
            // 카카오로 로그인 버튼 제약조건
            kakaoLoginButton.topAnchor.constraint(equalTo: signUpButton.bottomAnchor, constant: 20),
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
        // 홈 화면과 탭바 설정
        let homeViewController = HomeViewController()
        homeViewController.tabBarItem = UITabBarItem(title: "홈", image: UIImage(systemName: "house"), tag: 0)
        
        let ootdViewController = OOTDViewController()
        ootdViewController.tabBarItem = UITabBarItem(title: "오오티디", image: UIImage(systemName: "number"), tag: 1)
        
        let closetViewController = ClosetViewController()
        closetViewController.tabBarItem = UITabBarItem(title: "옷장", image: UIImage(systemName: "hanger"), tag: 2)
        
        let myViewController = MyViewController()
        myViewController.tabBarItem = UITabBarItem(title: "마이", image: UIImage(systemName: "person"), tag: 3)
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [homeViewController, ootdViewController, closetViewController, myViewController]
        
        // 전체 화면으로 탭바 컨트롤러 표시
        tabBarController.modalTransitionStyle = .crossDissolve
        tabBarController.modalPresentationStyle = .fullScreen
        
        // 현재 LoginViewController에서 홈 화면으로 전환
        present(tabBarController, animated: true, completion: nil)
    }
}


//#Preview {
//    LoginViewController()
//}
