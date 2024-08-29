//
//  AddItemViewController.swift
//  OOTD_Team3
//
//  Created by 홍지수 on 8/27/24.
//

import UIKit

class AddItemViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    private var collectionView: UICollectionView!
    private let purchasedItems = ["kenzotshirt", "celinetshirt", "pinktop", "frankietshirt"] // 예시 이미지 이름들

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // 구매한 아이템 목록 라벨 설정
        let titleLabel = UILabel()
        titleLabel.text = "구매한 아이템 목록"
        titleLabel.font = .preferredFont(forTextStyle: .headline)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        // 컬렉션 뷰 레이아웃 설정 (가로 스크롤)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.itemSize = CGSize(width: 100, height: 100)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "ItemCell")
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(collectionView)
        
        // 오토 레이아웃 설정
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            collectionView.heightAnchor.constraint(equalToConstant: 120)
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 모달 시트 크기 설정
        if let sheet = self.sheetPresentationController {
            // 화면 높이의 1/4로 설정하는 custom detent 추가
            sheet.detents = [.custom { context in
                return context.maximumDetentValue * 0.3  // 화면 높이의 1/4로 설정
            }]
            sheet.prefersGrabberVisible = true // 상단 손잡이 표시
        }
    }
    
    // UICollectionViewDataSource 메서드
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return purchasedItems.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCell", for: indexPath)
        
        // 이미지 뷰 추가
        let imageView = UIImageView(image: UIImage(named: purchasedItems[indexPath.item]))
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        cell.contentView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: cell.contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor)
        ])
        
        return cell
    }
    
    // UICollectionViewDelegate 메서드: 셀이 선택되었을 때 호출되는 메서드
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedItem = purchasedItems[indexPath.item]
        showAddToClosetAlert(for: selectedItem)
    }
    
    // 옷장에 추가할 것인지 묻는 알림 표시
    private func showAddToClosetAlert(for item: String) {
        let alert = UIAlertController(title: "아이템 추가", message: "\(item)을(를) 옷장에 넣으시겠습니까?", preferredStyle: .alert)
        
        // 확인 버튼
        alert.addAction(UIAlertAction(title: "넣기", style: .default, handler: { _ in
            // 옷장에 아이템 추가 로직 구현
            print("\(item)이(가) 옷장에 추가되었습니다.")
        }))
        
        // 취소 버튼
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
}

//#Preview {
//    AddItemViewController()
//}

