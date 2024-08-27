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
        
     
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

