//
//  registerViewController.swift
//  HoneyMom
//
//  Created by kantapong on 3/12/2562 BE.
//  Copyright © 2562 kantapong. All rights reserved.
//

import UIKit


class registerViewController: UIViewController, UITextFieldDelegate {

    let screenSize: CGFloat = UIScreen.main.bounds.width
    var nameAdd: Bool = false
    var emailAdd: Bool = false
    var passwordAdd: Bool = false
    var confirmPasswordAdd: Bool = false

    let backgroundUiview: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 40
        return view
    }()
    let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "back"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = .colorApp
        button.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
        return button
    }()
    let registerTextLabel: UILabel = {
        let label = UILabel()
        label.text = "REGISTER"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.numberOfLines = 0
        return label
    }()
    var viewScroll: UIScrollView = {
        let view = UIScrollView()
        return view
    }()
    let nextButton: UIButton = {
           let button = UIButton(type: .system)
           button.backgroundColor = .colorApp
           button.layer.cornerRadius = 20
           button.setTitle("Next", for: .normal)
        button.setTitleColor(.whiteAlpha(alpha: 0.7), for: .normal)
           button.isEnabled = false
           button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
           button.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
           return button
       }()
//-----------------------------------------------------------------------------------------------
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "Name", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15), NSAttributedString.Key.foregroundColor: UIColor.blackAlpha(alpha: 0.5)])
        textField.textColor = .black
        textField.addTarget(self, action: #selector(checkOnClick), for: .editingChanged)
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
        textField.addTarget(self, action: #selector(handelemailCheckValid), for: .editingChanged)
        textField.font = UIFont.boldSystemFont(ofSize: 15)
        textField.keyboardType = .emailAddress
        return textField
    }()
    let emailTextFieldLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.blackAlpha(alpha: 0.5)
        return view
    }()
    let emailCheckValid: UIImageView = {
           let image = UIImageView()
           image.image = UIImage(named: "ball_chat_icon")?.withRenderingMode(.alwaysTemplate)
           image.contentMode = .scaleAspectFit
           image.layer.masksToBounds = true
           image.tintColor = UIColor.whiteAlpha(alpha: 0.5)
           return image
       }()
    func isValidEmail(email:String) -> Bool {
           let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
           
           let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
           return emailTest.evaluate(with: email)
       }
    @objc func handelemailCheckValid(){
        //
        guard let email = emailTextField.text else{ return }
        
        let emailValid = isValidEmail(email: email)
        
        emailCheckValid.isHidden = false
        
        if emailValid {
            emailCheckValid.tintColor = UIColor.rgb(red: 69, green: 219, blue: 96)
            emailAdd = true
        }else {
            emailCheckValid.tintColor = UIColor.rgb(red: 243, green: 48, blue: 73)
            emailAdd = false
        }
        checkOnClick()
    }
//-----------------------------------------------------------------------------------------------
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "Password (8 characters)", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 12), NSAttributedString.Key.foregroundColor: UIColor.blackAlpha(alpha: 0.5)])
        textField.textColor = .black
        textField.addTarget(self, action: #selector(handlepasswordCheckValid), for: .editingChanged)
        textField.isSecureTextEntry = true
        textField.font = UIFont.boldSystemFont(ofSize: 15)
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
    let passwordCheckValid: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "ball_chat_icon")?.withRenderingMode(.alwaysTemplate)
        image.contentMode = .scaleAspectFit
        image.layer.masksToBounds = true
        image.tintColor = UIColor.whiteAlpha(alpha: 0)
        return image
    }()
    func isValidPassword(password:String) -> Bool {
        let passwordRegEx = "[A-Za-z0-9.-]{1,64}"
        let passwordTest = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        return passwordTest.evaluate(with: password)
    }
    @objc func handlepasswordCheckValid(){
        //
        guard let password = passwordTextField.text else{ return }
        
        let passwordValid = isValidPassword(password: password)
        let isFormValid = passwordTextField.text?.count ?? 0 > 8
        passwordCheckValid.isHidden = false
        if confirmPasswordTextField.text != ""  {
            if confirmPasswordTextField.text == passwordTextField.text {
                passwordCheckValid.tintColor = UIColor.rgb(red: 69, green: 219, blue: 96)
                passwordAdd = true
                confirmPasswordCheckValid.tintColor = UIColor.rgb(red: 69, green: 219, blue: 96)
                confirmPasswordAdd = true
            }else {
                passwordCheckValid.tintColor = UIColor.rgb(red: 243, green: 48, blue: 73)
                passwordAdd = false
                confirmPasswordCheckValid.tintColor = UIColor.rgb(red: 243, green: 48, blue: 73)
                confirmPasswordAdd = false
            }
        }else {
            if passwordValid && isFormValid {
                passwordCheckValid.tintColor = UIColor.rgb(red: 69, green: 219, blue: 96)
                passwordAdd = true
            }else {
                passwordCheckValid.tintColor = UIColor.rgb(red: 243, green: 48, blue: 73)
                passwordAdd = false
            }
        }
        checkOnClick()
    }
