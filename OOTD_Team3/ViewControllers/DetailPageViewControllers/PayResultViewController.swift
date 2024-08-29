//
//  PayResultViewController.swift
//  OOTD_Team3
//
//  Created by 홍지수 on 8/28/24.
//

import UIKit

class PayResultViewController: UIViewController {
    
    let backButton: UIButton = {
        let payfloatingButton = UIButton(type: .system)
        payfloatingButton.setTitle("쇼핑 계속하기", for: .normal)
        payfloatingButton.setTitleColor(.white, for: .normal)
        payfloatingButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        
        payfloatingButton.backgroundColor = .black
        payfloatingButton.layer.cornerRadius = 25
        return payfloatingButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(backButton)
        // 결제 버튼 오토레이아웃
        backButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 680),
            backButton.widthAnchor.constraint(equalToConstant: 360),
            backButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        backButton.addTarget(self, action: #selector(backbuttonTapped), for: .touchUpInside)
        view.bringSubviewToFront(backButton)
        
        
        let pageImageView = UIImageView()
        pageImageView.image = UIImage(named: "success")
        pageImageView.contentMode = .scaleAspectFit
        pageImageView.clipsToBounds = true
        //vstackView.addArrangedSubview(pageImageView)
        // Do any additional setup after loading the view.
        
        view.addSubview(pageImageView)
        
        // 오토 레이아웃 설정
        pageImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pageImageView.topAnchor.constraint(equalTo: view.topAnchor),
            pageImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pageImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pageImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        view.bringSubviewToFront(backButton)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 네비게이션 바 숨기기
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // 다른 화면으로 이동할 때 네비게이션 바를 계속 숨기기
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    @objc private func backbuttonTapped() {
        let homeViewController = HomeViewController()
        // 네비게이션 컨트롤러를 통해 화면 전환
        navigationController?.pushViewController(homeViewController, animated: true)

    }
}

//#Preview {
//    PayResultViewController()
//}
