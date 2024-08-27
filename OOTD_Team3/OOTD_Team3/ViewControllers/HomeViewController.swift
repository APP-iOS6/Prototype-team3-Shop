import UIKit

class HomeViewController: UIViewController {
    
    private var collectionView: UICollectionView!
    private let images = ["image1", "image2", "image3", "image4"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        setupLayout()  // 레이아웃 설정
    }
    
    private func setupLayout() {
        let vstackView = vimageStack()  // 이미지와 검색창을 포함하는 VStack
        let hstackView = hStack()  // 카테고리 버튼을 포함하는 HStack
        let collectionView = collectionViewfunc()  // 컬렉션 뷰
        
        view.addSubview(vstackView)
        view.addSubview(hstackView)
        view.addSubview(collectionView)
        
        // vstackView 레이아웃 설정
        NSLayoutConstraint.activate([
            vstackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            vstackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 1),
            vstackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -1)
        ])
        
        // hstackView 레이아웃 설정
        NSLayoutConstraint.activate([
            hstackView.topAnchor.constraint(equalTo: vstackView.bottomAnchor, constant: 10),
            hstackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            hstackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
        
        // collectionView 레이아웃 설정
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: hstackView.bottomAnchor, constant: 5),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5)
        ])
    }
    
    // VStack 생성
    private func vimageStack() -> UIStackView {
        let vstackView = UIStackView()
        vstackView.axis = .vertical
        vstackView.alignment = .center
        vstackView.distribution = .equalSpacing
        vstackView.spacing = 10
        
        // 로고
        let logoImageView = UIImageView()
        logoImageView.image = UIImage(named: "Image")
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        logoImageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        vstackView.addArrangedSubview(logoImageView)
        
        // 검색창
        let textField = UITextField()
        textField.placeholder = "OOTD 검색"
        textField.borderStyle = .roundedRect
        textField.widthAnchor.constraint(equalToConstant: 250).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        vstackView.addArrangedSubview(textField)
        
        // AI 채팅 이미지
        let chatImageView = UIImageView()
        chatImageView.image = UIImage(named: "AIImage")
        chatImageView.contentMode = .scaleAspectFit
        chatImageView.widthAnchor.constraint(equalToConstant: 400).isActive = true
        chatImageView.heightAnchor.constraint(equalToConstant: 280).isActive = true
        
        chatImageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(presentSheetViewController))
        chatImageView.addGestureRecognizer(tapGesture)
        
        vstackView.addArrangedSubview(chatImageView)
        
        vstackView.translatesAutoresizingMaskIntoConstraints = false
        return vstackView
    }
    
    @objc private func presentSheetViewController() {
        let sheetViewController = LipsOOTDChatBotViewController()
//        sheetViewController.view.backgroundColor = .white
        
        // 시트의 내용을 여기에 추가합니다.
//        let label = UILabel()
//        label.text = "AI 채팅 시트"
//        label.textAlignment = .center
//        sheetViewController.view.addSubview(label)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            label.centerXAnchor.constraint(equalTo: sheetViewController.view.centerXAnchor),
//            label.centerYAnchor.constraint(equalTo: sheetViewController.view.centerYAnchor)
//        ])

        if let sheet = sheetViewController.sheetPresentationController {
            sheet.detents = [.large(), .large()]
            sheet.prefersGrabberVisible = true
        }

        present(sheetViewController, animated: true, completion: nil)
    }
    
    // HStack 생성
    private func hStack() -> UIStackView {
        let hstackView = UIStackView()
        hstackView.axis = .horizontal
        hstackView.alignment = .fill
        hstackView.distribution = .fillEqually
        hstackView.spacing = 10
        
        let categories = ["긱시크", "스트리트", "포멀", "캐주얼"]
        for category in categories {
            let button = UIButton(type: .system)
            button.setTitle(category, for: .normal)
            button.backgroundColor = .systemBrown
            button.setTitleColor(.white, for: .normal)
            button.layer.cornerRadius = 8
            button.addAction(UIAction { [weak button] _ in
                guard let button = button else { return }
                button.backgroundColor = .systemBlue
            }, for: .touchUpInside)
            button.addAction(UIAction { [weak button] _ in
                guard let button = button else { return }
                button.backgroundColor = .systemBrown
            }, for: .touchUpInside)
            hstackView.addArrangedSubview(button)
        }
        
        hstackView.translatesAutoresizingMaskIntoConstraints = false
        return hstackView
    }
    
    // 컬렉션 뷰 생성
    private func collectionViewfunc() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(collectionViewCell.self, forCellWithReuseIdentifier: "ImageCell")
        collectionView.backgroundColor = .brown
        collectionView.layer.cornerRadius = 5
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }
}

// ------------------------------------------------------------------------------------------------------------

// 컬렉션 뷰 익스텐션 - 다시 보기
extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! collectionViewCell
        cell.configure(with: images[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - 20) / 2
        return CGSize(width: width, height: width)
    }
}

// 컬렉션 뷰 셀
class collectionViewCell: UICollectionViewCell {
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 5
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupImageView() {
        contentView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    func configure(with imageName: String) {
        imageView.image = UIImage(named: imageName)
    }
}

