//
//  LipsOOTDChatBotViewController.swift
//  OOTD_Team3
//
//  Created by wonhoKim on 8/27/24.
//

//배열에 메세지를 저장해서 시나리오대로 채팅을 치면 테이블뷰로 챗봇이 답장해주는것처럼 구현

import UIKit

class LipsOOTDChatBotViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    // 메시지 구조체  isUSer가false 일경우 챗봇 메세지
    struct Message {
        let text: String
        let isUser: Bool
        let images: [UIImage]?
    }
    //채팅기록 배열에 저장할곳
    var messages: [Message] = []
    // 채팅 시나리오 설정위한 변수
    private var currentStep = 0
    // 헤더 스택뷰로 관리
  
    private lazy var headerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [headerImageView,headerLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
      //  stackView.distribution = .equalCentering
        stackView.spacing = 8
        stackView.alignment = .fill

        return stackView
    }()
    
    private lazy var headerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "message.fill") // 일단 시스템 이미지 사용
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .black // 시스템 이미지의 색상 변경
        imageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        return imageView
    }()
    
    private lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "#OOTD"
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textAlignment = .left
        return label
    }()
    // 구분선
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        return view
    }()
    
    private lazy var chatTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ChatCell.self, forCellReuseIdentifier: "ChatCell")
        return tableView
    }()
    
    private lazy var chatTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .lightGray
        textField.delegate = self
        textField.placeholder = " 채팅을 입력해주세요."
        let sendButton = UIButton()
        sendButton.setImage(UIImage(systemName: "paperplane.fill"), for: .normal)
        sendButton.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        sendButton.widthAnchor.constraint(equalToConstant: 44).isActive = true
        sendButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        
        textField.rightView = sendButton
        textField.rightViewMode = .always
        textField.layer.cornerRadius = 8
        return textField
    }()
    
    
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [headerStackView,separatorView, chatTableView, chatTextField])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 3
        stackView.alignment = .fill
        return stackView
    }()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        messages.append(Message(text: ": 안녕하세요! 티디가 코디를 추천해 드릴게요!", isUser: false, images: nil))
        messages.append(Message(text: ": 코디!, 코디 추천해줘! 라고 말해주세요!", isUser: false, images: nil))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(stackView)
        setUpInterface()
        
    }
    
    func setUpInterface() {
        let safeArea = view.safeAreaLayoutGuide
        let margin: CGFloat = 8.5
        NSLayoutConstraint.activate([
           
            stackView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: margin),
            stackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: margin),
            stackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -margin),
            stackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -margin),
            
            headerLabel.heightAnchor.constraint(equalToConstant: 30),
            separatorView.heightAnchor.constraint(equalToConstant: 1),
            chatTableView.heightAnchor.constraint(equalTo: safeArea.heightAnchor, multiplier: 0.8),
            chatTextField.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatCell
        let message = messages[indexPath.row]
        cell.cellCondition(with: message)
        return cell
    }
    
    //엔터 쳤을때 샌드 메세지 메소드 실행
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        sendMessage(from: textField)
        return true
    }
    
    @objc private func sendButtonTapped() {
        sendMessage(from: chatTextField)
    }
    
    private func sendMessage(from textField: UITextField) {
        if let text = textField.text, !text.isEmpty {
            messages.append(Message(text: "나: \(text)", isUser: true, images: nil))
            textField.text = ""
            chatScenario(for: text)
            chatTableView.reloadData()
            chatTableView.scrollToRow(at: IndexPath(row: messages.count - 1, section: 0), at: .bottom, animated: true)
        }
    }
    
    //시나리오에 따라 챗봇 구현
    private func chatScenario(for text: String) {
        
        switch currentStep {
        case 0:
            if text.lowercased().contains("코디") {
                messages.append(Message(text: ": 오늘 어디를 가나요?", isUser: false, images: nil))
                currentStep += 1
            }
            else {
                
                messages.append(Message(text: ": 이해를 못했어요. 코디, 코디추천해줘 같이 말해주세요.", isUser: false, images: nil))
                //currentStep = 0
            }
        case 1:
            messages.append(Message(text: ": 누구랑 가나요?", isUser: false, images: nil))
            currentStep += 1
        case 2:
            if let image1 = UIImage(named: "gikSik1"),
               let image2 = UIImage(named: "gikSik2"),
               let image3 = UIImage(named: "gikSik3") {
                messages.append(Message(text: ": 스타일을 추천해드릴게요.", isUser: false, images: nil))
                messages.append(Message(text: ": 긱시크 스타일 추천드려요!", isUser: false, images: [image1, image2, image3]))
                messages.append(Message(text: ": 추가해줘 혹은 싫어로 대답해주세요.", isUser: false, images: nil))
                currentStep += 1
            }
        case 3:
            if text == "추가해줘" {
                messages.append(Message(text: ": 추천 스타일에 반영하겠습니다!", isUser: false, images: nil))
                messages.append(Message(text: ": 다시 추천을 원하시면 코디, 코디추천해줘 같이 말해주세요. ", isUser: false, images: nil))
                currentStep = 0
            } else if text == "싫어" {
                messages.append(Message(text: ": 다음에 또 불러주세요!.", isUser: false, images: nil))
                messages.append(Message(text: ": 다시 추천을 원하시면 코디, 코디추천해줘 같이 말해주세요. ", isUser: false, images: nil))
                currentStep = 0
            } else {
                messages.append(Message(text: ": 추가해줘 혹은 싫어요 형식으로 대답해 주세요.", isUser: false, images: nil))
            }
        default:
            break
        }
    }
}

// 테이블 뷰 셀
class ChatCell: UITableViewCell {
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        
        //label.backgroundColor = .red
        return label
    }()
    
    private lazy var characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return imageView
    }()
    
    private lazy var imageStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 0
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        //stackView.backgroundColor = .blue
        //stackView.isHidden = true
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(characterImageView)
        contentView.addSubview(messageLabel)
        contentView.addSubview(imageStackView)
        
        NSLayoutConstraint.activate([
            
            characterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            characterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            characterImageView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -8),
            
            messageLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            //            messageLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            messageLabel.leadingAnchor.constraint(equalTo: characterImageView.trailingAnchor, constant: 8),
            messageLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            imageStackView.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 8),
            imageStackView.leadingAnchor.constraint(equalTo: messageLabel.leadingAnchor),
            imageStackView.trailingAnchor.constraint(equalTo: messageLabel.trailingAnchor),
            imageStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    // 필요하대서넣음
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 조건에 따라 셀 처리
    func cellCondition(with message: LipsOOTDChatBotViewController.Message) {
        messageLabel.text = message.text
        imageStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        //isuser가 true 일경우에 메세지 오른쪽 정렬
        if message.isUser {
            messageLabel.textAlignment = .right
            messageLabel.textColor = .blue
            characterImageView.isHidden = true
        } else {
            messageLabel.textAlignment = .left
            messageLabel.textColor = .black
            characterImageView.isHidden = false
                       
            characterImageView.image = UIImage(named: "chatbot2")
            //messageLabel.text = " : 채팅을 입력해주세오"
            if let images = message.images {
                for image in images {
                    
                    let imageView = UIImageView(image: image)
                    imageView.contentMode = .scaleAspectFit
                    imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
                    imageStackView.addArrangedSubview(imageView)
                }
            }
        }
    }
}
#Preview{
    LipsOOTDChatBotViewController()
}
