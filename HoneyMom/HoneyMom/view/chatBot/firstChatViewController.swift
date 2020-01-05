//
//  firstChatViewController.swift
//  HoneyMom
//
//  Created by kantapong on 11/12/2562 BE.
//  Copyright © 2562 kantapong. All rights reserved.
//

import UIKit

class firstChatViewController: UIViewController {
    
    let testBG: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "backgound")
        image.contentMode =  .scaleAspectFill
        image.layer.masksToBounds = true
        return image
    }()

    let nextPage: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .colorApp
        button.layer.cornerRadius = 25
        button.setTitle("เริ่มแชทกับบอท", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        return button
    }()
//-----------------------------------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Chatbot"
        self.navigationController?.navigationBar.barTintColor = UIColor.colorApp
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.PoppinsMedium(size: 20), NSAttributedString.Key.foregroundColor: UIColor.white]
//-----------------------------------------------------------------------------------------------
        view.addSubview(testBG)
        view.addSubview(nextPage)
//-----------------------------------------------------------------------------------------------
        testBG.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        nextPage.anchor(nil, left: testBG.leftAnchor, bottom: testBG.bottomAnchor, right: testBG.rightAnchor, topConstant: 0, leftConstant: 60, bottomConstant: 40, rightConstant: 60, widthConstant: 0, heightConstant: 50)
        // Do any additional setup after loading the view.
    }
    @objc func handleNext(){
        let settingsController = ChatViewController()
        settingsController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(settingsController, animated: true)
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
