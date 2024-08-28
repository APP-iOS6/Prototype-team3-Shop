import UIKit

class ClosetViewController: UIViewController {
    private var collectionView: UICollectionView!
    private let images = ["image1", "image2", "image3", "image4", "image5", "image6", "image7", "image8", "image9", "image10"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        closetSetupLayout()
        
        // 버튼 추가
        let aiFloatingButton = UIButton(type: .system)
        aiFloatingButton.setTitle("CHAT", for: .normal)
        aiFloatingButton.backgroundColor = .systemBrown
        aiFloatingButton.setTitleColor(.white, for: .normal)
        aiFloatingButton.layer.cornerRadius = 25
        aiFloatingButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        view.addSubview(aiFloatingButton)
        
        // 오토 레이아웃 설정
        aiFloatingButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            aiFloatingButton.widthAnchor.constraint(equalToConstant: 100),
            aiFloatingButton.heightAnchor.constraint(equalToConstant: 50),
            aiFloatingButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            aiFloatingButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
        
        // 버튼을 가장 위로 가져오기
        view.bringSubviewToFront(aiFloatingButton)
    }
    
    // 버튼 액션
    @objc private func buttonTapped() {
        let chatViewController = LipsOOTDChatBotViewController()
        navigationController?.pushViewController(chatViewController, animated: true)
    }
    
    // 오토 레이아웃 설정
    private func closetSetupLayout() {
        let titlevstackView = titleVStack()
        let collectionView = collectionViewfunc()  // 컬렉션 뷰
        let vstackView = vimageStack()  // 게시글 추가 버튼 2개 VStack
        
        view.addSubview(titlevstackView)
        view.addSubview(collectionView)
        view.addSubview(vstackView)
        
        // hstackView 레이아웃 설정
        NSLayoutConstraint.activate([
            titlevstackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            titlevstackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            titlevstackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            titlevstackView.heightAnchor.constraint(equalToConstant: 80) // hstackView의 높이 설정
        ])
        
        // collectionView 레이아웃 설정
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: titlevstackView.bottomAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            collectionView.bottomAnchor.constraint(equalTo: vstackView.topAnchor, constant: -10)
        ])
        
        // vstackView 레이아웃 설정
        NSLayoutConstraint.activate([
            vstackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            vstackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            vstackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            vstackView.heightAnchor.constraint(equalToConstant: 100) // vstackView의 높이 설정
        ])
    }

    // 타이틀, 세그먼트 버튼 VStack 생성
    private func titleVStack() -> UIStackView {
        let titlevstackView = UIStackView()
        titlevstackView.axis = .vertical
        titlevstackView.alignment = .center
        titlevstackView.distribution = .fill
        titlevstackView.spacing = 10

        let closetLabel = UILabel()
        closetLabel.text = "MY CLOSET"
        closetLabel.font = .preferredFont(forTextStyle: .largeTitle)
        closetLabel.textColor = .brown
        closetLabel.contentMode = .center
        closetLabel.textAlignment = .center
        titlevstackView.addArrangedSubview(closetLabel)
        
        // 나의 옷장 , 룩북 중 선택
        let uploadTypeSegmentedControl = UISegmentedControl(items: ["옷장", "룩북"])
        uploadTypeSegmentedControl.selectedSegmentIndex = 0
        uploadTypeSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        uploadTypeSegmentedControl.widthAnchor.constraint(equalToConstant: 350).isActive = true
        titlevstackView.addArrangedSubview(uploadTypeSegmentedControl)
        
        titlevstackView.translatesAutoresizingMaskIntoConstraints = false
        return titlevstackView
    }
    
    // 컬렉션 뷰 생성
    private func collectionViewfunc() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(closetcollectionViewCell.self, forCellWithReuseIdentifier: "ImageCell")
        collectionView.backgroundColor = .systemGray5
        collectionView.layer.cornerRadius = 10
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }
    
    // 버튼 2개
    private func vimageStack() -> UIStackView {
        let vstackView = UIStackView()
        vstackView.axis = .vertical
        vstackView.alignment = .center
        vstackView.distribution = .equalSpacing
        vstackView.spacing = 15
        
        // 옷장 공유 버튼
        let closetbutton = UIButton(type: .system)
        closetbutton.setTitle("옷장 공유", for: .normal)
        closetbutton.backgroundColor = .systemBrown
        closetbutton.setTitleColor(.white, for: .normal)
        closetbutton.widthAnchor.constraint(equalToConstant: 350).isActive = true
        closetbutton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        closetbutton.layer.cornerRadius = 8
        closetbutton.addAction(UIAction { [weak closetbutton] _ in
            guard let closetbutton = closetbutton else { return }
            closetbutton.backgroundColor = .systemOrange
        }, for: .touchUpInside)
        vstackView.addArrangedSubview(closetbutton)
        
        // 룩북 추가 버튼
        let lookbookbutton = UIButton(type: .system)
        lookbookbutton.setTitle("+ 룩북 추가", for: .normal)
        lookbookbutton.backgroundColor = .systemOrange
        lookbookbutton.setTitleColor(.white, for: .normal)
        lookbookbutton.layer.cornerRadius = 8
        lookbookbutton.widthAnchor.constraint(equalToConstant: 350).isActive = true
        lookbookbutton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        lookbookbutton.addAction(UIAction { [weak lookbookbutton] _ in
            guard let lookbookbutton = lookbookbutton else { return }
            self.lookbookSheetViewController()
        }, for: .touchUpInside)
        vstackView.addArrangedSubview(lookbookbutton)
        
        vstackView.translatesAutoresizingMaskIntoConstraints = false
        return vstackView
    }
    
    @objc private func lookbookSheetViewController() {
        let sheetViewController = JSLookBookViewController()
        
        if let sheet = sheetViewController.sheetPresentationController {
            sheet.detents = [.large(), .large()]
            sheet.prefersGrabberVisible = true
        }
        present(sheetViewController, animated: true, completion: nil)
    }
}

// 컬렉션 뷰 익스텐션 - 다시 보기
extension ClosetViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! closetcollectionViewCell
        cell.configure(with: images[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - 30) / 2
        return CGSize(width: width, height: width)
    }
}

// 컬렉션 뷰 셀
class closetcollectionViewCell: UICollectionViewCell {
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

