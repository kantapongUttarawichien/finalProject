//
//  TableViewCell.swift
//  testtextfield
//
//  Created by kantapong on 5/8/2562 BE.
//  Copyright © 2562 kantapong. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        setupViewCell()
    }
    
    
    let messenger: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 15
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 10
        view.layer.shadowOpacity = 0.2

        return view
    }()
    let sendMessenger: UILabel = {
        let label = UILabel()
        label.text = "wdkocmemvmfi9dkv0ofrvju8rfvfrn8ufokv0fk9ivk0fkv0kfr9v9mfdimv9fmv9imef9vmfrv0ofrvovkfimojpodksgwkdpogpdqmopvmdpomvodiogmopearfohgkpoemibfonfposkg-vkwrknmp[-oDJGOBKERFOPGJKBOWRKDPOGMWrpomgpojrefonoi[[,onu9h9u8y"
        label.textColor = UIColor.black
        label.font = UIFont.PoppinsRegular(size: 14)
        label.numberOfLines = 0
        return label
    }()
    let profile: UIView = {
        let view = UIView()
        view.backgroundColor =  UIColor.white
        view.layer.cornerRadius = 17.5
        return view
    }()
    let profileImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "profile")
        image.contentMode =  .scaleAspectFit
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 17.5
        return image
    }()
    let time: UILabel = {
        let label = UILabel()
        label.text = "13:00"
        label.textColor = .blackAlpha(alpha: 0.3)
        label.font = UIFont.PoppinsRegular(size: 10)//boldSystemFont(ofSize: 10)
        label.numberOfLines = 0
        return label
    }()

    var check = false
    var I : NSLayoutConstraint!
    var II : NSLayoutConstraint!
    var timeI : NSLayoutConstraint!
    var timeII : NSLayoutConstraint!

    var chatessage: Chatessage! {
        didSet{
            messenger.backgroundColor = chatessage.isIncoming ? .white : .colorApp
            sendMessenger.textColor = chatessage.isIncoming ? .black : .white
            sendMessenger.text = chatessage.text
            profileImage.image = UIImage(named: chatessage.profile)
            if chatessage.isIncoming {
                I.isActive = true
                II.isActive = false
                timeI.isActive = true
                timeII.isActive = false
                profile.isHidden = false
               
//                profileI.isActive = true
//                profileII.isActive = false
            }else{
                I.isActive = false
                II.isActive = true
                timeI.isActive = false
                timeII.isActive = true
                profile.isHidden = true
               
//                profileI.isActive = false
//                profileII.isActive = true
            }
           
            
            
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
     
        // Configure the view for the selected state
    }
    
    func setupViewCell(){
        addSubview(messenger)
        addSubview(profile)
        addSubview(time)
        profile.addSubview(profileImage)
        messenger.addSubview(sendMessenger)
      
       
        messenger.anchor(sendMessenger.topAnchor, left: sendMessenger.leftAnchor, bottom: sendMessenger.bottomAnchor, right: sendMessenger.rightAnchor, topConstant: -10, leftConstant: -10, bottomConstant: -10, rightConstant: -10, widthConstant: 0, heightConstant: 0)
        
         profile.anchor(topAnchor, left: leftAnchor, bottom: nil, right: nil, topConstant: 10, leftConstant: 5, bottomConstant: 0, rightConstant: 0, widthConstant: 35 , heightConstant: 35)
//                profileI = profile.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 30)
        profileImage.anchor(profile.topAnchor, left: profile.leftAnchor, bottom: profile.bottomAnchor, right: profile.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        sendMessenger.anchor(topAnchor, left: nil, bottom: bottomAnchor, right: nil, topConstant: 20, leftConstant: 0, bottomConstant: 20, rightConstant: 0 , heightConstant: 0)
        sendMessenger.widthAnchor.constraint(lessThanOrEqualToConstant: 180).isActive = true
        I = sendMessenger.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 60)
        II = sendMessenger.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -20)



        time.anchor(nil, left: nil, bottom: bottomAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 10, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        timeI = time.leftAnchor.constraint(equalTo: messenger.rightAnchor, constant: 10)
        timeII = time.rightAnchor.constraint(equalTo: messenger.leftAnchor, constant: -10)
        
        
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
