//
//  PayViewController.swift
//  OOTD_Team3
//
//  Created by 홍지수 on 8/28/24.
//

import UIKit

class PayViewController: UIViewController {
    
    let payButton: UIButton = {
        let payfloatingButton = UIButton(type: .system)
        payfloatingButton.setTitle("결제하기", for: .normal)
        payfloatingButton.setTitleColor(.white, for: .normal)
        payfloatingButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        
        payfloatingButton.backgroundColor = .black
        payfloatingButton.layer.cornerRadius = 25
        return payfloatingButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(payButton)
        // 결제 버튼 오토레이아웃
        payButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            payButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            payButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 690),
            payButton.widthAnchor.constraint(equalToConstant: 360),
            payButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        payButton.addTarget(self, action: #selector(paybuttonTapped), for: .touchUpInside)
        view.bringSubviewToFront(payButton)
        
        let pageImageView = UIImageView()
        pageImageView.image = UIImage(named: "Checkout")
        pageImageView.contentMode = .scaleAspectFit
        pageImageView.clipsToBounds = true
        
        view.addSubview(pageImageView)
        
        // 오토 레이아웃 설정
        pageImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pageImageView.topAnchor.constraint(equalTo: view.topAnchor),
            pageImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pageImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pageImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        view.bringSubviewToFront(payButton)
    }
    
    @objc private func paybuttonTapped() {
        let payresultnavigateController = PayResultViewController()
        
        if let sheet = payresultnavigateController.sheetPresentationController {
            sheet.detents = [.large(), .large()]
            sheet.prefersGrabberVisible = true
        }
        
        present(payresultnavigateController, animated: true, completion: nil)
    }
    
    
}

#Preview {
    PayViewController()
}
