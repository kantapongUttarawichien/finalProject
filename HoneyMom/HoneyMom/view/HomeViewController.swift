//
//  HomeViewController.swift
//  TabBarByBoss
//
//  Created by kantapong on 6/6/2562 BE.
//  Copyright © 2562 kantapong. All rights reserved.
//

import UIKit
import Firebase
import CoreML
import Vision


class HomeViewController: UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.navigationController?.navigationBar.barTintColor = UIColor.colorApp
//        // Do any additional setup after loading the view.
//        view.backgroundColor = .white
//        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.PoppinsMedium(size: 20), NSAttributedString.Key.foregroundColor: UIColor.white]
//         navigationItem.title = "เรียนโยคะ"
//
//    }
        
//    let remoteModel = AutoMLRemoteModel(
//        name: "food_20191024333"  // The name you assigned in the Firebase console.
//    )
//


      
     
         let picker = UIImagePickerController()
        
        let showImage: UIImageView = {
            let image = UIImageView()
            image.image = UIImage(named: "")
            image.backgroundColor = .black
            image.contentMode =  .scaleAspectFill
            image.layer.masksToBounds = true
            image.layer.cornerRadius = 20
            return image
        }()
        let showImagetwo: UIImageView = {
            let image = UIImageView()
            image.image = UIImage(named: "")
            image.contentMode =  .scaleAspectFill
            image.layer.masksToBounds = true
            image.layer.cornerRadius = 20
            return image
        }()
        let labelText: UILabel = {
            let label = UILabel()
            label.text = ""
            label.textColor = .emerald
            label.font = UIFont.boldSystemFont(ofSize:  20)
            label.numberOfLines = 0
            label.textAlignment = .center
            return label
        }()
    let labelCalText: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .emerald
        label.font = UIFont.boldSystemFont(ofSize:  20)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
        let sendLibary: UIButton = {
            let button = UIButton(type: .system)
            button.backgroundColor = .emerald
            button.layer.cornerRadius = 20
            button.setTitle("Libary", for: .normal)
            button.setTitleColor(UIColor.white, for: .normal)
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
            button.addTarget(self, action: #selector(openLibary), for: .touchUpInside)
            return button
        }()
        override func viewDidLoad() {
            super.viewDidLoad()
            
            
             self.navigationController?.navigationBar.barTintColor = UIColor.colorApp
                    // Do any additional setup after loading the view.
                    view.backgroundColor = .white
                    navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.PoppinsMedium(size: 20), NSAttributedString.Key.foregroundColor: UIColor.white]
                     navigationItem.title = "เรียนโยคะ"

            view.backgroundColor = .white
            view.addSubview(showImage)
            view.addSubview(sendLibary)
            view.addSubview(labelText)
            view.addSubview(labelCalText)
            picker.delegate = self
            showImage.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 100, leftConstant: 20, bottomConstant: 0, rightConstant: 20, widthConstant: 200, heightConstant: 200)
            
            sendLibary.anchor(nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 100, bottomConstant: 20, rightConstant: 100, widthConstant: 0, heightConstant: 40)
            labelText.anchor(showImage.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 20, leftConstant: 40, bottomConstant: 0, rightConstant: 40, widthConstant: 0, heightConstant: 0)
            
            labelCalText.anchor(labelText.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 10, leftConstant: 40, bottomConstant: 0, rightConstant: 40, widthConstant: 0, heightConstant: 0)
            // Do any additional setup after loading the view.
            
            
            
            
//           let downloadConditions = ModelDownloadConditions(
//             allowsCellularAccess: true,
//             allowsBackgroundDownloading: true
//           )
//
//           let downloadProgress = ModelManager.modelManager().download(
//             remoteModel,
//             conditions: downloadConditions
//           )
            
        }
        override func viewWillAppear(_ animated: Bool) {
            
           
        }
        @objc func openLibary()  {
        
      
            picker.sourceType = .photoLibrary
                  present(picker, animated: true, completion: nil)
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
    extension HomeViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info:[UIImagePickerController.InfoKey : Any]){
            if let image = info[.originalImage] as? UIImage {
                self.showImage.image = image
                
              
                let image = VisionImage(image: showImage.image!)
                
                gg(Ui: image)
       
             dismiss(animated: true)

                 // Recognized text
               }
               
            }
        func gg(Ui: VisionImage)  {
                
                 guard let manifestPath = Bundle.main.path(
                      forResource: "manifest",
                      ofType: "json",
                      inDirectory: "food_20191024333"
                  ) else { return  }
                  let localModel = AutoMLLocalModel(manifestPath: manifestPath)
                  
                  
                  let options = VisionOnDeviceAutoMLImageLabelerOptions(localModel: localModel)
                  options.confidenceThreshold = 0  // Evaluate your model in the Firebase console
                                                   // to determine an appropriate value.
                  let labeler = Vision.vision().onDeviceAutoMLImageLabeler(options: options)
            

                        labeler.process(Ui) { labels, error in
                            guard error == nil, let labels = labels else { return }

                            for label in labels {
                                
                                
                                self.labelText.text = "\(label.text)"//\(label.confidence)
                                //print(label.text)
                                if self.labelText.text == label.text {
                                    self.labelCalText.text = "557 กิโลแคลอรี่"
                                } else {
                                     self.labelText.text = "ข้าวผัด"
                                     self.labelCalText.text = "557 กิโลแคลอรี่"
                                }
            //                    let confidence = label.confidence
                            }
                           
                        }
                 
                    
        }
      
        
}
