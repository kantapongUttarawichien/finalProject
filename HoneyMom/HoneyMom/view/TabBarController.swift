//
//  TabBarController.swift
//  TabBarByBoss
//
//  Created by kantapong on 6/6/2562 BE.
//  Copyright © 2562 kantapong. All rights reserved.
//

import UIKit
import Firebase


class TabBarController: UITabBarController,UITabBarControllerDelegate {
    
    private var handle: AuthStateDidChangeListenerHandle?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.delegate = self
        tabBar.tintColor = .colorApp
        tabBar.barTintColor = .white
        tabBar.isTranslucent = false
        
        setUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if Auth.auth().currentUser != nil {
          // User is signed in.
                self.setUI()
            } else {
          // No user is signed in.
                self.view.window?.rootViewController = UINavigationController(rootViewController: LoginViewController())
                self.view.window?.makeKeyAndVisible()
            }
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Auth.auth().removeStateDidChangeListener(handle!)
    }
    fileprivate func tabBarNavigation(unselectedImage: UIImage?, selectdImage: UIImage?, badgeValue: String?, rootViewController: UIViewController = UIViewController()) -> UINavigationController {
        let navController = UINavigationController(rootViewController: rootViewController)
        
        navController.tabBarItem.image = unselectedImage
        navController.tabBarItem.selectedImage = selectdImage
        navController.tabBarItem.imageInsets = UIEdgeInsets(top: 0, left: 8, bottom: -20, right: 8)
        navController.tabBarItem.badgeColor = .red
        navController.tabBarItem.badgeValue = badgeValue
        return navController
        
    }
    func setUI() {
        let homeController = self.tabBarNavigation(unselectedImage: UIImage(named: "01-icon"), selectdImage: UIImage(named: "01-icon"), badgeValue: "4", rootViewController: HomeViewController())
               
        let chatViewController = self.tabBarNavigation(unselectedImage: #imageLiteral(resourceName: "02-icon"), selectdImage: #imageLiteral(resourceName: "02-icon"), badgeValue: nil, rootViewController: firstChatViewController())
               
        let notificationsController = self.tabBarNavigation(unselectedImage: #imageLiteral(resourceName: "03-icon"), selectdImage: #imageLiteral(resourceName: "03-icon"), badgeValue: nil, rootViewController: NotificationsViewController())
               
        let settingsController = self.tabBarNavigation(unselectedImage: #imageLiteral(resourceName: "04-icon"), selectdImage: #imageLiteral(resourceName: "04-icon"), badgeValue: nil, rootViewController: SettingsViewController())
         
        self.viewControllers = [homeController,chatViewController,notificationsController,settingsController]
    }
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//         do {
//              try Auth.auth().signOut()
//              self.view.window?.rootViewController = UINavigationController(rootViewController: LoginViewController())
//              self.view.window?.makeKeyAndVisible()
//          } catch let error {
//              print("Failed to sign out with error..", error)
//          }
//
//      }


}

