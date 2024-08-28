
import UIKit
import Lottie

class HomeViewController: UIViewController {
    
    private let lottieView = createLottie()
    private var collectionView: UICollectionView!
    private var categoryButtons: [UIButton] = []
    private var selectedCategory: String = "ALL"
    private let categories = ["ALL", "⭐️BEST", "상의", "하의", "악세서리"]
    private var allImages = ["1-1", "1-2", "1-3", "1-4", "1-5", "1-6", "1-7", "2-1", "2-2", "2-3", "2-4", "3-1", "3-2", "3-3"]
    private var filteredImages: [String] = []
    
    // 프로필 버튼 추가
    let profileButton: UIButton = {
        let profilefloatingButton = UIButton(type: .system)
        profilefloatingButton.setTitle("TIDI's", for: .normal)
//        chatfloatingButton.titleLabel?.numberOfLines = 0
//        chatfloatingButton.titleLabel?.textAlignment = .center
        profilefloatingButton.setTitleColor(.white, for: .normal)
        profilefloatingButton.titleLabel?.isHidden = true
        profilefloatingButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        
        profilefloatingButton.backgroundColor = .black
        profilefloatingButton.layer.cornerRadius = 40
        return profilefloatingButton
    }()
    var isImageVisible = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        // Lottie 애니메이션 설정
        lottieView.contentMode = .scaleAspectFit
        lottieView.loopMode = .playOnce
        lottieView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(lottieView)
        view.addSubview(profileButton)
        
