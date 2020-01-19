//
//  PreviewViewController.swift
//  photoSweetMom
//
//  Created by kantapong on 19/1/2563 BE.
//  Copyright © 2563 kantapong. All rights reserved.
//

import UIKit

class PreviewViewController: UIViewController { 
    
    var image: UIImage!
    
    let previewImage: UIImageView = {
        let image = UIImageView()
        //image.image = UIImage(named: "")
        image.contentMode =  .scaleAspectFill
        image.layer.masksToBounds = true
        return image
    }()
    
    lazy var popUpWindow: PopUpWindow = {
           let view = PopUpWindow()
           view.translatesAutoresizingMaskIntoConstraints = false
           view.layer.cornerRadius = 8
           view.delegate = self
           return view
       }()
       
       let visualEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
           let view = UIVisualEffectView(effect: blurEffect)
           view.translatesAutoresizingMaskIntoConstraints = false
           return view
       }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        previewImage.image = image

        view.addSubview(previewImage)
        view.addSubview(visualEffectView)
        
        previewImage.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        visualEffectView.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
         
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        view.addSubview(popUpWindow)
        
        popUpWindow.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -40).isActive = true
        popUpWindow.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        popUpWindow.heightAnchor.constraint(equalToConstant: view.frame.width - 64).isActive = true
        popUpWindow.widthAnchor.constraint(equalToConstant: view.frame.width - 64).isActive = true
        
        popUpWindow.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        popUpWindow.alpha = 0
        
        UIView.animate(withDuration: 0.5) {
            self.visualEffectView.alpha = 1
            self.popUpWindow.alpha = 1
            self.popUpWindow.transform = CGAffineTransform.identity
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
extension PreviewViewController: PopUpDelegate {

    func handleDismissal() {
        UIView.animate(withDuration: 0.5, animations: {
            self.visualEffectView.alpha = 0
            self.popUpWindow.alpha = 0
            self.popUpWindow.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        }) { (_) in
            self.popUpWindow.removeFromSuperview()
            print("Did remove pop up window..")
        }
    }
    
    
}
