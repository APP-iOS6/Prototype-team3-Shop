//
//  BodyTypeInfoViewController ViewController.swift
//  OOTD_Team3
//
//  Created by Hyeonjeong Sim on 8/29/24.
//

import UIKit

class BodyTypeInfoViewController: UIViewController {
    
    private let infoLabel = UILabel()
    private let closeButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 배경 설정
        view.backgroundColor = UIColor.black.withAlphaComponent(1)
        
        // 정보 라벨 설정
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .left  // 텍스트 왼쪽 정렬
        paragraphStyle.lineSpacing = 8  // 행간 조정
        
        // 텍스트 설정
        let attributedText = NSMutableAttributedString(
            string: """
            1. 스트레이트 (Straight)
            ＂어깨에서 엉덩이까지 몸의 곡선이 거의 없고, 전체적으로 직선형인 체형입니다.＂
            어깨, 허리, 엉덩이의 너비가 비슷한 사람들에게 적합합니다.\n
            2. 웨이브 (Wave)
            ＂몸에 곡선이 있으며 허리가 잘록하고 엉덩이가 약간 넓은 편인 체형입니다.＂
            곡선형의 체형을 가진 사람들에게 적합하며, S자 모양의 실루엣을 나타냅니다.\n
            3. 내추럴 (Natural)
            ＂어깨와 엉덩이가 비슷하게 넓고 허리가 조금 더 넓은 편인 체형입니다.＂
            일반적인 체형으로, 특별히 강조되는 곡선이 없는 경우에 적합합니다.
            """,
            attributes: [
                .font: UIFont.systemFont(ofSize: 18),  // 기본 본문 글자 크기
                .foregroundColor: UIColor.white,
                .paragraphStyle: paragraphStyle
            ]
        )
        
        // 각 제목에 헤드라인 스타일 적용
        let headlineAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 20),  // 제목 글자 크기와 굵기
            .foregroundColor: UIColor.white
        ]
        
        attributedText.addAttributes(headlineAttributes, range: (attributedText.string as NSString).range(of: "1. 스트레이트 (Straight)"))
        attributedText.addAttributes(headlineAttributes, range: (attributedText.string as NSString).range(of: "2. 웨이브 (Wave)"))
        attributedText.addAttributes(headlineAttributes, range: (attributedText.string as NSString).range(of: "3. 내추럴 (Natural)"))
        
        // 정보 라벨에 수정된 텍스트 적용
        infoLabel.attributedText = attributedText
        infoLabel.numberOfLines = 0
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(infoLabel)
        
        // 닫기 버튼 설정
        closeButton.setTitle("닫기", for: .normal)
        closeButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        closeButton.setTitleColor(.white, for: .normal)
        closeButton.backgroundColor = .darkGray
        closeButton.layer.cornerRadius = 8
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        
        view.addSubview(closeButton)
        
        // 오토레이아웃 설정
        NSLayoutConstraint.activate([
            // 정보 라벨 제약조건
            infoLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            infoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            infoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            // 닫기 버튼 제약조건
            closeButton.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 20),
            closeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            closeButton.widthAnchor.constraint(equalToConstant: 100),
            closeButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    @objc private func closeButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
}

//#Preview {
//    BodyTypeInfoViewController()
//}
