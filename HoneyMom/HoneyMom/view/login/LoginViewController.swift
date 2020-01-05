//
//  LoginViewController.swift
//  HoneyMom
//
//  Created by kantapong on 2/12/2562 BE.
//  Copyright © 2562 kantapong. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    var emailAdd: Bool = false
    var passwordAdd: Bool = false

    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }

    let honeyTextLabel: UILabel = {
        let label = UILabel()
        label.text = "HONEY \n MOM"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 40)
        label.numberOfLines = 0
        label.textAlignment = .right
        return label
    }()
    let backgroundUiview: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 40
        return view
    }()
    let loginTextLabel: UILabel = {
        let label = UILabel()
        label.text = "LOGIN"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.numberOfLines = 0
        return label
    }()
    let errLabel: UILabel = {
        let label = UILabel()
        label.text = "Error Login"
        label.textColor = .red
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.alpha = 0
        return label
    }()
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .colorApp
        button.layer.cornerRadius = 20
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.whiteAlpha(alpha: 0.7), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.isEnabled = false
        button.addTarget(self, action: #selector(loginaddress), for: .touchUpInside)
        return button
    }()
    let registerLabel: UILabel = {
        let label = UILabel()
        label.text = "สมัครใช้งานที่นี่"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 16)
        //label.backgroundColor = .red
        label.textAlignment =  .right
        label.numberOfLines = 0
        return label
    }()
    let registerButton: UIButton = {
        let button = UIButton(type: .system)
        //button.backgroundColor = .black
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.colorApp, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        button.addTarget(self, action: #selector(registeraddress), for: .touchUpInside)
        return button
    }()
//-----------------------------------------------------------------------------------------------
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "Email Address", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15), NSAttributedString.Key.foregroundColor: UIColor.blackAlpha(alpha: 0.5)])
        textField.textColor = .black
        textField.font = UIFont.boldSystemFont(ofSize: 15)
        textField.keyboardType = .emailAddress
        textField.addTarget(self, action: #selector(handelemailCheckValid), for: .editingChanged)
        return textField
    }()
    let emailTextFieldLine: UIView = {
           let view = UIView()
           view.backgroundColor = UIColor.blackAlpha(alpha: 0.5)
           return view
       }()
    func isValidEmail(email:String) -> Bool {
           let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
           let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
           return emailTest.evaluate(with: email)
       }
    @objc func handelemailCheckValid(){
        guard let email = emailTextField.text else{ return }
        let emailValid = isValidEmail(email: email)
        if emailValid {
            emailAdd = true
        }else {
            emailAdd = false
        }
        checkOnClick()
    }
