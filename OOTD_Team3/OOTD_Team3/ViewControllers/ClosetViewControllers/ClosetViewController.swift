import UIKit

class ClosetViewController: UIViewController {

    private let stylingRecommendationImages = ["graytop", "kashikoskirt", "celinebag", "goldengoose"]
    private let myClosetImages = ["yellowpointbag", "wooyoungmitshirt", "supremebag", "pinktop", "kashikoskirt", "kashikoskirtivory", "kenzotshirt", "lightjeans", "militarypants", "patternedpants", "patternedtop", "cortezsesame", "cortezsuede", "daybreakcoconut", "emisbag", "frankietshirt", "goldengoose", "graytop", "celinetshirt", "celinebag", "cdgbag", "capripants", "camotshirt", "bermudabrown", "airforcemid"]

    private let topsImages = ["camotshirt", "celinetshirt", "pinktop", "frankietshirt", "graytop", "kenzotshirt", "patternedtop"]
    private let bottomsImages = ["patternedpants", "capripants", "lightjeans", "militarypants", "kashikoskirtivory", "kashikoskirt"]
    private let shoesImages = ["airforcemid", "bermudabrown", "cortezsesame", "cortezsuede", "daybreakcoconut", "goldengoose"]
    private let bagsImages = ["yellowpointbag", "cdgbag", "celinebag", "supremebag", "emisbag"]

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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        images = stylingRecommendationImages
        filteredImages = topsImages

        setupUI()
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

    private func setupUI() {
        // MY CLOSET 라벨
        let closetLabel = UILabel()
        closetLabel.text = "MY CLOSET"
        closetLabel.font = .preferredFont(forTextStyle: .largeTitle)
        closetLabel.textColor = .black
        closetLabel.translatesAutoresizingMaskIntoConstraints = false
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
        recommendationLabel2.text = "Owned Clothes"
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
        let segmentControl = UISegmentedControl(items: ["나의 옷장", "나의 OOTD"])
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
        shareButton.addTarget(self, action: #selector(showAddItemModal), for: .touchUpInside) // 액션 추가
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
        }, for: .touchUpInside) // addAction 사용
        view.addSubview(addLookbookButton)


        // 오토레이아웃 설정
        NSLayoutConstraint.activate([
            // MY CLOSET 라벨
            closetLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            closetLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),

            // "티디가 추천해주는 코디템 조합!" 라벨
            recommendationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            recommendationLabel.bottomAnchor.constraint(equalTo: collectionView.topAnchor, constant: -10),
            recommendationLabel.widthAnchor.constraint(equalToConstant: 230),
            recommendationLabel.heightAnchor.constraint(equalToConstant: 30),

            // Owned Clothes 라벨
            recommendationLabel2.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 30),
            recommendationLabel2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            recommendationLabel2.widthAnchor.constraint(equalToConstant: 150),
            recommendationLabel2.heightAnchor.constraint(equalToConstant: 30),

            // 카테고리 세그먼트 컨트롤러
            categorySegmentControl.leadingAnchor.constraint(equalTo: recommendationLabel2.trailingAnchor, constant: 20),
            categorySegmentControl.centerYAnchor.constraint(equalTo: recommendationLabel2.centerYAnchor),
            categorySegmentControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            // 세그먼트 컨트롤러
            segmentControl.topAnchor.constraint(equalTo: closetLabel.bottomAnchor, constant: 20),
            segmentControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            segmentControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            // 첫 번째 컬렉션 뷰 (티디가 추천해주는 코디템 조합)
            collectionView.topAnchor.constraint(equalTo: segmentControl.bottomAnchor, constant: 60),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            collectionView.heightAnchor.constraint(equalToConstant: 150),

            // 두 번째 컬렉션 뷰 (Owned Clothes)
            collectionView2.topAnchor.constraint(equalTo: recommendationLabel2.bottomAnchor, constant: 10),
            collectionView2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            collectionView2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            collectionView2.bottomAnchor.constraint(equalTo: shareButton.topAnchor, constant: -20),

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
    
    
    private func showPostOOTDOptionModal() {
        let postOOTDOptionVC = PostOOTDOptionViewController()
        postOOTDOptionVC.modalPresentationStyle = .formSheet // 작은 모달 스타일 설정
        present(postOOTDOptionVC, animated: true, completion: nil)
    }
    
    @objc private func showAddItemModal() {
        let addItemVC = AddItemViewController()
        addItemVC.modalPresentationStyle = .pageSheet // 모달 스타일 설정
        present(addItemVC, animated: true, completion: nil)
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
            categorySegmentControl.isHidden = false // 세그먼트 컨트롤러 보이기
            recommendationLabel.text = "# 티디가 추천해주는 코디템 조합"
            recommendationLabel2.text = "Owned Clothes"
            collectionView2.setCollectionViewLayout(UICollectionViewFlowLayout(), animated: false) // 기존 레이아웃 유지
            filteredImages = topsImages // 기본값
        } else { // 나의 OOTD 선택 시
            images = lookbookImages
            shareButton.isHidden = true
            addLookbookButton.isHidden = false
            categorySegmentControl.isHidden = true // 세그먼트 컨트롤러 숨기기
            recommendationLabel.text = "# 내가 추천하는 코디템 조합하기"
            recommendationLabel2.text = "내가 공유한 #OOTD"
            
            // 새로운 이미지 배열로 설정
            filteredImages = ootdImages
            
            // 새로운 레이아웃 설정 (가로 2칸, 세로 스크롤)
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
            
            // 화면 너비에 따라 셀 크기 설정 (가로 2칸)
            let itemWidth = (view.bounds.width - 50) / 2  // 양쪽 마진 20, 셀 간격 10 기준
            layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
            
            layout.minimumLineSpacing = 10
            layout.minimumInteritemSpacing = 10
            
            // `estimatedItemSize`를 .zero로 설정하여 자동 크기 조정 비활성화
            layout.estimatedItemSize = .zero
            
            // 새로운 레이아웃 적용
            collectionView2.setCollectionViewLayout(layout, animated: false)
            collectionView2.collectionViewLayout.invalidateLayout() // 레이아웃 무효화 후 재적용
        }
        collectionView.reloadData()
        collectionView2.reloadData()
    }
}



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

    // 여기에 sizeForItemAt 메서드를 추가합니다.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.collectionView2 { // "내가 공유한 #OOTD" 섹션에만 적용
            let itemWidth = (view.bounds.width - 50) / 2  // 양쪽 마진 20, 셀 간격 10 기준
            return CGSize(width: itemWidth, height: itemWidth)
        } else {
            let width = (collectionView.bounds.width - 20) / 3
            return CGSize(width: width, height: width)
        }
    }
}

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

#Preview {
    ClosetViewController()
}
