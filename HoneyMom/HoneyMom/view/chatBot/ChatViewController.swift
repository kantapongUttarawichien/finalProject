//
//  ViewController.swift
//  testApp
//
//  Created by kantapong on 28/10/2562 BE.
//  Copyright © 2562 kantapong. All rights reserved.
//

import UIKit
import ApiAI
import AVFoundation

struct Chatessage {
    let profile: String
    let text: String
    let isIncoming: Bool
    let date: Date
    let time:  String
    let error: Bool
    
}
extension Date {
    static func dateFromCustomString(customString: String) -> Date {
        let dateFormatter = DateFormatter()
               dateFormatter.dateFormat = "dd/MM/yyyy"
               let dateString = dateFormatter.date(from: customString) ?? Date()
               return dateString
    }

}

class ChatViewController: UIViewController , UITableViewDelegate , UITableViewDataSource , UITextFieldDelegate {
   
    var cellId = "Cell"
    var chatMessages = [
        Chatessage(profile: "exercise_mom-3",text: "ไม่เป็นไร", isIncoming: true, date: Date.dateFromCustomString(customString: "24/07/2019"),time:"23:10 PM",error: true),
    Chatessage(profile: "exercise_mom-3",text: "ขอบคุณมาก", isIncoming: false, date: Date.dateFromCustomString(customString: "24/07/2019"),time:"22:55 PM",error: true),
    Chatessage(profile: "exercise_mom-3",text: "ภาวะเบาหวานขณะตั้งครรภ์คือ ความผิด ปกติของระดับน้ําตาลในเลือดที่ตรวจพบ ระดับตั้งครรภ์ เนื่องจากฮอร์โมนที่รกผลิต ออกมามีผลต่อประสิทธิภาพของอินซูลิน หรือ (ฮอร์โมนที่ควบคุมระดับน้ําตาลใน เลือด) ของแม่ ปกติตับอ่อนจะผลิตอินซูลิน ออกมาแต่ในกรณีนี้ตับอ่อนไม่ผลิตอินซูลิน", isIncoming: true, date: Date.dateFromCustomString(customString: "24/07/2019"),time:"22:45 PM",error: true),
    Chatessage(profile: "exercise_mom-3",text: "พึ่งเคยเป็นเบาหวานตอนท้อง ดูแลตัวเองยังไง ดีคะ อันตรายไหมมากไหมคะ?", isIncoming: false, date: Date.dateFromCustomString(customString: "24/07/2019"),time:"22:38 PM",error: true),
    Chatessage(profile: "exercise_mom-3",text: "สวัสดีเราแชทบอท", isIncoming: true, date: Date.dateFromCustomString(customString: "24/07/2019"),time:"22:38 PM",error: true),
    Chatessage(profile: "exercise_mom-3",text: "สวัสดีค่ะ", isIncoming: false, date: Date.dateFromCustomString(customString: "24/07/2019"),time:"22:35 PM",error: true),
   
    Chatessage(profile: "exercise_mom-3",text: "คุณมีอะไรอยากจะพูดกับเราไหม ?", isIncoming: true, date: Date.dateFromCustomString(customString: "14/09/2019"),time:"22:25 PM",error: true),
    Chatessage(profile: "exercise_mom-3",text: "สวัสดี เราคือแชทบอทที่จะช่วยตอบคําถาม ที่คุณอยากรู้ เกี่ยวกับโรคเบาหวานขณะ ตั้งครรภ์ เบื้องต้น", isIncoming: true, date: Date.dateFromCustomString(customString: "14/09/2019"),time:"22:16 PM",error: true)]
    
    //var  Messages = [[Chatessage]]()
    
    lazy var tableview : UITableView = {
         let tableview = UITableView()
         tableview.delegate = self
         tableview.dataSource = self
         tableview.tableFooterView = UIView()
         tableview.showsVerticalScrollIndicator = false
         tableview.backgroundColor = .none//UIColor(white: 0.95, alpha: 1 )
        
         return tableview
     }()
    
    let speechSynthesizer = AVSpeechSynthesizer()
    
