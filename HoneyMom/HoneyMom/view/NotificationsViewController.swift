//
//  NotificationsViewController.swift
//  TabBarByBoss
//
//  Created by kantapong on 6/6/2562 BE.
//  Copyright © 2562 kantapong. All rights reserved.
//

import UIKit

class NotificationsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
         view.backgroundColor = .white
        navigationItem.title = "Profile"
        self.navigationController?.navigationBar.barTintColor = UIColor.colorApp
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.PoppinsMedium(size: 20), NSAttributedString.Key.foregroundColor: UIColor.white]
        // Do any additional setup after loading the view.
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
