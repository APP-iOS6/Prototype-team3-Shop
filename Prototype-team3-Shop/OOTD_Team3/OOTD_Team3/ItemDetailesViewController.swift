//
//  LoginViewController.swift
//  OOTD_Team3
//
//  Created by 이다영 on 8/27/24.
//

import UIKit

class ItemDetailesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }

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
        let imageView = UIImageView(image: UIImage(named: "itemDetailes"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageView)

        // 하트 누르기 버튼
        let heartButton = UIButton(type: .system)
        heartButton.setTitle("♡", for: .normal)
        heartButton.backgroundColor = .black
        heartButton.setTitleColor(.white, for: .normal)
        heartButton.layer.cornerRadius = 8
        heartButton.translatesAutoresizingMaskIntoConstraints = false
        heartButton.addAction(UIAction(title: "하트 누르기") { _ in }, for: .touchUpInside)

        // 구매하기 버튼
        let buyButton = UIButton(type: .system)
        buyButton.setTitle("구매하기", for: .normal)
        buyButton.backgroundColor = .black
        buyButton.setTitleColor(.white, for: .normal)
        buyButton.layer.cornerRadius = 8
        buyButton.translatesAutoresizingMaskIntoConstraints = false
        buyButton.addAction(UIAction(title: "구매하기") { _ in }, for: .touchUpInside)

        // 버튼들을 담을 UIStackView 설정
        let actionStackView = UIStackView(arrangedSubviews: [heartButton, buyButton])
        actionStackView.axis = .horizontal
        actionStackView.spacing = 10
        actionStackView.distribution = .fillEqually
        actionStackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(actionStackView)

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
            imageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 2),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),

            // 스택 뷰 제약조건
            actionStackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            actionStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            actionStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            actionStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            actionStackView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

#Preview {
    ItemDetailesViewController()
}
