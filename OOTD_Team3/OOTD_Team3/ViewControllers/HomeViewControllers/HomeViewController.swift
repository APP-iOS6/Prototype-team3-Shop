
import UIKit
import Lottie

class HomeViewController: UIViewController {
    
    private let lottieView = createLottie()  // Lottie 애니메이션 뷰 생성
    private var collectionView: UICollectionView!  // 상품 이미지를 표시하는 컬렉션 뷰
    private var categoryButtons: [UIButton] = []  // 카테고리 버튼들
    private var selectedCategory: String = "ALL"  // 선택된 카테고리 (초기값은 "ALL")
    private let categories = ["ALL", "⭐️BEST", "상의", "하의", "악세서리"]  // 카테고리 목록
    private var allImages = ["1-1", "1-2", "1-3", "1-4", "1-5", "1-6", "1-7", "2-1", "2-2", "2-3", "2-4", "3-1", "3-2", "3-3"]  // 모든 이미지 목록
    private var filteredImages: [String] = []  // 필터링된 이미지 목록
    
    // 프로필 버튼 생성
    let profileButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("TIDI's", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.isHidden = true
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.backgroundColor = .black
        button.layer.cornerRadius = 40
        return button
    }()
    
    var isImageVisible = false  // 프로필 버튼에 이미지가 보이는지 여부
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground  // 배경색 설정
        view.bringSubviewToFront(lottieView)
        
        setupViews()  // 뷰 설정
        setupLayout()  // 레이아웃 설정
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 네비게이션 바 숨기기
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // 다른 화면으로 이동할 때 네비게이션 바를 계속 숨기기
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    private func setupViews() {
        // Lottie 애니메이션 뷰 설정
        lottieView.contentMode = .scaleAspectFit
        lottieView.loopMode = .playOnce
        lottieView.translatesAutoresizingMaskIntoConstraints = false
        lottieView.isUserInteractionEnabled = true  // 사용자 상호작용 가능하도록 설정
        let lottieTapGesture = UITapGestureRecognizer(target: self, action: #selector(presentChatBot))
        lottieView.addGestureRecognizer(lottieTapGesture)  // Lottie 뷰에 탭 제스처 추가
        view.addSubview(lottieView)  // Lottie 뷰 추가
        
        // 프로필 버튼 설정
        profileButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        view.addSubview(profileButton)
        
        // 초기 이미지 필터링
        filteredImages = allImages
    }
    
    private func setupLayout() {
        // Lottie 뷰 오토레이아웃 설정
        NSLayoutConstraint.activate([
            lottieView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lottieView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -159),
            lottieView.widthAnchor.constraint(equalToConstant: 190),
            lottieView.heightAnchor.constraint(equalToConstant: 190)
        ])
        
        // 프로필 버튼 오토레이아웃 설정
        profileButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profileButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 280),
            profileButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 125),
            profileButton.widthAnchor.constraint(equalToConstant: 80),
            profileButton.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        // 가이드 라벨 생성
        let guideLabel = UILabel()
        guideLabel.text = "아래 상품을 클릭하여 구매하실 수 있습니다."
        guideLabel.textAlignment = .center
        guideLabel.font = UIFont.systemFont(ofSize: 14)
        guideLabel.textColor = .black
        view.addSubview(guideLabel)
        guideLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // VStack, HStack 및 컬렉션 뷰 설정
        let vstackView = vimageStack()  // 이미지와 검색창을 포함하는 VStack
        let hstackView = hStack()  // 카테고리 버튼을 포함하는 HStack
        collectionView = createCollectionView()  // 컬렉션 뷰 생성
        
        // 뷰 추가
        view.addSubview(vstackView)
        view.addSubview(hstackView)
        view.addSubview(collectionView)
        
        // 레이아웃 설정
        NSLayoutConstraint.activate([
            guideLabel.topAnchor.constraint(equalTo: vstackView.bottomAnchor, constant: 10),
            guideLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            guideLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            vstackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            vstackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 1),
            vstackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -1),
            
            hstackView.topAnchor.constraint(equalTo: guideLabel.bottomAnchor, constant: 10),
            hstackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            hstackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            collectionView.topAnchor.constraint(equalTo: hstackView.bottomAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5)
        ])
    }
    
    // 프로필 버튼 클릭 시 액션
    @objc private func buttonTapped() {
        if isImageVisible {
            profileButton.setBackgroundImage(nil, for: .normal)
            profileButton.titleLabel?.isHidden = false
        } else {
            profileButton.setBackgroundImage(UIImage(named: "cat"), for: .normal)
            profileButton.titleLabel?.isHidden = true
        }
        isImageVisible.toggle()
    }
    
    // Lottie 이미지 클릭 시 챗봇 화면 표시
    @objc private func presentChatBot() {
        let chatBotViewController = LipsOOTDChatBotViewController()
        
        // 모달 시트 설정 (화면의 절반까지만 차지)
        if let sheet = chatBotViewController.sheetPresentationController {
            sheet.detents = [.medium()]  // 중간 크기만큼 화면을 차지하도록 설정
            sheet.prefersGrabberVisible = true  // 상단에 스와이프할 수 있는 막대 표시
        }
        present(chatBotViewController, animated: true, completion: nil)
    }
    
    // VStack 생성
    private func vimageStack() -> UIStackView {
        let vstackView = UIStackView()
        vstackView.axis = .vertical
        vstackView.alignment = .center
        vstackView.distribution = .equalSpacing
        vstackView.spacing = 15
        
        let logoImageView = UIImageView(image: UIImage(named: "Image"))
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        logoImageView.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        let textField = UITextField()
        textField.placeholder = "OOTD 검색"
        textField.borderStyle = .roundedRect
        textField.widthAnchor.constraint(equalToConstant: 350).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        let chatImageView = UIImageView(image: UIImage(named: ""))
        chatImageView.contentMode = .scaleAspectFit
        chatImageView.widthAnchor.constraint(equalToConstant: 400).isActive = true
        chatImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        chatImageView.isUserInteractionEnabled = true
        chatImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(presentChatBot)))
        
        vstackView.addArrangedSubview(logoImageView)
        vstackView.addArrangedSubview(textField)
        vstackView.addArrangedSubview(chatImageView)
        vstackView.translatesAutoresizingMaskIntoConstraints = false
        
        return vstackView
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
            button.addAction(UIAction { _ in self.categoryButtonTapped(button) }, for: .touchUpInside)
            hstackView.addArrangedSubview(button)
            categoryButtons.append(button)
        }
        
        hstackView.translatesAutoresizingMaskIntoConstraints = false
        return hstackView
    }
    
    // 카테고리 버튼 클릭 시 액션
    @objc private func categoryButtonTapped(_ sender: UIButton) {
        guard let category = sender.titleLabel?.text else { return }
        selectedCategory = category
        
        categoryButtons.forEach { button in
            button.backgroundColor = button == sender ? .black : .gray
        }
        
        filterImages()
    }
    
    // 선택된 카테고리에 따른 이미지 필터링
    private func filterImages() {
        switch selectedCategory {
        case "ALL":
            filteredImages = allImages
        case "⭐️BEST":
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
    private func createCollectionView() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "ImageCell")
        collectionView.backgroundColor = .systemGray5
        collectionView.layer.cornerRadius = 10
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }
}