//-----------------------------------------------------------------------------------------------
    let passwordTextField: UITextField = {
           let textField = UITextField()
           textField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15), NSAttributedString.Key.foregroundColor: UIColor.blackAlpha(alpha: 0.5)])
           textField.textColor = .black
           textField.isSecureTextEntry = true
           textField.font = UIFont.boldSystemFont(ofSize: 15)
           textField.addTarget(self, action: #selector(handlepasswordCheckValid), for: .editingChanged)
           return textField
    }()
    let passwordTextFieldLine: UIView = {
              let view = UIView()
              view.backgroundColor = UIColor.blackAlpha(alpha: 0.5)
              return view
    }()
    let showHidePasswordButton: UIButton = {
         let button = UIButton(type: .system)
         button.setImage(UIImage(named: "hide")?.withRenderingMode(.alwaysTemplate), for: .normal)
         button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = UIColor.blackAlpha(alpha: 0.6)
         button.addTarget(self, action: #selector(handleShowHidePassword), for: .touchUpInside)
         return button
     }()
     @objc func handleShowHidePassword(){
         if passwordTextField.isSecureTextEntry == passwordTextField.isSecureTextEntry {
             passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
         }
     }
    func isValidPassword(password:String) -> Bool {
        let passwordRegEx = "[A-Za-z0-9.-]{1,64}"
        let passwordTest = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        return passwordTest.evaluate(with: password)
    }
    @objc func handlepasswordCheckValid(){
        guard let password = passwordTextField.text else{ return }
        let passwordValid = isValidPassword(password: password)
        let isFormValid = passwordTextField.text?.count ?? 0 > 8
        if passwordValid && isFormValid{
            passwordAdd = true
        }else {
            passwordAdd = false
        }
        checkOnClick()
    }
//-----------------------------------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .colorApp
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
//-----------------------------------------------------------------------------------------------
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
//-----------------------------------------------------------------------------------------------
        let stacView = UIStackView(arrangedSubviews: [emailTextField,passwordTextField])
        stacView.distribution = .fillEqually
        stacView.spacing = 0
        stacView.axis = .vertical
        let stacViewH = UIStackView(arrangedSubviews: [registerLabel,registerButton])
        stacViewH.distribution = .fillEqually
        stacViewH.spacing = 10
        stacViewH.axis = .horizontal
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
//-----------------------------------------------------------------------------------------------
        view.addSubview(honeyTextLabel)
        view.addSubview(backgroundUiview)
        backgroundUiview.addSubview(loginTextLabel)
        backgroundUiview.addSubview(stacView)
        backgroundUiview.addSubview(emailTextFieldLine)
        backgroundUiview.addSubview(passwordTextFieldLine)
        backgroundUiview.addSubview(showHidePasswordButton)
        backgroundUiview.addSubview(errLabel)
        backgroundUiview.addSubview(loginButton)
        backgroundUiview.addSubview(stacViewH)
//-----------------------------------------------------------------------------------------------
        honeyTextLabel.anchor(view.safeAreaLayoutGuide.topAnchor, left: nil, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        honeyTextLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        
        backgroundUiview.anchor(honeyTextLabel.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 40, leftConstant: 0, bottomConstant: -50, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        loginTextLabel.anchor(backgroundUiview.topAnchor, left: nil, bottom: nil, right: nil, topConstant: 20, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        loginTextLabel.centerXAnchor.constraint(equalTo: backgroundUiview.centerXAnchor).isActive = true
        
        stacView.anchor(loginTextLabel.bottomAnchor, left: backgroundUiview.leftAnchor, bottom: nil, right: backgroundUiview.rightAnchor, topConstant: 20, leftConstant: 50, bottomConstant: 0, rightConstant: 50, widthConstant: 0, heightConstant: 150)
        
        emailTextFieldLine.anchor(nil, left: backgroundUiview.leftAnchor, bottom: emailTextField.bottomAnchor, right: backgroundUiview.rightAnchor, topConstant: 0, leftConstant: 50, bottomConstant: 20, rightConstant: 50 , widthConstant: 0, heightConstant: 1.5)

        passwordTextFieldLine.anchor(nil, left: backgroundUiview.leftAnchor, bottom: passwordTextField.bottomAnchor, right: backgroundUiview.rightAnchor, topConstant: 0, leftConstant: 50, bottomConstant: 20, rightConstant: 50 , widthConstant: 0, heightConstant: 1.5)
        
        showHidePasswordButton.anchor(nil, left: nil, bottom: passwordTextFieldLine.topAnchor, right: passwordTextFieldLine.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 8, rightConstant: 10, widthConstant: 24, heightConstant: 24)
        
        errLabel.anchor(stacView.bottomAnchor, left: backgroundUiview.leftAnchor, bottom: nil, right: backgroundUiview.rightAnchor, topConstant: 0, leftConstant: 50, bottomConstant: 0, rightConstant: 50, widthConstant: 0, heightConstant: 0)
        
        loginButton.anchor(errLabel.bottomAnchor, left: backgroundUiview.leftAnchor, bottom: nil, right: backgroundUiview.rightAnchor, topConstant: 15, leftConstant: 60, bottomConstant: 0, rightConstant: 60, widthConstant: 0, heightConstant: 50)
        
         stacViewH.anchor(loginButton.bottomAnchor, left: backgroundUiview.leftAnchor, bottom: nil, right: backgroundUiview.rightAnchor, topConstant: 10, leftConstant: 30, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 30)

    }
    func checkOnClick() {
        if emailAdd == true && passwordAdd == true {
            loginButton.isEnabled = true
            loginButton.setTitleColor(.whiteAlpha(alpha: 1), for: .normal)
        }else{
            loginButton.isEnabled = false
            loginButton.setTitleColor(.whiteAlpha(alpha: 0.7), for: .normal)
        }
    }
    @objc func loginaddress() {
        guard let email = emailTextField.text, let password = passwordTextField.text else{ return }

        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
        //guard let strongSelf = self else { return }
            if error != nil {
                self!.errLabel.text = "The password or email may not be !correct"
                self!.errLabel.alpha = 1
            }
            else {
                self!.view.window?.rootViewController = TabBarController()
                self!.view.window?.makeKeyAndVisible()
            }
        }
    }
    @objc func registeraddress() {
        //present(registerViewController(),animated: true, completion:nil)
        let settingsController = registerViewController()
        navigationController?.pushViewController(settingsController, animated: true)
    }
//-----------------------------------------------------------------------------------------------
    @objc func keyboardWillShow(notification: NSNotification) {
        if self.view.frame.origin.y == 0 {
            self.view.frame.origin.y -= 100
                      //keyboardSize.height
        }
    }
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    
    }
//-----------------------------------------------------------------------------------------------


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