        // Lottie 오토레이아웃
        lottieView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lottieView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lottieView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -159),
            lottieView.widthAnchor.constraint(equalToConstant: 190),
            lottieView.heightAnchor.constraint(equalToConstant: 190)
        ])
        
        
        // 프로필 오토레이아웃
        profileButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profileButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 280),
            profileButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 125),
            profileButton.widthAnchor.constraint(equalToConstant: 80),
            profileButton.heightAnchor.constraint(equalToConstant: 80)
        ])
        profileButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        filteredImages = allImages
        setupLayout()  // 레이아웃 설정
        // 버튼을 가장 위로 가져오기
        view.bringSubviewToFront(profileButton)
        view.bringSubviewToFront(lottieView)
        lottieView.play()
    }
    
    // 버튼 액션
    @objc private func buttonTapped() {
        if isImageVisible {
            // 이미지가 보이는 상태라면 이미지를 제거
            profileButton.setBackgroundImage(nil, for: .normal)
            profileButton.titleLabel?.isHidden = false
        } else {
            // 이미지가 보이지 않는 상태라면 이미지를 추가
            profileButton.setBackgroundImage(UIImage(named: "cat"), for: .normal)
            profileButton.titleLabel?.isHidden = true
        }
        // 상태를 반전시킴
        isImageVisible.toggle()
    }
    
    private func setupLayout() {
        let vstackView = vimageStack()  // 이미지와 검색창을 포함하는 VStack
        let hstackView = hStack()  // 카테고리 버튼을 포함하는 HStack
        collectionView = collectionViewfunc()  // 컬렉션 뷰
        
        let guideLabel = UILabel()
        guideLabel.text = "아래 상품을 클릭하여 구매하실 수 있습니다."
        guideLabel.textAlignment = .center
        guideLabel.font = UIFont.systemFont(ofSize: 14)
        guideLabel.textColor = .black
        view.addSubview(guideLabel)
        guideLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(vstackView)
        view.addSubview(hstackView)
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            //가이드라벨 레이아웃
            guideLabel.topAnchor.constraint(equalTo: vstackView.bottomAnchor, constant: 10),
            guideLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            guideLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            // vstackView 레이아웃 설정
            vstackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            vstackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 1),
            vstackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -1),
            
            // hstackView 레이아웃 설정
            hstackView.topAnchor.constraint(equalTo: guideLabel.bottomAnchor, constant: 10),
            hstackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            hstackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            // collectionView 레이아웃 설정
            collectionView.topAnchor.constraint(equalTo: hstackView.bottomAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5)
        ])
    }

    // VStack 생성
    private func vimageStack() -> UIStackView {
        let vstackView = UIStackView()
        vstackView.axis = .vertical
        vstackView.alignment = .center
        vstackView.distribution = .equalSpacing
        vstackView.spacing = 15
        
        // 로고
        let logoImageView = UIImageView()
        logoImageView.image = UIImage(named: "Image")
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        logoImageView.heightAnchor.constraint(equalToConstant: 25).isActive = true
        vstackView.addArrangedSubview(logoImageView)
        
        // 검색창
        let textField = UITextField()
        textField.placeholder = "OOTD 검색"
        textField.borderStyle = .roundedRect
        textField.widthAnchor.constraint(equalToConstant: 350).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        vstackView.addArrangedSubview(textField)
        
        // AI 채팅 이미지
        let chatImageView = UIImageView()
        chatImageView.image = UIImage(named: "AIImage")
        chatImageView.contentMode = .scaleAspectFit
        chatImageView.widthAnchor.constraint(equalToConstant: 400).isActive = true
        chatImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        chatImageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(presentSheetViewController))
        chatImageView.addGestureRecognizer(tapGesture)
        
        vstackView.addArrangedSubview(chatImageView)
        
        vstackView.translatesAutoresizingMaskIntoConstraints = false
        return vstackView
    }
    
    @objc private func presentSheetViewController() {
        let sheetViewController = LipsOOTDChatBotViewController()
        
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
        hstackView.spacing = 5

        for category in categories {
            let button = UIButton(type: .system)
            button.setTitle(category, for: .normal)
            button.backgroundColor = category == "ALL" ? .black : .gray
            button.setTitleColor(.white, for: .normal)
            button.layer.cornerRadius = 8
            button.addAction(UIAction { _ in
                self.categoryButtonTapped(button)
            }, for: .touchUpInside)
            hstackView.addArrangedSubview(button)
            categoryButtons.append(button)
        }
        hstackView.translatesAutoresizingMaskIntoConstraints = false
        return hstackView
    }
    
    @objc private func categoryButtonTapped(_ sender: UIButton) {
        guard let category = sender.titleLabel?.text else { return }
        selectedCategory = category
        
        categoryButtons.forEach { button in
            button.backgroundColor = button == sender ? .black : .gray
        }
        
        filterImages()
    }
    
    private func filterImages() {
        switch selectedCategory {
        case "ALL":
            filteredImages = allImages
        case "BEST":
            filteredImages = allImages.shuffled().prefix(6).map { $0 }
        case "상의":
            filteredImages = allImages.filter { $0.hasPrefix("1-") }
        case "하의":
            filteredImages = allImages.filter { $0.hasPrefix("2-") }
        case "악세서리":
            filteredImages = allImages.filter { $0.hasPrefix("3-") }
        default:
            filteredImages = allImages
        }
        collectionView.reloadData()
    }
    
    // 컬렉션 뷰 생성
    private func collectionViewfunc() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(collectionViewCell.self, forCellWithReuseIdentifier: "ImageCell")
        collectionView.backgroundColor = .systemGray5
        collectionView.layer.cornerRadius = 10
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }
    
}

//MARK: - 컬렉션뷰

// 컬렉션 뷰 익스텐션 - 다시 보기
extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! collectionViewCell
        let imageName = filteredImages[indexPath.item]
        // 여기서 실제 상품명과 가격 정보를 설정. 예시로 임시 데이터를 사용
        cell.configure(with: imageName, title: "상품 \(indexPath.item + 1)", price: "₩\((indexPath.item + 1) * 10000)")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - 15) / 2
        return CGSize(width: width, height: width * 1.2) // 높이를 20% 증가
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 5 // 아이템 간 간격 설정
        }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5) // 섹션 인셋 설정
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
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.8),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 4),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),

            priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2),
            priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            priceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4)
        ])
    }
    
    func configure(with imageName: String, title: String, price: String) {
        imageView.image = UIImage(named: imageName)
        titleLabel.text = title
        priceLabel.text = price
    }
}

// 로티 생성
private func createLottie() -> LottieAnimationView {
    let animationView = LottieAnimationView(name: "cat")
    animationView.contentMode = .scaleAspectFit
    animationView.translatesAutoresizingMaskIntoConstraints = false
    animationView.loopMode = .loop
    animationView.play()
    return animationView
}


#Preview{
    HomeViewController()
}