//-----------------------------------------------------------------------------------------------
    let confirmPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "Confirm password", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 12), NSAttributedString.Key.foregroundColor: UIColor.blackAlpha(alpha: 0.5)])
        textField.textColor = .black
        textField.addTarget(self, action: #selector(handleconfirmpasswordCheckValid), for: .editingChanged)
        textField.isSecureTextEntry = true
        textField.font = UIFont.boldSystemFont(ofSize: 15)
        return textField
    }()
    let confirmPasswordTextFieldLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.blackAlpha(alpha: 0.5)
        return view
    }()
    let showHideconfirmPasswordButton: UIButton = {
         let button = UIButton(type: .system)
         button.setImage(UIImage(named: "hide")?.withRenderingMode(.alwaysTemplate), for: .normal)
         button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = UIColor.blackAlpha(alpha: 0.6)
         button.addTarget(self, action: #selector(handleShowHideconfirmPassword), for: .touchUpInside)
         return button
     }()
     @objc func handleShowHideconfirmPassword(){
         if confirmPasswordTextField.isSecureTextEntry == confirmPasswordTextField.isSecureTextEntry {
             confirmPasswordTextField.isSecureTextEntry = !confirmPasswordTextField.isSecureTextEntry
         }
     }
    let confirmPasswordCheckValid: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "ball_chat_icon")?.withRenderingMode(.alwaysTemplate)
        image.contentMode = .scaleAspectFit
        image.layer.masksToBounds = true
        image.tintColor = UIColor.whiteAlpha(alpha: 0)
        return image
    }()
    func isValidconfirmPassword(password:String) -> Bool {
        let passwordRegEx = "[A-Za-z0-9.-]{1,64}"
        let passwordTest = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        return passwordTest.evaluate(with: password)
    }
    @objc func handleconfirmpasswordCheckValid(){
        //
        guard let password = confirmPasswordTextField.text else{ return }
        
        let passwordValid = isValidPassword(password: password)
        let isFormValid = confirmPasswordTextField.text?.count ?? 0 > 8
        confirmPasswordCheckValid.isHidden = false
        if passwordValid && isFormValid && confirmPasswordTextField.text == passwordTextField.text{
            confirmPasswordCheckValid.tintColor = UIColor.rgb(red: 69, green: 219, blue: 96)
            confirmPasswordAdd = true
            
        }else {
            confirmPasswordCheckValid.tintColor = UIColor.rgb(red: 243, green: 48, blue: 73)
            confirmPasswordAdd = false
        }
        checkOnClick()
    }
//-----------------------------------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .colorApp
        navigationItem.hidesBackButton = true
        
//-----------------------------------------------------------------------------------------------
       let stacView = UIStackView(arrangedSubviews: [nameTextField,emailTextField,passwordTextField,confirmPasswordTextField])
        stacView.distribution = .fillEqually
        stacView.spacing = 0
        stacView.axis = .vertical
        self.nameTextField.delegate = self
        self.emailTextField.delegate = self
        self.confirmPasswordTextField.delegate = self
        self.passwordTextField.delegate = self
//-----------------------------------------------------------------------------------------------
        view.addSubview(backgroundUiview)
        backgroundUiview.addSubview(backButton)
        backgroundUiview.addSubview(registerTextLabel)
        backgroundUiview.addSubview(viewScroll)
        viewScroll.addSubview(stacView)
        viewScroll.addSubview(nameTextFieldLine)
        viewScroll.addSubview(emailTextFieldLine)
        viewScroll.addSubview(emailCheckValid)
        viewScroll.addSubview(passwordTextFieldLine)
        viewScroll.addSubview(passwordCheckValid)
        viewScroll.addSubview(showHidePasswordButton)
        viewScroll.addSubview(confirmPasswordTextFieldLine)
        viewScroll.addSubview(confirmPasswordCheckValid)
        viewScroll.addSubview(showHideconfirmPasswordButton)
        viewScroll.addSubview(nextButton)
