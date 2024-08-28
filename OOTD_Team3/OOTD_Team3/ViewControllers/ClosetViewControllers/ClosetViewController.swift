import UIKit

class ClosetViewController: UIViewController {
    private var collectionView: UICollectionView!
    private let images = ["image1", "image2", "image3", "image4", "image5", "image6", "image7", "image8", "image9", "image10"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        closetSetupLayout()
    }
    
    // 오토 레이아웃 설정
    private func closetSetupLayout() {
        let hstackView = hStack()
        let collectionView = collectionViewfunc()  // 컬렉션 뷰
        let vstackView = vimageStack()  // 게시글 추가 버튼 2개 VStack
        
        view.addSubview(hstackView)
        view.addSubview(collectionView)
        view.addSubview(vstackView)
        
        // hstackView 레이아웃 설정
        NSLayoutConstraint.activate([
            hstackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            hstackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            hstackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            hstackView.heightAnchor.constraint(equalToConstant: 60) // hstackView의 높이 설정
        ])
        
        // collectionView 레이아웃 설정
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: hstackView.bottomAnchor, constant: 10),
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

    // HStack 생성
    private func hStack() -> UIStackView {
        let hstackView = UIStackView()
        hstackView.axis = .horizontal
        hstackView.alignment = .center
        hstackView.distribution = .fill
        hstackView.spacing = 10

        let closetLabel = UILabel()
        closetLabel.text = "MY CLOSET"
        closetLabel.font = .preferredFont(forTextStyle: .largeTitle)
        closetLabel.textColor = .brown
        closetLabel.contentMode = .center
        closetLabel.textAlignment = .center
        
        hstackView.addArrangedSubview(closetLabel)
        
        hstackView.translatesAutoresizingMaskIntoConstraints = false
        return hstackView
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