    let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "back"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = .colorApp
        button.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
        return button
    }()
    let bg: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "bg01")
        image.contentMode =  .scaleAspectFill
        image.layer.masksToBounds = true
        
        return image
    }()

    let bottom: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.colorApp
        return view
    }()
    let bottomII: UIView = {
          let view = UIView()
          view.backgroundColor = UIColor.colorApp
          return view
      }()
    let boxtest: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 15
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 5
        view.layer.shadowOpacity = 0.2
        return view
    }()
    let test: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "พิมพ์ข้อความของคุณ ที่นี่", attributes: [NSAttributedString.Key.font : UIFont.PoppinsRegular(size: 16), NSAttributedString.Key.foregroundColor: UIColor.blackAlpha(alpha: 0.2)])
        textField.textColor = UIColor.colorApp
        textField.font = UIFont.PoppinsRegular(size: 16)
        textField.leftViewMode = UITextField.ViewMode.always
        
        return textField
    }()
    let send: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "send-1"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = UIColor.white
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        button.addTarget(self, action: #selector(sendTo), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        let back = UIBarButtonItem(image: UIImage(named: "back"), style: .plain, target: self, action: #selector(handleBack))
        back.tintColor = UIColor.white
        navigationItem.leftBarButtonItem = back
        view.backgroundColor = UIColor(white: 1, alpha: 1 )
        //view.backgroundColor = UIColor(patternImage: UIImage(named: "backgound.png")!)
        navigationItem.title = "Chatbot"
        
        self.navigationController?.navigationBar.barTintColor = UIColor.colorApp
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.PoppinsMedium(size: 20), NSAttributedString.Key.foregroundColor: UIColor.white]
        view.addSubview(bg)
        view.addSubview(tableview)
        self.test.delegate = self
        view.addSubview(bottomII)
        view.addSubview(bottom)
      
        bottom.addSubview(boxtest)
        boxtest.addSubview(test)
        bottom.addSubview(send)
        tableview.register(TableViewCell.self, forCellReuseIdentifier: cellId)
        tableview.transform = CGAffineTransform (scaleX: 1,y: -1);
      
        bg.anchor(nil, left: view.leftAnchor, bottom: bottom.topAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 120)
        
        tableview.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: bottom.topAnchor, right: view.safeAreaLayoutGuide.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        bottomII.anchor(nil, left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 50)
        
        bottom.anchor(nil, left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 50)
        
        send.anchor(bottom.topAnchor, left: boxtest.rightAnchor, bottom: nil, right: bottom.safeAreaLayoutGuide.rightAnchor, topConstant: 10, leftConstant: 15, bottomConstant: 0, rightConstant: 15, widthConstant: 30, heightConstant: 30)
                
               boxtest.anchor(bottom.topAnchor, left: bottom.leftAnchor, bottom: nil, right: send.leftAnchor, topConstant: 5, leftConstant: 20, bottomConstant: 0, rightConstant: 15, widthConstant: 0, heightConstant: 40)
        //
                test.anchor(boxtest.topAnchor, left: boxtest.leftAnchor, bottom: nil, right: boxtest.rightAnchor, topConstant: 5, leftConstant: 15, bottomConstant: 0, rightConstant: 15, widthConstant: 0, heightConstant: 30)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        // Do any additional setup after loading the view.
        tableview.separatorStyle = .none
    }
    
    @objc func handleBack(){
        navigationController?.popViewController(animated: true)
      }
    
    func scrollIndexPathToBottom(indexPath: IndexPath) {
      
       tableview.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }

    @objc func sendTo(){
           guard let savesend = test.text else{ return }
        if savesend != "" {
            
            let currentDateTime = Date()
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            
            let request = ApiAI.shared().textRequest()

                request?.query = savesend

            
            request?.setMappedCompletionBlockSuccess({ (request, response) in
                let response = response as! AIResponse
                if let textResponse = response.result.fulfillment.speech {
                self.speechAndText(text: textResponse)
                }
            }, failure: { (request, error) in
                print(error!)
                self.chatMessages.insert(Chatessage.init(profile: "profile",text: "ไม่สามารถส่งข้อความได้", isIncoming: false, date: Date.dateFromCustomString(customString: " "),time: "", error: false), at: 0)
                self.tableview.reloadData()
            })
            self.chatMessages.insert(Chatessage.init(profile: "profile",text: savesend, isIncoming: false, date: Date.dateFromCustomString(customString: " "),time: formatter.string(from: currentDateTime), error: true), at: 0)
            self.tableview.reloadData()
            
            ApiAI.shared().enqueue(request)
           test.text = nil
           
           print(savesend)
        }else{
            
        }
       }
    func speechAndText(text: String) {
        let speechUtterance = AVSpeechUtterance(string: text)
        speechSynthesizer.speak(speechUtterance)
        
        let currentDateTime = Date()
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        
        chatMessages.insert(Chatessage.init(profile: "exercise_mom-3",text: text, isIncoming: true, date: Date.dateFromCustomString(customString: " "),time: formatter.string(from: currentDateTime), error: true), at: 0)
        
        self.tableview.reloadData()
        
//        UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseInOut, animations: {
//            self.chipResponse.text = text
//        }, completion: nil)
        
    }
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return Messages.count
//    }
    class DateHeaderLabel: UILabel {
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            textColor = UIColor.white
           
            backgroundColor = .mediumBlue
            textAlignment = .center
            translatesAutoresizingMaskIntoConstraints = false
                   
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override var intrinsicContentSize: CGSize {
            
            let originalContentSize = super.intrinsicContentSize
            let height = originalContentSize.height + 12
            font = UIFont.boldSystemFont(ofSize: 14)
            layer.cornerRadius = height/2
            layer.masksToBounds = true
            return CGSize(width: originalContentSize.width + 20, height: height)
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatMessages.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)as! TableViewCell
          cell.selectionStyle = .none
        let chatmessage = chatMessages[indexPath.row]
        cell.chatessage = chatmessage
        cell.time.text = "\(chatmessage.time)"
        cell.check = chatmessage.isIncoming
        //cell.profileImage.image = UIImage(named: chatmessage.profile)
        cell.transform = CGAffineTransform(scaleX: 1, y: -1)

        return cell
       }
    @objc func keyboardWillShow(notification: NSNotification) {
           if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
               if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
                    //keyboardSize.height
               }
           }
       }
       
       @objc func keyboardWillHide(notification: NSNotification) {
           if self.view.frame.origin.y != 0 {
               self.view.frame.origin.y = 0
           }
       }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        view.endEditing(true)
    }
//    private override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        view.endEditing(true)
//    }
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//           self.view.endEditing(true)
//           
//       }
       

}

