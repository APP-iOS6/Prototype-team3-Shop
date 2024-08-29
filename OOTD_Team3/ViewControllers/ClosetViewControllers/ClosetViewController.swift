




import UIKit

protocol AddItemViewControllerDelegate: AnyObject {
    func didSelectItemsToAdd(_ items: [String])
}

class ClosetViewController: UIViewController, AddItemViewControllerDelegate {
    

    private let closetLabel: UILabel = {
        let label = UILabel()
        label.text = "MY CLOSET"
        label.font = .preferredFont(forTextStyle: .largeTitle)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()


    private let stylingRecommendationImages = ["graytop", "kashikoskirt", "celinebag", "goldengoose"]
    private let myClosetImages = ["yellowpointbag", "wooyoungmitshirt", "supremebag", "pinktop", "kashikoskirt", "kashikoskirtivory", "kenzotshirt", "lightjeans", "militarypants", "patternedpants", "patternedtop", "cortezsesame", "cortezsuede", "daybreakcoconut", "emisbag", "frankietshirt", "goldengoose", "graytop", "celinetshirt", "celinebag", "cdgbag", "capripants", "camotshirt", "bermudabrown", "airforcemid"]

    private var topsImages = ["camotshirt", "celinetshirt", "pinktop", "frankietshirt", "graytop", "kenzotshirt", "patternedtop"]
    private var bottomsImages = ["patternedpants", "capripants", "lightjeans", "militarypants", "kashikoskirtivory", "kashikoskirt"]
    private var shoesImages = ["airforcemid", "bermudabrown", "cortezsesame", "cortezsuede", "daybreakcoconut", "goldengoose"]
    private var bagsImages = ["yellowpointbag", "cdgbag", "celinebag", "supremebag", "emisbag"]

    private let lookbookImages = ["noneimage", "noneimage", "noneimage"]
    private let ootdImages = ["ootdpicture", "ootdpicture2", "ootdpicture3", "ootdpicture4", "ootdpicture", "ootdpicture2", "ootdpicture3", "ootdpicture4"]

    private var images: [String] = []
    private var filteredImages: [String] = []
    private var collectionView: UICollectionView!
    private var collectionView2: UICollectionView!

    private let shareButton = UIButton(type: .system) // 옷장 공유 버튼
    private let addLookbookButton = UIButton(type: .system) // 룩북 추가 버튼

    // 라벨 선언
    private let recommendationLabel = UILabel()
    private let recommendationLabel2 = UILabel()
    private let categorySegmentControl = UISegmentedControl(items: ["상의", "하의", "신발", "가방"]) // 카테고리 세그먼트 컨트롤러

    private let segmentControl = UISegmentedControl(items: ["나의 옷장", "나의 OOTD"])

    // 나의 옷장 상태에서의 제약 조건 배열
    private var closetConstraints: [NSLayoutConstraint] = []

    // 나의 OOTD 상태에서의 제약 조건 배열
    private var ootdConstraints: [NSLayoutConstraint] = []
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        images = stylingRecommendationImages
        filteredImages = topsImages

        setupUI()
        setupConstraints() // 제약 조건 설정
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false) // 네비게이션 바 숨기기
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false) // 다른 화면으로 이동할 때 네비게이션 바를 계속 숨기기
    }

    private func setupUI() {
        
        view.addSubview(closetLabel)


        // "티디가 추천해주는 코디템 조합!" 라벨 추가
        recommendationLabel.text = "# 티디가 추천해주는 코디템 조합"
        recommendationLabel.font = .preferredFont(forTextStyle: .body)
        recommendationLabel.textColor = .white
        recommendationLabel.backgroundColor = .black
        recommendationLabel.layer.masksToBounds = true
        recommendationLabel.textAlignment = .center
        recommendationLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(recommendationLabel)

        // "Owned Clothes" 라벨 추가
        recommendationLabel2.text = "소유중인 ITEM"
        recommendationLabel2.font = .preferredFont(forTextStyle: .body)
        recommendationLabel2.textColor = .white
        recommendationLabel2.backgroundColor = .black
        recommendationLabel2.layer.masksToBounds = true
        recommendationLabel2.textAlignment = .center
        recommendationLabel2.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(recommendationLabel2)

        // 세그먼트 컨트롤러 (상의, 하의, 신발, 가방)
        categorySegmentControl.selectedSegmentIndex = 0
        categorySegmentControl.addTarget(self, action: #selector(categoryChanged(_:)), for: .valueChanged)
        categorySegmentControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(categorySegmentControl)

        // 세그먼트 컨트롤러 (나의 옷장, 나의 OOTD)
        segmentControl.selectedSegmentIndex = 0
        segmentControl.addTarget(self, action: #selector(segmentChanged(_:)), for: .valueChanged)
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentControl)

        // 첫 번째 컬렉션 뷰 설정 (티디가 추천해주는 코디템 조합)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ClosetCollectionViewCell.self, forCellWithReuseIdentifier: "ImageCell")
        collectionView.register(PlusCollectionViewCell.self, forCellWithReuseIdentifier: "PlusCell")
        collectionView.backgroundColor = .systemGray6
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)

        // 두 번째 컬렉션 뷰 설정 (Owned Clothes)
        let layout2 = UICollectionViewFlowLayout()
        layout2.scrollDirection = .vertical
        layout2.minimumLineSpacing = 10
        layout2.minimumInteritemSpacing = 10
        collectionView2 = UICollectionView(frame: .zero, collectionViewLayout: layout2)
        collectionView2.register(ClosetCollectionViewCell.self, forCellWithReuseIdentifier: "ImageCell")
        collectionView2.backgroundColor = .systemGray6
        collectionView2.dataSource = self
        collectionView2.delegate = self
        collectionView2.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView2)

        // 코디템 추가하기 버튼
        shareButton.setTitle("코디템 추가하기", for: .normal)
        shareButton.backgroundColor = .black
        shareButton.setTitleColor(.white, for: .normal)
        shareButton.layer.cornerRadius = 8
        shareButton.translatesAutoresizingMaskIntoConstraints = false
        shareButton.addTarget(self, action: #selector(showAddItemModal), for: .touchUpInside)
        view.addSubview(shareButton)

        // #OOTD 게시하기 버튼
        addLookbookButton.setTitle("#OOTD 게시하기", for: .normal)
        addLookbookButton.setTitleColor(.black, for: .normal)
        addLookbookButton.backgroundColor = .white
        addLookbookButton.layer.cornerRadius = 8
        addLookbookButton.layer.borderWidth = 1
        addLookbookButton.layer.borderColor = UIColor.black.cgColor
        addLookbookButton.translatesAutoresizingMaskIntoConstraints = false
        addLookbookButton.isHidden = true // 초기에는 숨김 처리
        addLookbookButton.addAction(UIAction { [weak self] _ in
            self?.showPostOOTDOptionModal()
        }, for: .touchUpInside)
        view.addSubview(addLookbookButton)
        

    }
    // AddItemViewControllerDelegate 메서드 구현
    func didSelectItemsToAdd(_ items: [String]) {
        // 현재 선택된 세그먼트에 따라 filteredImages에 아이템 추가
        switch categorySegmentControl.selectedSegmentIndex {
        case 0: // 상의
            topsImages.append(contentsOf: items)
            filteredImages = topsImages
        case 1: // 하의
            bottomsImages.append(contentsOf: items)
            filteredImages = bottomsImages
        case 2: // 신발
            shoesImages.append(contentsOf: items)
            filteredImages = shoesImages
        case 3: // 가방
            bagsImages.append(contentsOf: items)
            filteredImages = bagsImages
        default:
            break
        }
        collectionView2.reloadData() // 두 번째 컬렉션 뷰 업데이트
    }

    private func setupConstraints() {
        // 나의 옷장 상태 제약 조건
        closetConstraints = [
            recommendationLabel2.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 10),
            recommendationLabel2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),  // 왼쪽 정렬 추가
            collectionView2.topAnchor.constraint(equalTo: recommendationLabel2.bottomAnchor, constant: 15)
        ]
        
        // 나의 OOTD 상태 제약 조건
        ootdConstraints = [
            recommendationLabel2.topAnchor.constraint(equalTo: segmentControl.bottomAnchor, constant: 20),
            recommendationLabel2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),  // 왼쪽 정렬 추가
            collectionView2.topAnchor.constraint(equalTo: recommendationLabel2.bottomAnchor, constant: 15)
        ]
        
        // 초기에는 나의 옷장 상태를 활성화
        NSLayoutConstraint.activate(closetConstraints)
        
        // 오토레이아웃 설정
        NSLayoutConstraint.activate([
            // MY CLOSET 라벨
            closetLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -5),
            closetLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),

            // "티디가 추천해주는 코디템 조합!" 라벨
            recommendationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            recommendationLabel.bottomAnchor.constraint(equalTo: collectionView.topAnchor, constant: -15),
            recommendationLabel.widthAnchor.constraint(equalToConstant: 230),
            recommendationLabel.heightAnchor.constraint(equalToConstant: 30),

            // Owned Clothes 라벨
            recommendationLabel2.widthAnchor.constraint(equalToConstant: 150),
            recommendationLabel2.heightAnchor.constraint(equalToConstant: 30),

            // 카테고리 세그먼트 컨트롤러
            categorySegmentControl.leadingAnchor.constraint(equalTo: recommendationLabel2.trailingAnchor, constant: 20),
            categorySegmentControl.centerYAnchor.constraint(equalTo: recommendationLabel2.centerYAnchor),
            categorySegmentControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            // 세그먼트 컨트롤러
            segmentControl.topAnchor.constraint(equalTo: closetLabel.bottomAnchor, constant: 10),
            segmentControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            segmentControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            // 첫 번째 컬렉션 뷰 (티디가 추천해주는 코디템 조합)
            collectionView.topAnchor.constraint(equalTo: segmentControl.bottomAnchor, constant: 60),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            collectionView.heightAnchor.constraint(equalToConstant: 100),

            // 두 번째 컬렉션 뷰 (Owned Clothes)
            collectionView2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            collectionView2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            collectionView2.bottomAnchor.constraint(equalTo: shareButton.topAnchor, constant: -10),

            // 코디템 추가하기 버튼
            shareButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            shareButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            shareButton.widthAnchor.constraint(equalToConstant: 150),
            shareButton.heightAnchor.constraint(equalToConstant: 50),

            // 룩북 추가 버튼
            addLookbookButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addLookbookButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            addLookbookButton.widthAnchor.constraint(equalToConstant: 150),
            addLookbookButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    @objc private func showAddItemModal() {
        let addItemVC = AddItemViewController()
        addItemVC.delegate = self // 여기에 추가하세요
        addItemVC.modalPresentationStyle = .pageSheet
        present(addItemVC, animated: true, completion: nil)
    }

    @objc private func showPostOOTDOptionModal() {
        let postOOTDOptionVC = PostOOTDOptionViewController()
        postOOTDOptionVC.modalPresentationStyle = .formSheet
        present(postOOTDOptionVC, animated: true, completion: nil)
    }

    @objc private func categoryChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            filteredImages = topsImages // 상의
        case 1:
            filteredImages = bottomsImages // 하의
        case 2:
            filteredImages = shoesImages // 신발
        case 3:
            filteredImages = bagsImages // 가방
        default:
            filteredImages = [] // 기본값
        }
        collectionView2.reloadData()
    }

    @objc private func segmentChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 { // 나의 옷장 선택 시
            images = stylingRecommendationImages
            shareButton.isHidden = false
            addLookbookButton.isHidden = true
            categorySegmentControl.isHidden = false
            
            recommendationLabel.isHidden = false
            recommendationLabel2.isHidden = false
            
            collectionView.isHidden = false
            collectionView2.isHidden = false

            recommendationLabel.text = "# 티디가 추천해주는 코디템 조합"
            recommendationLabel2.text = "Owned Clothes"
            collectionView2.setCollectionViewLayout(UICollectionViewFlowLayout(), animated: false)
            filteredImages = topsImages
            
            NSLayoutConstraint.deactivate(ootdConstraints) // 나의 OOTD 레이아웃 비활성화
            NSLayoutConstraint.activate(closetConstraints) // 나의 옷장 레이아웃 활성화
            
        } else { // 나의 OOTD 선택 시
            images = lookbookImages
            shareButton.isHidden = true
            addLookbookButton.isHidden = false
            categorySegmentControl.isHidden = true
            
            recommendationLabel.isHidden = true
            collectionView.isHidden = true
            
            recommendationLabel2.text = "내가 공유한 #OOTD"
            recommendationLabel2.isHidden = false
            
            collectionView2.isHidden = false
            
            filteredImages = ootdImages
            
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
            let itemWidth = (view.bounds.width - 50) / 2
            layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
            layout.minimumLineSpacing = 10
            layout.minimumInteritemSpacing = 10
            layout.estimatedItemSize = .zero
            collectionView2.setCollectionViewLayout(layout, animated: false)
            collectionView2.collectionViewLayout.invalidateLayout()
            
            NSLayoutConstraint.deactivate(closetConstraints) // 나의 옷장 레이아웃 비활성화
            NSLayoutConstraint.activate(ootdConstraints) // 나의 OOTD 레이아웃 활성화
        }
        
        collectionView.reloadData()
        collectionView2.reloadData()
    }
}

