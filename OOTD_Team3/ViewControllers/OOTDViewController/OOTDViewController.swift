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
        
        let spacing: CGFloat = 10
        let numberOfItemsPerRow: CGFloat = 2

        // 화면의 너비를 가져와서 셀의 크기를 동적으로 계산합니다.
        let totalSpacing = (numberOfItemsPerRow + 1) * spacing
        let itemWidth = (UIScreen.main.bounds.width - totalSpacing) / numberOfItemsPerRow
        
        // Cell의 크기와 간격 조정
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .systemGray5
        
        // 재활용 가능한 custom cell 선언
        collectionView.register(MyCell.self, forCellWithReuseIdentifier: "MyCell")

        
        return collectionView
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        
        for style in Style.allCases {
            let button = UIButton()
            button.setTitle(style.rawValue, for: .normal)
            button.backgroundColor = .gray
            button.layer.cornerRadius = 5
            
            button.addTarget(self, action: #selector(selectMember), for: .touchUpInside)
            stackView.addArrangedSubview(button)
        }
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        items = ItemStore.shared.items
        
        setupInterface()
        
        title = "OOTD"
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
            buttonStackView.leadingAnchor.constraint(equalTo: safeGuide.leadingAnchor, constant: 20),
            buttonStackView.trailingAnchor.constraint(equalTo: safeGuide.trailingAnchor, constant: -20),
            
            collectionView.topAnchor.constraint(equalTo: buttonStackView.bottomAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: safeGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeGuide.trailingAnchor)
        ])
    }
    
    @objc func selectMember(_ sender: UIButton) {
        
        // 카테고리 선택 시 회색->검정색
        for case let button as UIButton in buttonStackView.arrangedSubviews {
            button.backgroundColor = .gray
        }
        sender.backgroundColor = .black
        
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
        
        //버튼 추가
        cell.infoButton.addTarget(self, action: #selector(showDetailes), for: .touchUpInside)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    @objc func showDetailes() {
        let detailsVC = OOTDDetailesViewController()
        if let navigationController = navigationController {
            navigationController.pushViewController(detailsVC, animated: true)
        } else {
            present(detailsVC, animated: true, completion: nil)
        }
    }
}

class MyCell: UICollectionViewCell {
    let imageView: UIImageView
    private let heartImageView: UIImageView
    let infoButton: UIButton
    private var isHeartVisible = false
    
    override init(frame: CGRect) {
        imageView = UIImageView()
        heartImageView = UIImageView(image: UIImage(systemName: "heart.fill"))
        infoButton = UIButton(type: .system)
        
        super.init(frame: frame)
        
        imageView.frame = contentView.bounds
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        
        heartImageView.contentMode = .scaleAspectFit
        heartImageView.tintColor = .red
        heartImageView.frame = CGRect(x: contentView.bounds.width - 30, y: 150, width: 30, height: 30)
        heartImageView.isHidden = true // 처음에는 하트 이미지 숨김
        
        infoButton.setTitle("정보", for: .normal)
        infoButton.backgroundColor = .gray
        infoButton.setTitleColor(.white, for: .normal)
        infoButton.layer.cornerRadius = 5
        infoButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        infoButton.frame = CGRect(x: 5, y: contentView.bounds.height - 30, width: 40, height: 25)

        contentView.addSubview(imageView)
        contentView.addSubview(heartImageView)
        contentView.addSubview(infoButton)
        
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

//#Preview {
//    OOTDViewController()
//}
