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
    private let resultBubbleImageView = UIImageView(image: UIImage(named: "resultbubble"))
    
    // 현재 문제 인덱스
    private var currentQuestionIndex = 0
    
    private var progressBarConstraint: NSLayoutConstraint?

    
    // 문제와 선택지 데이터
    private let questions = [
        ("오랜만에 동창들과 약속이 잡혔을 때, 넌 어떻게 준비할 것 같아?", ["존재감 뿜뿜할 수 있는 포인트 아이템 장착!", "괜히 욕심부리지 말자! 평소처럼 코디"]),
        ("친구에게 옷을 선물할 때 어떤 부분을 더 신경 써?", ["친구의 분위기에 딱 어울리는 옷", "언제 어디서든 매치할 수 있는 옷"]),
        ("평소에 입던 스타일이랑 다른 옷을 살 때 넌 어떤 타입이야?", ["주변 사람들한테 살지 말지 물어보고 다녀", "내 취향이면 그냥 바로 사!"]),
        ("너는 옷을 살 때 어디에 더 가까워?", ["전체적인 느낌을 따지는 편", "세부적인 디테일을 따지는 편"]),
        ("오랜만에 외출해서 옷 쇼핑을 하기로 했을 때 넌 어때?", ["미리 뭐 살지 생각하고 가!", "일단 가서 뭘 살지 생각해!"])
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 배경색 설정
        view.backgroundColor = .white
        
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
    
    private func loadQuestion() {
        guard currentQuestionIndex < questions.count else {
            // 모든 문제가 끝났을 때 처리 (Lottie 애니메이션과 버튼 표시)
            showCompletionScreen()
            return
        }
        
        let questionData = questions[currentQuestionIndex]
        questionLabel.text = questionData.0
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
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            window.rootViewController = testResultViewController
            UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: nil, completion: nil)
        }
    }
}

//#Preview {
//    TestViewController()
//}
