//
//  QuestionViewController.swift
//  OOTD_Team3
//
//  Created by Hyeonjeong Sim on 8/27/24.
//

import UIKit
import Lottie

class TestViewController: UIViewController {
    
    // 프로그래스 바 및 진행 상태 레이블
    private let progressBar = UIView()
    private let progressBarFill = UIView()
    private let progressLabel = UILabel()
    
    // 문제와 선택지 레이블
    private let questionLabel = UILabel()
    private let option1Button = UIButton(type: .system)
    private let option2Button = UIButton(type: .system)
    
    // Lottie 애니메이션과 다시하기 및 결과보기 버튼
    private let lottieView = LottieAnimationView(name: "cat")
    private let retryButton = UIButton(type: .system)
    private let resultButton = UIButton(type: .system)
    
    // 말풍선 이미지
    private let resultBubbleImageView = UIImageView(image: UIImage(named: "resultBubble"))
    
    // 현재 문제 인덱스
    private var currentQuestionIndex = 0
    
    private var progressBarConstraint: NSLayoutConstraint?

    
    // 문제와 선택지 데이터
    private let questions = [
        ("당신은 새로운 스타일을 시도할 때 \n어떻게 하시나요?", ["새로운 도전을 즐기며 과감하게 시도하는 편이에요.", "익숙한 스타일을 유지하는 것이 편해요."]),
        ("당신이 옷을 고를 때 \n가장 중요한 요소는 무엇인가요?", ["트렌디하고 최신 유행에 맞는 스타일을 선호해요.", "편안하고 내게 잘 맞는 스타일을 선호해요."]),
        ("친구들을 만나러 외출할 때 \n어떤 스타일을 선호하나요?", ["눈에 띄고 주목받는 화려한 스타일.", "심플하면서도 세련된 미니멀한 스타일을 선호해요."]),
        ("쇼핑을 할 때 어떤 기준으로 옷을 구매하나요?", ["그때그때 마음에 드는 아이템을 즉흥적으로 구매해요.", "필요한 옷을 미리 계획하고 구매하는 선호해요."]),
        ("액세서리를 선택할 때 어떻게 고르시나요?", ["독특하고 개성 있는 디자인을 우선으로 고릅니다.", "기본적인 다양한곳에 어울리는 디자인을 선택합니다."])
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Back 버튼 숨기기
        
        // 배경색 설정
        view.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .darkGray
        navigationItem.backButtonDisplayMode = .minimal
        
        // 프로그래스 바 설정
        progressBar.backgroundColor = .white
        progressBar.layer.borderColor = UIColor.black.cgColor
        progressBar.layer.borderWidth = 1
        progressBar.layer.cornerRadius = 5
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(progressBar)
        
        // 프로그레스 바 초기 제약 조건 설정 (새로 추가)
        progressBarConstraint = progressBarFill.widthAnchor.constraint(equalTo: progressBar.widthAnchor, multiplier: 0)
        progressBarConstraint?.isActive = true
        
        // 프로그래스 바 채우기 설정
        progressBarFill.backgroundColor = .black
        progressBarFill.layer.cornerRadius = 5
        progressBarFill.translatesAutoresizingMaskIntoConstraints = false
        progressBar.addSubview(progressBarFill)
        
        // 진행 상태 레이블 설정
        progressLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        progressLabel.textAlignment = .center
        progressLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(progressLabel)
        
        // 문제 레이블 설정
        questionLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        questionLabel.textAlignment = .center
        questionLabel.numberOfLines = 0
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(questionLabel)
        
        // 옵션 버튼 설정
        option1Button.backgroundColor = .black
        option1Button.setTitleColor(.white, for: .normal)
        option1Button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        option1Button.translatesAutoresizingMaskIntoConstraints = false
        option1Button.addAction(UIAction { [weak self] _ in
            self?.nextQuestion()
        }, for: .touchUpInside)
        view.addSubview(option1Button)
        
        option2Button.backgroundColor = .black
        option2Button.setTitleColor(.white, for: .normal)
        option2Button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        option2Button.translatesAutoresizingMaskIntoConstraints = false
        option2Button.addAction(UIAction { [weak self] _ in
            self?.nextQuestion()
        }, for: .touchUpInside)
        view.addSubview(option2Button)
        
        // Lottie 애니메이션 설정
        lottieView.contentMode = .scaleAspectFit
        lottieView.loopMode = .playOnce
        lottieView.translatesAutoresizingMaskIntoConstraints = false
        lottieView.isHidden = true
        view.addSubview(lottieView)
        
        // 말풍선 이미지 설정
        resultBubbleImageView.contentMode = .scaleAspectFit
        resultBubbleImageView.translatesAutoresizingMaskIntoConstraints = false
        resultBubbleImageView.isHidden = true
        view.addSubview(resultBubbleImageView)
        
        // 다시하기 버튼 설정
        retryButton.setTitle("다시하기", for: .normal)
        retryButton.backgroundColor = .clear
        retryButton.setTitleColor(.black, for: .normal)
        retryButton.layer.cornerRadius = 8
        retryButton.layer.borderWidth = 1
        retryButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        retryButton.translatesAutoresizingMaskIntoConstraints = false
        retryButton.addAction(UIAction { [weak self] _ in
            self?.retryQuiz()
        }, for: .touchUpInside)
        retryButton.isHidden = true
        view.addSubview(retryButton)
        
        // 결과보기 버튼 설정
        resultButton.setTitle("결과보기", for: .normal)
        resultButton.backgroundColor = .black
        resultButton.setTitleColor(.white, for: .normal)
        resultButton.layer.cornerRadius = 8
        resultButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        resultButton.translatesAutoresizingMaskIntoConstraints = false
        resultButton.addAction(UIAction { [weak self] _ in
            self?.showResult()
        }, for: .touchUpInside)
        resultButton.isHidden = true
        view.addSubview(resultButton)
        
        // 오토 레이아웃 설정
        NSLayoutConstraint.activate([
            // 프로그래스 바 제약조건
            progressBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            progressBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            progressBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            progressBar.heightAnchor.constraint(equalToConstant: 10),
            
            // 프로그래스 바 채우기 제약조건
            progressBarFill.topAnchor.constraint(equalTo: progressBar.topAnchor),
            progressBarFill.bottomAnchor.constraint(equalTo: progressBar.bottomAnchor),
            progressBarFill.leadingAnchor.constraint(equalTo: progressBar.leadingAnchor),
            progressBarFill.widthAnchor.constraint(equalToConstant: 0), // 초기 너비는 0으로 설정
            
            // 진행 상태 레이블 제약조건
            progressLabel.topAnchor.constraint(equalTo: progressBar.bottomAnchor, constant: 30),
            progressLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            // 문제 레이블 제약조건
            questionLabel.topAnchor.constraint(equalTo: progressLabel.bottomAnchor, constant: 230),
            questionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            questionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            // 옵션 버튼 제약조건
            option1Button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            option1Button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            option1Button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            option1Button.heightAnchor.constraint(equalToConstant: 50),
            
            option2Button.bottomAnchor.constraint(equalTo: option1Button.topAnchor, constant: -10),
            option2Button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            option2Button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            option2Button.heightAnchor.constraint(equalToConstant: 50),
            
            // Lottie 애니메이션 제약조건
            lottieView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lottieView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            lottieView.widthAnchor.constraint(equalToConstant: 300),
            lottieView.heightAnchor.constraint(equalToConstant: 300),
            
            // 말풍선 이미지 제약조건
            resultBubbleImageView.bottomAnchor.constraint(equalTo: lottieView.topAnchor, constant: 10),
            resultBubbleImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20), // 오른쪽으로 밀리게 설정
            resultBubbleImageView.widthAnchor.constraint(equalToConstant: 300),
            resultBubbleImageView.heightAnchor.constraint(equalToConstant: 200),
            
            // 다시하기 버튼 제약조건
            retryButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            retryButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            retryButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            retryButton.heightAnchor.constraint(equalToConstant: 50),
            
            // 결과보기 버튼 제약조건
            resultButton.bottomAnchor.constraint(equalTo: retryButton.topAnchor, constant: -10),
            resultButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            resultButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            resultButton.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        // 첫 번째 문제 로드
        loadQuestion()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 네비게이션 바 숨기기
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // 다른 화면으로 이동할 때 다시 네비게이션 바 보이기
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    private func loadQuestion() {
        guard currentQuestionIndex < questions.count else {
            // 모든 문제가 끝났을 때 처리 (Lottie 애니메이션과 버튼 표시)
            showCompletionScreen()
            return
        }
        
        let questionData = questions[currentQuestionIndex]
        
        // 행간 조절과 중앙 정렬을 위한 NSMutableParagraphStyle 생성
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 8 // 원하는 행간으로 설정 (예: 8)
        paragraphStyle.alignment = .center // 중앙 정렬 설정

        // NSAttributedString을 사용하여 행간 및 중앙 정렬 적용
        let attributedText = NSAttributedString(
            string: questionData.0,
            attributes: [
                .paragraphStyle: paragraphStyle,
                .font: UIFont.systemFont(ofSize: 18, weight: .regular) // 폰트 속성 추가
            ]
        )
        
        questionLabel.attributedText = attributedText // AttributedString을 사용하여 레이블 설정
        
        option1Button.setTitle(questionData.1[0], for: .normal)
        option2Button.setTitle(questionData.1[1], for: .normal)
        
        updateProgressBar()
        updateProgressLabel()
    }
    
    // 업데이트 프로그레스 바
    private func updateProgressBar() {
        let progress = CGFloat(currentQuestionIndex) / CGFloat(questions.count)
        progressBarConstraint?.isActive = false
        progressBarConstraint = progressBarFill.widthAnchor.constraint(equalTo: progressBar.widthAnchor, multiplier: progress)
        progressBarConstraint?.isActive = true

        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    private func updateProgressLabel() {
        progressLabel.text = "#\(currentQuestionIndex + 1)"
    }
    
    private func nextQuestion() {
        currentQuestionIndex += 1
        if currentQuestionIndex < questions.count {
            loadQuestion()
        } else {
            updateProgressBar() // 마지막 문제에서 프로그레스 바 업데이트
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
                self?.showCompletionScreen()
            }
        }
    }
    
    private func showCompletionScreen() {
        // Lottie 애니메이션과 결과보기, 다시하기 버튼을 보이도록 설정
        lottieView.isHidden = false
        retryButton.isHidden = false
        resultButton.isHidden = false
        resultBubbleImageView.isHidden = false // 말풍선 이미지 표시
        lottieView.play()
        
        // 문제와 버튼 숨기기
        questionLabel.isHidden = true
        option1Button.isHidden = true
        option2Button.isHidden = true
        progressBar.isHidden = true
        progressLabel.isHidden = true
    }
    
    private func retryQuiz() {
        // 퀴즈를 처음부터 다시 시작
        currentQuestionIndex = 0
        loadQuestion()
        
        // Lottie 애니메이션과 버튼 숨기기
        lottieView.isHidden = true
        retryButton.isHidden = true
        resultButton.isHidden = true
        resultBubbleImageView.isHidden = true // 말풍선 이미지 숨기기
        
        // 문제와 버튼을 보이도록 설정
        questionLabel.isHidden = false
        option1Button.isHidden = false
        option2Button.isHidden = false
        progressBar.isHidden = false
        progressLabel.isHidden = false
    }
    
    private func showResult() {
        let testResultViewController = TestResultViewController()
        // 네비게이션을 통해 결과 화면으로 전환
        navigationController?.pushViewController(testResultViewController, animated: true)
    }
}

#Preview {
    TestViewController()
}
