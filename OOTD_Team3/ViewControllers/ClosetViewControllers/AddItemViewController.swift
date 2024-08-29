//
//  AddItemViewController.swift
//  OOTD_Team3
//
//  Created by 홍지수 on 8/27/24.
//

import UIKit

class AddItemViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    weak var delegate: AddItemViewControllerDelegate?
    
    private var collectionView: UICollectionView!
    private let purchasedItems = ["camotshirt", "celinetshirt", "pinktop", "frankietshirt", "graytop", "kenzotshirt", "patternedtop"]
    private var selectedItems: Set<String> = []
    
    // 추가된 옷장에 있는 아이템 배열
    private var closetItems: [String] = []
    private var closetCollectionView: UICollectionView!
    
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
        
        // "옷장에 추가하기" 버튼 설정
        let addButton = UIButton(type: .system)
        addButton.setTitle("옷장에 추가하기", for: .normal)
        addButton.setTitleColor(.black, for: .normal) // 검은색 글씨
        addButton.backgroundColor = .white // 흰색 배경
        addButton.layer.borderWidth = 1 // 테두리 너비
        addButton.layer.cornerRadius = 8
        addButton.layer.borderColor = UIColor.black.cgColor // 검은색 테두리
        addButton.addTarget(self, action: #selector(addSelectedItemsToCloset), for: .touchUpInside)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(addButton)
        
        // 컬렉션 뷰 레이아웃 설정 (가로 스크롤)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.itemSize = CGSize(width: 100, height: 100)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ItemCollectionViewCell.self, forCellWithReuseIdentifier: "ItemCell")
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        
        // 옷장에 추가된 아이템을 표시할 두 번째 컬렉션 뷰 설정 (세로 스크롤)
        let closetLayout = UICollectionViewFlowLayout()
        closetLayout.scrollDirection = .vertical
        closetLayout.minimumLineSpacing = 10
        closetLayout.itemSize = CGSize(width: 100, height: 100)
        
        closetCollectionView = UICollectionView(frame: .zero, collectionViewLayout: closetLayout)
        closetCollectionView.delegate = self
        closetCollectionView.dataSource = self
        closetCollectionView.register(ItemCollectionViewCell.self, forCellWithReuseIdentifier: "ClosetItemCell")
        closetCollectionView.backgroundColor = .clear
        closetCollectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(closetCollectionView)
        
        // 오토 레이아웃 설정
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            collectionView.heightAnchor.constraint(equalToConstant: 120),
            
            addButton.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 20),
            addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor), // 버튼 가운데 정렬
            addButton.widthAnchor.constraint(equalToConstant: 150), // 버튼 너비 설정
            addButton.heightAnchor.constraint(equalToConstant: 50), // 버튼 높이 설정
            
            closetCollectionView.topAnchor.constraint(equalTo: addButton.bottomAnchor, constant: 20),
            closetCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            closetCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            closetCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 모달 시트 크기 설정
        if let sheet = self.sheetPresentationController {
            sheet.detents = [.custom { context in
                return context.maximumDetentValue * 0.3
            }]
            sheet.prefersGrabberVisible = true
        }
    }
    
    // UICollectionViewDataSource 메서드
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionView {
            return purchasedItems.count
        } else {
            return closetItems.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCell", for: indexPath) as! ItemCollectionViewCell
        let item = collectionView == self.collectionView ? purchasedItems[indexPath.item] : closetItems[indexPath.item]
        cell.configure(with: item, isSelected: selectedItems.contains(item))
        return cell
    }
    
    // UICollectionViewDelegate 메서드: 셀이 선택되었을 때 호출되는 메서드
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedItem = purchasedItems[indexPath.item]
        if selectedItems.contains(selectedItem) {
            selectedItems.remove(selectedItem)
        } else {
            selectedItems.insert(selectedItem)
        }
        collectionView.reloadItems(at: [indexPath])
    }
    
    // 선택된 아이템들을 옷장에 추가
    @objc private func addSelectedItemsToCloset() {
        closetItems.append(contentsOf: selectedItems)
        delegate?.didSelectItemsToAdd(Array(selectedItems)) // 선택된 아이템을 델리게이트로 넘기기
        selectedItems.removeAll() // 선택 초기화
        closetCollectionView.reloadData()
        collectionView.reloadData()
        dismiss(animated: true, completion: nil) // 모달 닫기 추가
    }
}
// 커스텀 컬렉션 뷰 셀 클래스 정의
class ItemCollectionViewCell: UICollectionViewCell {
    private let imageView = UIImageView()
    private let checkmarkImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "checkmark.circle.fill"))
        imageView.tintColor = .systemBlue
        imageView.alpha = 0.0 // 초기에는 숨김 처리
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(imageView)
        contentView.addSubview(checkmarkImageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            checkmarkImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            checkmarkImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            checkmarkImageView.widthAnchor.constraint(equalToConstant: 24),
            checkmarkImageView.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with imageName: String, isSelected: Bool) {
        imageView.image = UIImage(named: imageName)
        checkmarkImageView.alpha = isSelected ? 1.0 : 0.0 // 선택 여부에 따라 체크마크 표시
    }
}

//#Preview {
//    AddItemViewController()
//}