// MARK: - UICollectionViewDataSource & UICollectionViewDelegateFlowLayout

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // 섹션당 아이템 개수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredImages.count
    }
    
    // 셀 설정
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! CollectionViewCell
        let imageName = filteredImages[indexPath.item]
        cell.configure(with: imageName, title: "상품 \(indexPath.item + 1)", price: "₩\((indexPath.item + 1) * 10000)")
        return cell
    }
    
    // 셀 크기 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - 15) / 2
        return CGSize(width: width, height: width * 1.2)
    }
    
    // 셀이 선택되었을 때 상세 페이지로 전환
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailViewController = ItemDetailesViewController()
        
        // 네비게이션 컨트롤러를 통해 화면 전환
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

// 컬렉션 뷰 셀 클래스
class CollectionViewCell: UICollectionViewCell {
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let priceLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 셀의 뷰 설정
    private func setupViews() {
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 5
        contentView.addSubview(imageView)
        
        titleLabel.font = UIFont.systemFont(ofSize: 12)
        titleLabel.textColor = .black
        titleLabel.textAlignment = .left
        contentView.addSubview(titleLabel)
        
        priceLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        priceLabel.textColor = .black
        priceLabel.textAlignment = .left
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
    
    // 셀 구성
    func configure(with imageName: String, title: String, price: String) {
        imageView.image = UIImage(named: imageName)
        titleLabel.text = title
        priceLabel.text = price
    }
}

// 로티 애니메이션 뷰 생성 함수
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