//-----------------------------------------------------------------------------------------------
        backgroundUiview.anchor(view.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, topConstant: 60, leftConstant: 0, bottomConstant: -50, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        backButton.anchor(backgroundUiview.topAnchor, left: backgroundUiview.leftAnchor, bottom: nil, right: nil, topConstant: 30, leftConstant: 20, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        registerTextLabel.anchor(backgroundUiview.topAnchor, left: nil, bottom: nil, right: nil, topConstant: 25, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        registerTextLabel.centerXAnchor.constraint(equalTo: backgroundUiview.centerXAnchor).isActive = true
        
        viewScroll.anchor(registerTextLabel.bottomAnchor, left: backgroundUiview.leftAnchor, bottom: backgroundUiview.bottomAnchor, right: backgroundUiview.rightAnchor, topConstant: 10, leftConstant: 50, bottomConstant: 0, rightConstant: 50, widthConstant: screenSize - 100, heightConstant: 0)
        
        stacView.anchor(viewScroll.topAnchor, left: viewScroll.leftAnchor, bottom: nextButton.topAnchor, right: viewScroll.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 40, rightConstant: 0, widthConstant: screenSize - 100, heightConstant: 300)
       //stacView.widthAnchor.constraint(lessThanOrEqualToConstant: 200).isActive = true
        
        nameTextFieldLine.anchor(nil, left: viewScroll.leftAnchor, bottom: nameTextField.bottomAnchor, right: viewScroll.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 20, rightConstant: 0 , widthConstant: 0, heightConstant: 1.5)
        
        emailTextFieldLine.anchor(nil, left: viewScroll.leftAnchor, bottom: emailTextField.bottomAnchor, right: viewScroll.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 20, rightConstant: 0 , widthConstant: 0, heightConstant: 1.5)
        
        emailCheckValid.anchor(nil, left: nil, bottom: emailTextFieldLine.topAnchor, right: emailTextFieldLine.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 10, rightConstant: 10, widthConstant: 15, heightConstant: 15)
        
        passwordTextFieldLine.anchor(nil, left: viewScroll.leftAnchor, bottom: passwordTextField.bottomAnchor, right: viewScroll.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 20, rightConstant: 0 , widthConstant: 0, heightConstant: 1.5)
        
        passwordCheckValid.anchor(nil, left: nil, bottom: passwordTextFieldLine.topAnchor, right: showHidePasswordButton.leftAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 10, rightConstant: 10, widthConstant: 15, heightConstant: 15)
        
        showHidePasswordButton.anchor(nil, left: nil, bottom: passwordTextFieldLine.topAnchor, right: passwordTextFieldLine.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 8, rightConstant: 10, widthConstant: 24, heightConstant: 24)
        
        confirmPasswordTextFieldLine.anchor(nil, left: viewScroll.leftAnchor, bottom: confirmPasswordTextField.bottomAnchor, right: viewScroll.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 20, rightConstant: 0 , widthConstant: 0, heightConstant: 1.5)
        
        confirmPasswordCheckValid.anchor(nil, left: nil, bottom: confirmPasswordTextFieldLine.topAnchor, right: showHideconfirmPasswordButton.leftAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 10, rightConstant: 10, widthConstant: 15, heightConstant: 15)
        
        showHideconfirmPasswordButton.anchor(nil, left: nil, bottom: confirmPasswordTextFieldLine.topAnchor, right: confirmPasswordTextFieldLine.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 8, rightConstant: 10, widthConstant: 24, heightConstant: 24)
        
       nextButton.anchor(stacView.bottomAnchor, left: viewScroll.leftAnchor, bottom: viewScroll.bottomAnchor, right: viewScroll.rightAnchor, topConstant: 40, leftConstant: 10, bottomConstant: 80, rightConstant: 10, widthConstant: 0, heightConstant: 50)
        // Do any additional setup after loading the view.
    }
//-----------------------------------------------------------------------------------------------
    @objc func handleBack(){
        navigationController?.popViewController(animated: true)
      }
    @objc func checkOnClick() {
        guard let name = nameTextField.text, let email = emailTextField.text, let password = passwordTextField.text, let confirmpassword = confirmPasswordTextField.text  else{ return }
        if name != "" {
             nameAdd = true
        }else{
             nameAdd = false
        }
        if email != "" && emailAdd == true {
             emailAdd = true
        }else{
             emailAdd = false
        }
        if password != "" {
             passwordAdd = true
        }else{
             passwordAdd = false
        }
        if confirmpassword != "" && confirmPasswordAdd == true {
             confirmPasswordAdd = true
        }else{
             confirmPasswordAdd = false
        }
        if nameAdd == true && emailAdd == true && passwordAdd == true && confirmPasswordAdd == true {
            nextButton.isEnabled = true
            nextButton.setTitleColor(.whiteAlpha(alpha: 1), for: .normal)
        }else{
            nextButton.isEnabled = false
            nextButton.setTitleColor(.whiteAlpha(alpha: 0.7), for: .normal)
        }
    }
    @objc func handleNext(){
        guard let name = nameTextField.text, let email = emailTextField.text, let password = passwordTextField.text, let confirmpassword = confirmPasswordTextField.text  else{ return }
        let bioViewControlle = BioViewController()
        bioViewControlle.nameRegister = name
        bioViewControlle.emailRegister = email
        bioViewControlle.passRegister = password
        bioViewControlle.conpassRegister = confirmpassword
        navigationController?.pushViewController(bioViewControlle,animated: true)
      }
//-----------------------------------------------------------------------------------------------
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        viewScroll.setContentOffset(view.frame.origin, animated: true)
    }

    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        var point = textField.frame.origin
        point.y = point.y - 5
        viewScroll.setContentOffset(point, animated: true)
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
