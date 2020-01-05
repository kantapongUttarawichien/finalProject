//
//  BioViewController.swift
//  HoneyMom
//
//  Created by kantapong on 3/12/2562 BE.
//  Copyright © 2562 kantapong. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class BioViewController: UIViewController, UITextFieldDelegate {
    
    let screenSize: CGFloat = UIScreen.main.bounds.width
    var nameRegister: String?
    var emailRegister: String?
    var passRegister: String?
    var conpassRegister: String?
    var ageAdd: Bool = false
    var heightAdd: Bool = false
    var weightdAdd: Bool = false
    var bloodsugarAdd: Bool = false
               
    
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
        label.text = "BIO"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.numberOfLines = 0
        return label
    }()
    var viewScroll: UIScrollView = {
        let view = UIScrollView()
        return view
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
    let doneButton: UIButton = {
           let button = UIButton(type: .system)
           button.backgroundColor = .colorApp
           button.layer.cornerRadius = 20
           button.setTitle("Done", for: .normal)
           button.isEnabled = false
           button.setTitleColor(.whiteAlpha(alpha: 0.7), for: .normal)
           button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
           button.addTarget(self, action: #selector(handleDone), for: .touchUpInside)
           return button
       }()
//-----------------------------------------------------------------------------------------------
    let ageTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "Age", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15), NSAttributedString.Key.foregroundColor: UIColor.blackAlpha(alpha: 0.5)])
        textField.textColor = .black
        textField.addTarget(self, action: #selector(checkOnClick), for: .editingChanged)
        textField.keyboardType = .numberPad
        textField.font = UIFont.boldSystemFont(ofSize: 15)
        return textField
    }()
    let ageTextFieldLine: UIView = {
           let view = UIView()
           view.backgroundColor = UIColor.blackAlpha(alpha: 0.5)
           return view
    }()
//-----------------------------------------------------------------------------------------------
    let heightTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "Height",attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15), NSAttributedString.Key.foregroundColor: UIColor.blackAlpha(alpha: 0.5)])
        textField.textColor = .black
        textField.addTarget(self, action: #selector(checkOnClick), for: .editingChanged)
        textField.keyboardType = .numberPad
        textField.font = UIFont.boldSystemFont(ofSize: 15)
        return textField
    }()
    let heightTextFieldLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.blackAlpha(alpha: 0.5)
        return view
    }()
//-----------------------------------------------------------------------------------------------
    let weightTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "Weight", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15), NSAttributedString.Key.foregroundColor: UIColor.blackAlpha(alpha: 0.5)])
        textField.textColor = .black
        textField.addTarget(self, action: #selector(checkOnClick), for: .editingChanged)
        textField.keyboardType = .numberPad
        textField.font = UIFont.boldSystemFont(ofSize: 15)
        return textField
    }()
    let weightTextFieldLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.blackAlpha(alpha: 0.5)
        return view
    }()
//-----------------------------------------------------------------------------------------------
    let bloodsugarTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "Blood sugar", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15), NSAttributedString.Key.foregroundColor: UIColor.blackAlpha(alpha: 0.5)])
        textField.textColor = .black
        textField.addTarget(self, action: #selector(checkOnClick), for: .editingChanged)
        textField.keyboardType = .numberPad
        textField.font = UIFont.boldSystemFont(ofSize: 15)
        return textField
    }()
    let bloodsugarTextFieldLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.blackAlpha(alpha: 0.5)
        return view
    }()
//-----------------------------------------------------------------------------------------------
    let congenitaldiseaseTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "Congenital disease", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15), NSAttributedString.Key.foregroundColor: UIColor.blackAlpha(alpha: 0.5)])
        textField.textColor = .black
        textField.font = UIFont.boldSystemFont(ofSize: 15)
        return textField
    }()
    let congenitaldiseaseTextFieldLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.blackAlpha(alpha: 0.5)
        return view
    }()
    override func viewWillAppear(_ animated: Bool) {

    }
//-----------------------------------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .colorApp
        navigationItem.hidesBackButton = true
        print(nameRegister!)
        print(emailRegister!)
        print(passRegister!)
        print(conpassRegister!)
//-----------------------------------------------------------------------------------------------
       let stacView = UIStackView(arrangedSubviews: [ageTextField,heightTextField,weightTextField,bloodsugarTextField,congenitaldiseaseTextField])
        stacView.distribution = .fillEqually
        stacView.spacing = 0
        stacView.backgroundColor = .yellow
        stacView.axis = .vertical
        self.ageTextField.delegate = self
        self.heightTextField.delegate = self
        self.weightTextField.delegate = self
        self.bloodsugarTextField.delegate = self
        self.congenitaldiseaseTextField.delegate = self
//-----------------------------------------------------------------------------------------------
        view.addSubview(backgroundUiview)
        backgroundUiview.addSubview(backButton)
        backgroundUiview.addSubview(registerTextLabel)
        backgroundUiview.addSubview(viewScroll)
        viewScroll.addSubview(stacView)
        viewScroll.addSubview(ageTextFieldLine)
        viewScroll.addSubview(heightTextFieldLine)
        viewScroll.addSubview(weightTextFieldLine)
        viewScroll.addSubview(bloodsugarTextFieldLine)
        viewScroll.addSubview(congenitaldiseaseTextFieldLine)
        viewScroll.addSubview(errLabel)
        viewScroll.addSubview(doneButton)