// UICollectionViewDataSource 및 UICollectionViewDelegateFlowLayout
extension ClosetViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionView {
            return images.count * 2 - 1 // PlusCell을 포함한 기존 코드
        } else {
            return filteredImages.count // 필터링된 이미지 개수
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionView {
            if indexPath.item % 2 == 0 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ClosetCollectionViewCell
                let imageIndex = indexPath.item / 2
                cell.configure(with: images[imageIndex])
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlusCell", for: indexPath) as! PlusCollectionViewCell
                return cell
            }
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ClosetCollectionViewCell
            cell.configure(with: filteredImages[indexPath.item])
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.collectionView2 {
            let itemWidth = (view.bounds.width - 50) / 2
            return CGSize(width: itemWidth, height: itemWidth)
        } else {
            let width = (collectionView.bounds.width - 20) / 3
            return CGSize(width: width, height: width)
        }
    }
}

// CollectionView 셀 설정
class ClosetCollectionViewCell: UICollectionViewCell {
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 8
        return iv
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with imageName: String) {
        imageView.image = UIImage(named: imageName)
    }
}

class PlusCollectionViewCell: UICollectionViewCell {
    private let plusImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "plus.circle"))
        imageView.tintColor = .gray
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(plusImageView)
        plusImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            plusImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            plusImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            plusImageView.widthAnchor.constraint(equalToConstant: 30),
            plusImageView.heightAnchor.constraint(equalToConstant: 30)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//#Preview {
//    ClosetViewController()
//}
