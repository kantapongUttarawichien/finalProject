//
//  SettingsViewController.swift
//  TabBarByBoss
//
//  Created by kantapong on 6/6/2562 BE.
//  Copyright © 2562 kantapong. All rights reserved.
//

import UIKit
import Firebase

class SettingsViewController: UIViewController {
    
    let logout: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .colorApp
        button.layer.cornerRadius = 20
        button.setTitle("Logout", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(logoutView), for: .touchUpInside)
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
         view.backgroundColor = .white
          self.navigationController?.navigationBar.barTintColor = UIColor.colorApp
        navigationItem.title = "Home"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.PoppinsMedium(size: 20), NSAttributedString.Key.foregroundColor: UIColor.white]
        
        view.addSubview(logout)
        
        logout.anchor(nil, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 40, bottomConstant: 40, rightConstant: 40, widthConstant: 0, heightConstant: 0)
        // Do any additional setup after loading the view.
    }
    @objc func logoutView() {
         do {
                      try Auth.auth().signOut()
                      self.view.window?.rootViewController = UINavigationController(rootViewController: LoginViewController())
                      self.view.window?.makeKeyAndVisible()
                  } catch let error {
                      print("Failed to sign out with error..", error)
                  }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
