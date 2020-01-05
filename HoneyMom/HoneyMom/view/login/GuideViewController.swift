//
//  GuideViewController.swift
//  HoneyMom
//
//  Created by kantapong on 17/12/2562 BE.
//  Copyright © 2562 kantapong. All rights reserved.
//

import UIKit

class GuideViewController: UIViewController , UITextFieldDelegate{
    
    let screenSizeX: CGFloat = UIScreen.main.bounds.width
    let screenSizeY: CGFloat = UIScreen.main.bounds.height
    var effect: UIVisualEffect?
    
    var viewScroll: UIScrollView = {
        let view = UIScrollView()
        return view
    }()
    let stepView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20.0
        view.clipsToBounds = true
        view.layer.maskedCorners = [.layerMinXMinYCorner /*top left corner*/, .layerMaxXMinYCorner /*top right corner*/, .layerMinXMaxYCorner, /* lower left corner*/ .layerMaxXMaxYCorner /*lower right corner*/]
        view.backgroundColor = .red
        //view.layer.cornerRadius = 20
        return view
    }()
    let UIViewArert: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 20
        view.layer.shadowOpacity = 0.2
        return view
    }()
    let EffectUIView: UIVisualEffectView = {
        let View = UIVisualEffectView()
        return View
    }()
    let imgView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        view.layer.cornerRadius = 50
        return view
    }()
    let BGView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        return view
    }()
    let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 20
        button.setTitle("Next", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(play), for: .touchUpInside)
        return button
    }()
    let nameTextField: UITextField = {
            let textField = UITextField()
            textField.attributedPlaceholder = NSAttributedString(string: "Name", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15), NSAttributedString.Key.foregroundColor: UIColor.blackAlpha(alpha: 0.5)])
            textField.textColor = .black
            //textField.addTarget(self, action: #selector(checkOnClick), for: .editingChanged)
            textField.font = UIFont.boldSystemFont(ofSize: 15)
            return textField
        }()
        let nameTextFieldLine: UIView = {
               let view = UIView()
               view.backgroundColor = UIColor.blackAlpha(alpha: 0.5)
               return view
        }()
    //-----------------------------------------------------------------------------------------------
        let emailTextField: UITextField = {
            let textField = UITextField()
            textField.attributedPlaceholder = NSAttributedString(string: "Email Address",attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15), NSAttributedString.Key.foregroundColor: UIColor.blackAlpha(alpha: 0.5)])
            textField.textColor = .black
            //textField.addTarget(self, action: #selector(handelemailCheckValid), for: .editingChanged)
            textField.font = UIFont.boldSystemFont(ofSize: 15)
            textField.keyboardType = .emailAddress
            return textField
        }()
        let emailTextFieldLine: UIView = {
            let view = UIView()
            view.backgroundColor = UIColor.blackAlpha(alpha: 0.5)
            return view
        }()
    //-----------------------------------------------------------------------------------------------
        let passwordTextField: UITextField = {
            let textField = UITextField()
            textField.attributedPlaceholder = NSAttributedString(string: "Password (8 characters)", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 12), NSAttributedString.Key.foregroundColor: UIColor.blackAlpha(alpha: 0.5)])
            textField.textColor = .black
            //textField.addTarget(self, action: #selector(handlepasswordCheckValid), for: .editingChanged)
            textField.isSecureTextEntry = true
            textField.font = UIFont.boldSystemFont(ofSize: 15)
            return textField
        }()
        let passwordTextFieldLine: UIView = {
            let view = UIView()
            view.backgroundColor = UIColor.blackAlpha(alpha: 0.5)
            return view
        }()
       
    //-----------------------------------------------------------------------------------------------
        let confirmPasswordTextField: UITextField = {
            let textField = UITextField()
            textField.attributedPlaceholder = NSAttributedString(string: "Confirm password", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 12), NSAttributedString.Key.foregroundColor: UIColor.blackAlpha(alpha: 0.5)])
            textField.textColor = .black
            //textField.addTarget(self, action: #selector(handleconfirmpasswordCheckValid), for: .editingChanged)
            textField.isSecureTextEntry = true
            textField.font = UIFont.boldSystemFont(ofSize: 15)
            return textField
        }()
        let confirmPasswordTextFieldLine: UIView = {
            let view = UIView()
            view.backgroundColor = UIColor.blackAlpha(alpha: 0.5)
            return view
        }()
    
        
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .gray
        navigationItem.title = "ข้อมูลส่วนตัว"
        
        //effect = visualEffectView.effect
        //visualEffectView.effect = nil
        
        let stacView = UIStackView(arrangedSubviews: [nameTextField,emailTextField,passwordTextField,confirmPasswordTextField])
        stacView.distribution = .fillEqually
        stacView.spacing = 0
        stacView.axis = .vertical
        self.nameTextField.delegate = self
        self.emailTextField.delegate = self
        self.confirmPasswordTextField.delegate = self
        self.passwordTextField.delegate = self
        
        view.addSubview(viewScroll)
        viewScroll.addSubview(stepView)
        viewScroll.addSubview(BGView)
        viewScroll.addSubview(imgView)
        viewScroll.addSubview(stacView)
        viewScroll.addSubview(nextButton)
        viewScroll.addSubview(nameTextFieldLine)
        viewScroll.addSubview(emailTextFieldLine)
        viewScroll.addSubview(passwordTextFieldLine)
        viewScroll.addSubview(confirmPasswordTextFieldLine)
        
        viewScroll.addSubview(UIViewArert)

        
        viewScroll.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        stepView.anchor(viewScroll.topAnchor, left: viewScroll.leftAnchor, bottom: nil, right: viewScroll.rightAnchor, topConstant: 20, leftConstant: 20, bottomConstant: 0, rightConstant: 20, widthConstant: screenSizeX - 40, heightConstant: 150)
        
        imgView.anchor(BGView.topAnchor, left: nil, bottom: nil, right: nil, topConstant: -60, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 100, heightConstant: 100)
         imgView.centerXAnchor.constraint(equalTo: BGView.centerXAnchor).isActive = true
        
        BGView.anchor(stepView.bottomAnchor, left: viewScroll.leftAnchor, bottom: nextButton.topAnchor, right: viewScroll.rightAnchor, topConstant: 100, leftConstant: 20, bottomConstant: 40, rightConstant: 20, widthConstant: screenSizeX - 40, heightConstant: screenSizeY)

        stacView.anchor(BGView.topAnchor, left: BGView.leftAnchor, bottom: BGView.bottomAnchor, right: BGView.rightAnchor, topConstant: 0, leftConstant: 20, bottomConstant: 0, rightConstant: 20, widthConstant: screenSizeX - 100, heightConstant: 300)
        //stacView.widthAnchor.constraint(lessThanOrEqualToConstant: 200).isActive = true
         
         nameTextFieldLine.anchor(nil, left: viewScroll.leftAnchor, bottom: nameTextField.bottomAnchor, right: viewScroll.rightAnchor, topConstant: 0, leftConstant: 40, bottomConstant: 20, rightConstant: 40 , widthConstant: screenSizeX - 140, heightConstant: 1.5)
         
         emailTextFieldLine.anchor(nil, left: viewScroll.leftAnchor, bottom: emailTextField.bottomAnchor, right: viewScroll.rightAnchor, topConstant: 0, leftConstant: 40, bottomConstant: 20, rightConstant: 40 , widthConstant: screenSizeX - 140, heightConstant: 1.5)
         
         passwordTextFieldLine.anchor(nil, left: viewScroll.leftAnchor, bottom: passwordTextField.bottomAnchor, right: viewScroll.rightAnchor, topConstant: 0, leftConstant: 40, bottomConstant: 20, rightConstant: 40 , widthConstant: screenSizeX - 140, heightConstant: 1.5)
         
         confirmPasswordTextFieldLine.anchor(nil, left: viewScroll.leftAnchor, bottom: confirmPasswordTextField.bottomAnchor, right: viewScroll.rightAnchor, topConstant: 0, leftConstant: 40, bottomConstant: 20, rightConstant: 40 , widthConstant: screenSizeX - 140, heightConstant: 1.5)
        
        nextButton.anchor(BGView.bottomAnchor, left: viewScroll.leftAnchor, bottom: viewScroll.bottomAnchor, right: viewScroll.rightAnchor, topConstant: 20, leftConstant: 80, bottomConstant: 20, rightConstant: 80, widthConstant: screenSizeX - 160, heightConstant: 50)
        // Do any additional setup after loading the view.
    }
    @objc func play() {
        animateIn()
    }
    func animateIn() {
            self.view.addSubview(UIViewArert)
            UIViewArert.center = self.view.center
                
            UIViewArert.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            UIViewArert.alpha = 0
            
            UIView.animate(withDuration: 0.5) {
                //self.visualEffectView.effect = self.effect
                self.UIViewArert.alpha = 1
                self.UIViewArert.transform = CGAffineTransform.identity
                
            }
        }
    
        func animateOut() {
            UIView.animate(withDuration: 0.5, animations: {
                self.UIViewArert.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
                self.UIViewArert.alpha = 0
                
               // self.visualEffectView.effect = nil
                
              
            }) { (success:Bool) in
                self.UIViewArert.removeFromSuperview()
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