//-----------------------------------------------------------------------------------------------
        backgroundUiview.anchor(view.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, topConstant: 60, leftConstant: 0, bottomConstant: -50, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        backButton.anchor(backgroundUiview.topAnchor, left: backgroundUiview.leftAnchor, bottom: nil, right: nil, topConstant: 30, leftConstant: 20, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        registerTextLabel.anchor(backgroundUiview.topAnchor, left: nil, bottom: nil, right: nil, topConstant: 25, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        registerTextLabel.centerXAnchor.constraint(equalTo: backgroundUiview.centerXAnchor).isActive = true
        
        viewScroll.anchor(registerTextLabel.bottomAnchor, left: backgroundUiview.leftAnchor, bottom: backgroundUiview.bottomAnchor, right: backgroundUiview.rightAnchor, topConstant: 10, leftConstant: 50, bottomConstant: 0, rightConstant: 50, widthConstant: screenSize - 100, heightConstant: 0)
        
        stacView.anchor(viewScroll.topAnchor, left: viewScroll.leftAnchor, bottom: errLabel.topAnchor, right: viewScroll.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: screenSize - 100, heightConstant: 375)
       //stacView.widthAnchor.constraint(lessThanOrEqualToConstant: 200).isActive = true
        
        ageTextFieldLine.anchor(nil, left: viewScroll.leftAnchor, bottom: ageTextField.bottomAnchor, right: viewScroll.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 20, rightConstant: 0 , widthConstant: 0, heightConstant: 1.5)
        
        heightTextFieldLine.anchor(nil, left: viewScroll.leftAnchor, bottom: heightTextField.bottomAnchor, right: viewScroll.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 20, rightConstant: 0 , widthConstant: 0, heightConstant: 1.5)
        
        weightTextFieldLine.anchor(nil, left: viewScroll.leftAnchor, bottom: weightTextField.bottomAnchor, right: viewScroll.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 20, rightConstant: 0 , widthConstant: 0, heightConstant: 1.5)
        
        bloodsugarTextFieldLine.anchor(nil, left: viewScroll.leftAnchor, bottom: bloodsugarTextField.bottomAnchor, right: viewScroll.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 20, rightConstant: 0 , widthConstant: 0, heightConstant: 1.5)
        
        congenitaldiseaseTextFieldLine.anchor(nil, left: viewScroll.leftAnchor, bottom: congenitaldiseaseTextField.bottomAnchor, right: viewScroll.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 20, rightConstant: 0 , widthConstant: 0, heightConstant: 1.5)
        
        errLabel.anchor(stacView.bottomAnchor, left: viewScroll.leftAnchor, bottom: nil, right: viewScroll.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        doneButton.anchor(errLabel.bottomAnchor, left: viewScroll.leftAnchor, bottom: viewScroll.bottomAnchor, right: viewScroll.rightAnchor, topConstant: 30, leftConstant: 10, bottomConstant: 80, rightConstant: 10, widthConstant: 0, heightConstant: 50)
        // Do any additional setup after loading the view.
    }
    @objc func handleBack(){
        navigationController?.popViewController(animated: true)
      }
    @objc func checkOnClick() {
        guard let age = ageTextField.text, let height = heightTextField.text, let weight = weightTextField.text, let bloodsugar = bloodsugarTextField.text else{ return }
        if age != "" {
             ageAdd = true
        }else{
             ageAdd = false
        }
        if height != "" {
             heightAdd = true
        }else{
             heightAdd = false
        }
        if weight != "" {
             weightdAdd = true
        }else{
             weightdAdd = false
        }
        if bloodsugar != "" {
             bloodsugarAdd = true
        }else{
             bloodsugarAdd = false
        }
        if ageAdd == true && heightAdd == true && weightdAdd == true && bloodsugarAdd == true {
            doneButton.isEnabled = true
            doneButton.setTitleColor(.whiteAlpha(alpha: 1), for: .normal)
        }else{
            doneButton.isEnabled = false
            doneButton.setTitleColor(.whiteAlpha(alpha: 0.7), for: .normal)
        }
    }
    @objc func handleDone(){
        guard let age = ageTextField.text, let height = heightTextField.text, let weight =  weightTextField.text, let bloodsugar = bloodsugarTextField.text, let congenitaldisease = congenitaldiseaseTextField.text else{ return }
       
//        FirebaseService.signupnewusers(email: emailRegister!, password: passRegister!, name: name, height: height, weight: weight, bloodsugar: bloodsugar, congenitaldisease: congenitaldisease)
        Auth.auth().createUser(withEmail: emailRegister!, password: passRegister!) { authResult, err in
            if err != nil {
                self.errLabel.text = err!.localizedDescription
                self.errLabel.alpha = 1
                // There was an error creating the user
                //self.showError("Error creating user")
            }else {
                let db = Firestore.firestore()
                db.collection("users").addDocument(data: ["name" : self.nameRegister!,"age" : age,"height" : height,"weight" : weight,"bloodsugar" : bloodsugar,"congenitaldisease" : congenitaldisease,"uid" : authResult!.user.uid]) {(error) in
                    if error != nil {
                    // Show error message
                    //self.showError("Error saving user data")
                    self.errLabel.text = error!.localizedDescription
                    self.errLabel.alpha = 1
                    }else {
                        self.view.window?.rootViewController = TabBarController()
                        self.view.window?.makeKeyAndVisible()
                    }
                }
            }
        }
    }
//-----------------------------------------------------------------------------------------------
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        viewScroll.setContentOffset(view.frame.origin, animated: true)
    }
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        var point = textField.frame.origin
        point.y = point.y - 20
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

