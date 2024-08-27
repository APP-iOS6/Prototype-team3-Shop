//
//  SceneDelegate.swift
//  OOTD_Team3
//
//  Created by wonhoKim on 8/27/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
       
        // 반복문 돌리려다 다같이 할거면 따로 만드는게 보기 좋을거 같아서 분리해서 만들었는데, 네이밍을 대충 지은거 같아서 변경필요하면 알려주세요
        let homeViewController = HomeViewController()
        homeViewController.tabBarItem = UITabBarItem(title: "홈", image: UIImage(systemName: "house"), tag: 0)
        
        let ootdViewController = OOTDViewController()
        ootdViewController.tabBarItem = UITabBarItem(title: "오오티디", image: UIImage(systemName: "number"), tag: 1)
        
        let closetViewController = ClosetViewController()
        closetViewController.tabBarItem = UITabBarItem(title: "옷장", image: UIImage(systemName: "hanger"), tag: 2)
        
        let myViewController = MyViewController()
        myViewController.tabBarItem = UITabBarItem(title: "마이", image: UIImage(systemName: "person"), tag: 3)
        
       
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [homeViewController, ootdViewController, closetViewController, myViewController]
        
        let logoViewController = LogoViewController()
                logoViewController.modalPresentationStyle = .fullScreen
     
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = logoViewController
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {

    }

    func sceneDidBecomeActive(_ scene: UIScene) {

    }

    func sceneWillResignActive(_ scene: UIScene) {

    }

    func sceneWillEnterForeground(_ scene: UIScene) {

    }

    func sceneDidEnterBackground(_ scene: UIScene) {

    }


}

