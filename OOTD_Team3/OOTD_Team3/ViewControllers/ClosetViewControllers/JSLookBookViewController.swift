//
//  JSLookBookViewController.swift
//  OOTD_Team3
//
//  Created by 홍지수 on 8/27/24.
//

import UIKit

class JSLookBookViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let pageImageView = UIImageView()
        pageImageView.image = UIImage(named: "upload")
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
    }
}
