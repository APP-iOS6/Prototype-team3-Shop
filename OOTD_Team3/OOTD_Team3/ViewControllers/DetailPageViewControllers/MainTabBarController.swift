//
//  MainTabBarController.swift
//  OOTD_Team3
//
//  Created by wonhoKim on 8/28/24.

import UIKit
import Lottie

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    //버튼 티디로 하면 귀여울거같아요
    
    private lazy var chatFloatingButton: UIButton = {
        let button = UIButton(type: .custom)
        //button.setTitle("CHAT", for: .normal)
        button.backgroundColor = .clear
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 25
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(floatingButtonTapped), for: .touchUpInside)
        
        let animationView = createLottie()
        
        button.addSubview(animationView)
        NSLayoutConstraint.activate([
            animationView.centerXAnchor.constraint(equalTo: button.centerXAnchor),
            animationView.centerYAnchor.constraint(equalTo: button.centerYAnchor),
            animationView.widthAnchor.constraint(equalTo: button.widthAnchor, multiplier: 1),
            animationView.heightAnchor.constraint(equalTo: button.heightAnchor, multiplier: 1)
            
        ])
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        button.addGestureRecognizer(panGesture)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBar()
        setUpInterFace()
        delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        chatFloatingButton.isHidden = true
    }
    
    
    
    private func createLottie() -> LottieAnimationView {
        let animationView = LottieAnimationView(name: "cat")
        animationView.contentMode = .scaleAspectFit
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.loopMode = .loop
        animationView.play()
        animationView.isUserInteractionEnabled = false
        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalToConstant: 110),
            animationView.heightAnchor.constraint(equalToConstant: 110)
        ])
        
        return animationView
    }
    
    func setUpInterFace(){
        view.addSubview(chatFloatingButton)
        NSLayoutConstraint.activate([
            chatFloatingButton.widthAnchor.constraint(equalToConstant: 80),
            chatFloatingButton.heightAnchor.constraint(equalToConstant: 85),
            chatFloatingButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            chatFloatingButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -60)
        ])
        view.bringSubviewToFront(chatFloatingButton)
    }
    
    private func setupTabBar() {
        let homeViewController = HomeViewController()
        homeViewController.tabBarItem = UITabBarItem(title: "홈", image: UIImage(systemName: "house"), tag: 0)
        
        let ootdViewController = OOTDViewController()
        ootdViewController.tabBarItem = UITabBarItem(title: "오오티디", image: UIImage(systemName: "number"), tag: 1)
        
        let closetViewController = ClosetViewController()
        closetViewController.tabBarItem = UITabBarItem(title: "옷장", image: UIImage(systemName: "hanger"), tag: 2)
        
        let myViewController = MyViewController()
        myViewController.tabBarItem = UITabBarItem(title: "마이", image: UIImage(systemName: "person"), tag: 3)
        
        viewControllers = [homeViewController, ootdViewController, closetViewController, myViewController]
    }
    
    @objc private func handlePan(_ gesture: UIPanGestureRecognizer) {
            guard let button = gesture.view else { return }
            let translation = gesture.translation(in: view)
            if gesture.state == .began || gesture.state == .changed {
                UIView.animate(withDuration: 0.1) {
                    button.center = CGPoint(x: button.center.x + translation.x, y: button.center.y + translation.y)
                }
                gesture.setTranslation(.zero, in: view)
            }
        }
    
    @objc private func floatingButtonTapped() {
        
        print("버튼 눌림")
        let sheetViewController = LipsOOTDChatBotViewController()
        
        if let sheet = sheetViewController.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.prefersGrabberVisible = true
        }
        
        present(sheetViewController, animated: true, completion: nil)
        
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if viewController is HomeViewController {
            chatFloatingButton.isHidden = true
        } else {
            chatFloatingButton.isHidden = false
        }
    }
}




#Preview{
    MainTabBarController()
}
