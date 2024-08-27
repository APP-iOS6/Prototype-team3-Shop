//
//  PersonViewController.swift
//  OOTD_Team3
//
//  Created by wonhoKim on 8/27/24.
//

import UIKit

class MyViewController: UIViewController {

    override func viewDidLoad() {
        view.backgroundColor = .systemBackground
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        // 로고
        let logoImageView = UIImageView(image: UIImage(named: "White"))
        logoImageView.contentMode = .scaleAspectFill
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(logoImageView)
        
        // (대체)마이페이지 이미지
        let myImageView = UIImageView(image: UIImage(named: "myPage"))
        myImageView.contentMode = .scaleAspectFill
        myImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(myImageView)
        
        NSLayoutConstraint.activate([
            // 로고 레이아웃 제약조건
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 20),
            logoImageView.heightAnchor.constraint(equalToConstant: 140),
            
            // 마이페이지 이미지 제약조건
            myImageView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 90),
            myImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            myImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            myImageView.heightAnchor.constraint(equalTo: myImageView.widthAnchor),
        ])
        
    }
}

#Preview {
    MyViewController()
}
