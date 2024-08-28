//
//  LoginViewController.swift
//  OOTD_Team3
//
//  Created by 이다영 on 8/27/24.
//

import UIKit

class ItemDetailesViewController: UIViewController {
    
    // 뒤로가기 버튼
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        button.tintColor = .black // 버튼의 이미지 색상 설정
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }
    
    // 하트가 버튼 + 클릭 동작 확인
    private let heartButton = UIButton(type: .system)
    var isclicked = false
    
    // 구매하기 버튼
    let buyButton = UIButton(type: .system)
    
    private func setupUI() {
        // 스크롤뷰 설정
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        // 컨텐츠뷰 설정
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        
        // 로고
        let logoImageView = UIImageView(image: UIImage(named: "White"))
        logoImageView.contentMode = .scaleAspectFill
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(logoImageView)
        
        // 이미지 뷰
        let imageView = UIImageView(image: UIImage(named: "detailes"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageView)
        
        // 하트 누르기 버튼
        heartButton.setTitle("♡", for: .normal)
        heartButton.backgroundColor = .gray
        heartButton.setTitleColor(.white, for: .normal)
        heartButton.layer.cornerRadius = 8
        heartButton.translatesAutoresizingMaskIntoConstraints = false
        heartButton.addTarget(self, action: #selector(heartbuttonTapped), for: .touchUpInside)
        
        // 구매하기 버튼
        buyButton.setTitle("구매하기", for: .normal)
        buyButton.backgroundColor = .black
        buyButton.setTitleColor(.white, for: .normal)
        buyButton.layer.cornerRadius = 8
        buyButton.translatesAutoresizingMaskIntoConstraints = false
        buyButton.addAction(UIAction(title: "구매하기") { _ in }, for: .touchUpInside)
        buyButton.addTarget(self, action: #selector(paySheetViewController), for: .touchUpInside)
        
        // 버튼들을 담을 UIStackView 설정
        let actionStackView = UIStackView(arrangedSubviews: [heartButton, buyButton])
        actionStackView.axis = .horizontal
        actionStackView.spacing = 10
        actionStackView.distribution = .fillEqually
        actionStackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(actionStackView)
        
        // UI 설정
        view.addSubview(backButton)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        // 레이아웃 설정
        NSLayoutConstraint.activate([
            // 로고 레이아웃 제약조건
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 20),
            logoImageView.heightAnchor.constraint(equalToConstant: 100),
            
            // 스크롤뷰 제약조건
            scrollView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            // 컨텐츠뷰 제약조건
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
            
            // 이미지뷰 제약조건
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1.3),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            
            // 스택 뷰 제약조건
            actionStackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            actionStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            actionStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            actionStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            actionStackView.heightAnchor.constraint(equalToConstant: 50),
            
            // 뒤로가기 버튼 제약조건
            backButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            backButton.widthAnchor.constraint(equalToConstant: 40),
            backButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    // 하트 클릭 동작
    @objc private func heartbuttonTapped() {
        if isclicked {
            heartButton.setTitle("♥", for: .normal)
        } else {
            heartButton.setTitle("♡", for: .normal)
        }
        isclicked.toggle()
    }
    
    // 구매 동작
    @objc private func paySheetViewController() {
        let paysheetview = PayViewController()
        
        if let sheet = paysheetview.sheetPresentationController {
            sheet.detents = [.large(), .large()]
            sheet.prefersGrabberVisible = true
        }
        present(paysheetview, animated: true, completion: nil)
    }
    
    // 뒤로가기 버튼 클릭 동작
    @objc private func backButtonTapped() {
        // 현재 네비게이션 컨트롤러가 있는 경우
        if let navigationController = navigationController {
            navigationController.popToRootViewController(animated: true)
        } else {
            // 네비게이션 컨트롤러가 없는 경우
            dismiss(animated: true, completion: nil)
        }
    }
}

#Preview {
    ItemDetailesViewController()
}
