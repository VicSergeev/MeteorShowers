//
//  SceneDelegate.swift
//  MeteorShowers
//
//  Created by Vic on 26.01.2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        // MARK: - since we don't use storyboards - this must be implemented
        guard let customWindowScene = (scene as? UIWindowScene) else { return }
        
        // Restore reminders when app launches
        RemindersManager.shared.restoreAllReminders()
        
        // custom window since we don't use Storyboards
        window = UIWindow(frame: customWindowScene.coordinateSpace.bounds)
        window?.windowScene = customWindowScene
        
        // root VC
        let mainViewController = MainViewController()
        
        // assigning root vc to nav
        let navigationController = UINavigationController(rootViewController: mainViewController)
        window?.rootViewController = navigationController
        
        // configuring nav title
        let titleColor: UIColor = .lightMidnight1
        navigationController.navigationBar.largeTitleTextAttributes = [
            .foregroundColor: titleColor
        ]
        navigationController.navigationBar.titleTextAttributes = [
            .foregroundColor: titleColor
        ]
        navigationController.navigationBar.prefersLargeTitles = true
        
        // setting title to nav via mainVC
        mainViewController.title = "Meteor Showers"
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
