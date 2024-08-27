//
//  HeartViewController.swift
//  OOTD_Team3
//
//  Created by wonhoKim on 8/27/24.
//

import UIKit

class OOTDViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    var items: [Item] = []
    private lazy var collectionView: UICollectionView = {
        // UICollectionView의 레이아웃 설정
        let layout = UICollectionViewFlowLayout()
        
        let numberOfItemsPerRow: CGFloat = 2
        let numberOfRows: CGFloat = 3
        

        // 화면의 너비를 가져와서 셀의 크기를 동적으로 계산합니다.
        let totalSpacing = (numberOfItemsPerRow - 1) * 10
        let itemWidth = (UIScreen.main.bounds.width - totalSpacing - (10 * 2)) / numberOfItemsPerRow
        
        // Cell의 크기와 간격 조정
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .lightGray
        
        // 재활용 가능한 custom cell 선언
        collectionView.register(MyCell.self, forCellWithReuseIdentifier: "MyCell")
        
        return collectionView
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        
        for style in Style.allCases {
            let button = UIButton()
            button.setTitle(style.rawValue, for: .normal)
            button.backgroundColor = .lightGray
            button.layer.cornerRadius = 5
            
            button.addTarget(self, action: #selector(selectMember), for: .touchUpInside)
            stackView.addArrangedSubview(button)
        }
        
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        items = ItemStore.shared.items
        
        setupInterface()
    }
    
    
    func setupInterface() {
        view.addSubview(buttonStackView)
        view.addSubview(collectionView)
        buttonStackView.alignment = .center
        
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        let safeGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            buttonStackView.topAnchor.constraint(equalTo: safeGuide.topAnchor),
            buttonStackView.heightAnchor.constraint(equalToConstant: 50),
            buttonStackView.widthAnchor.constraint(equalTo: safeGuide.widthAnchor),
            
            collectionView.topAnchor.constraint(equalTo: buttonStackView.bottomAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: safeGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeGuide.trailingAnchor)
        ])
    }
    
    @objc func selectMember(_ sender: UIButton) {
        if let title = sender.titleLabel?.text {
            items = switch title {
            case Style.geekSik.rawValue:
                ItemStore.shared.items.filter {$0.style == .geekSik}
            case Style.street.rawValue:
                ItemStore.shared.items.filter {$0.style == .street}
            case Style.casual.rawValue:
                ItemStore.shared.items.filter {$0.style == .casual}
            default:
                ItemStore.shared.items
            }
            collectionView.reloadData()
        
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MyCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! MyCell
        let item = items[indexPath.row]
        
        // 예시 이미지 설정
        cell.imageView.image = UIImage(named: item.itemImage)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
}

class MyCell: UICollectionViewCell {
    let imageView: UIImageView
    private let heartImageView: UIImageView
    private var isHeartVisible = false
    
    override init(frame: CGRect) {
        imageView = UIImageView()
        heartImageView = UIImageView(image: UIImage(systemName: "heart.fill"))
        
        super.init(frame: frame)
        
        imageView.frame = contentView.bounds
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        heartImageView.contentMode = .scaleAspectFit
        heartImageView.tintColor = .red
        heartImageView.frame = CGRect(x: contentView.bounds.width - 30, y: 0, width: 30, height: 30)
        heartImageView.isHidden = true // 처음에는 하트 이미지 숨김
        
        contentView.addSubview(imageView)
        contentView.addSubview(heartImageView)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        contentView.addGestureRecognizer(tapGesture)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func handleTap() {
        isHeartVisible.toggle()
        heartImageView.isHidden = !isHeartVisible
    }
}





#Preview {
    OOTDViewController()
}
