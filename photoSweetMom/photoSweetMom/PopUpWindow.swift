//
//  PopUpWindow.swift
//  PopUpWindowByBoss
//
//  Created by kantapong on 2/1/2563 BE.
//  Copyright © 2563 kantapong. All rights reserved.
//

import UIKit

protocol PopUpDelegate {
    
    func handleDismissal()
    
}
class PopUpWindow: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    var delegate: PopUpDelegate?
    
    let iconTree: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "iconPopupTree")
        image.contentMode =  .scaleAspectFit
        image.layer.masksToBounds = true
        return image
    }()
    
    let iconHome: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "iconPopup")
        image.contentMode =  .scaleAspectFit
        image.layer.masksToBounds = true
        return image
    }()
    
    let headUIView: UIView = {
           let view = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 60))
           let gradient = CAGradientLayer()
           view.clipsToBounds = true
           view.layer.maskedCorners = [.layerMinXMinYCorner /*top left corner*/, .layerMaxXMinYCorner /*top right corner*/]
           gradient.frame = view.bounds
           gradient.colors = [UIColor.darkPink.cgColor, UIColor.lightPink.cgColor]
           view.layer.cornerRadius = 8
           gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
           gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
           view.layer.addSublayer(gradient)
           return view
       }()
    let Titlehead: UILabel = {
        let label = UILabel()
        label.text = "food"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()
    
    let TitleTextlabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .darkPink
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
       
    let contentTextlabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.numberOfLines = 0
        label.textColor = .darkPink
        label.textAlignment = .center
        return label
    }()
   let button: UIButton = {
       let button = UIButton(type: .system)
       let gradientLayer = CAGradientLayer()
       button.frame = CGRect(x: 0, y: 0, width: 400, height: 50)
       gradientLayer.frame = button.frame
       gradientLayer.colors = [UIColor.lightPink.cgColor, UIColor.darkPink.cgColor]
       button.layer.insertSublayer(gradientLayer, at: 0)
       button.clipsToBounds = true
       button.layer.cornerRadius = 8
       button.setTitle("Close", for: .normal)
       button.setTitleColor(.white, for: .normal)
       //button.titleLabel?.font = UIFont.Opun(size: 20)
       button.addTarget(self, action: #selector(handleDismissalss), for: .touchUpInside)
       return button
   }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        addSubview(button)
        addSubview(TitleTextlabel)
        addSubview(contentTextlabel)
        addSubview(headUIView)
        addSubview(iconTree)
        addSubview(iconHome)
        headUIView.addSubview(Titlehead)
       
        iconHome.anchor(nil, left: nil, bottom: topAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: -50, widthConstant: 220, heightConstant: 220)
        
        iconTree.anchor(nil, left: leftAnchor, bottom: topAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: -20, rightConstant: 0, widthConstant: 80, heightConstant: 100)
        
        headUIView.anchor(topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 60)
        
        Titlehead.anchor(headUIView.topAnchor, left: nil, bottom: nil, right: nil, topConstant: 20, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        Titlehead.centerXAnchor.constraint(equalTo: headUIView.centerXAnchor).isActive = true
        
        TitleTextlabel.anchor(headUIView.bottomAnchor, left: nil, bottom: nil, right: nil, topConstant: 40, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        TitleTextlabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
               
        contentTextlabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        contentTextlabel.topAnchor.constraint(equalTo: TitleTextlabel.bottomAnchor, constant: 10).isActive = true
        
        button.anchor(nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 40, bottomConstant: 20, rightConstant: 40, widthConstant: 0, heightConstant: 50)
               
    }
    
     @objc func handleDismissalss() {
        
        delegate?.handleDismissal()
        print("44")
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
