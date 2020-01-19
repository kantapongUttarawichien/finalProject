//
//  PhotoViewController.swift
//  photoSweetMom
//
//  Created by kantapong on 19/1/2563 BE.
//  Copyright © 2563 kantapong. All rights reserved.
//

import UIKit
import AVFoundation

class PhotoViewController: UIViewController {
    let model = Food101()
    let Preview = PreviewViewController()
    
    
//    let captureButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.backgroundColor = .white
//        button.layer.cornerRadius = 25
//        button.addTarget(self, action: #selector(cameraButtonTouch), for: .touchUpInside)
//        return button
//    }()
//    let <#imageView#>: UIImageView = {
//        let image = UIImageView()
//        image.image = UIImage(named: <#T##String#>)
//        image.contentMode = <# scaleAspect #>
//        image.layer.masksToBounds = true
//        image.layer.cornerRadius = <# Number #>
//        return image
//    }()

    let captureButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 0
        button.setImage(#imageLiteral(resourceName: "iconCapture"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        //button.tintColor = .red
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        button.addTarget(self, action: #selector(cameraButtonTouch), for: .touchUpInside)
        return button
    }()
    
    var captureSession = AVCaptureSession()
    var backCamera: AVCaptureDevice?
    var frontCamera: AVCaptureDevice?
    var currentCamera: AVCaptureDevice?
    var photoOutput: AVCapturePhotoOutput?
    var cameraPreviewLayer: AVCaptureVideoPreviewLayer?
    var image:UIImage?
       
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(captureButton)
        
        captureButton.anchor(nil, left: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 20, rightConstant: 0, widthConstant: 50, heightConstant: 50)
        captureButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        setupCaptureSession()
        setupDevice()
        setupInputOutput()
        setupPreviewLayer()
        startRunningCaptureSession()

        // Do any additional setup after loading the view.
    }
    @objc func cameraButtonTouch() {
        let settings = AVCapturePhotoSettings()
        photoOutput?.capturePhoto(with: settings, delegate: self)
//        Preview.image = self.image
//        present(Preview, animated: true, completion: nil)
    }
    
    func setupCaptureSession() {
           captureSession.sessionPreset = AVCaptureSession.Preset.photo
       }
       
    func setupDevice() {
           let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera], mediaType: AVMediaType.video, position: AVCaptureDevice.Position.unspecified)
           let devices = deviceDiscoverySession.devices
           
           for device in devices{
               if device.position == AVCaptureDevice.Position.back {
                   backCamera = device
               }else if device.position == AVCaptureDevice.Position.front{
                   frontCamera = device
               }
           }
           
           currentCamera = backCamera
       }

    func setupInputOutput() {
           do {
               let captureDeviceInput = try AVCaptureDeviceInput(device: currentCamera!)
               captureSession.addInput(captureDeviceInput)
               photoOutput = AVCapturePhotoOutput()
               photoOutput?.setPreparedPhotoSettingsArray([AVCapturePhotoSettings(format:[AVVideoCodecKey: AVVideoCodecType.jpeg])], completionHandler: nil)
               captureSession.addOutput(photoOutput!)
           } catch {
               print(error)
           }
       }
       
       func setupPreviewLayer() {
           cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
           cameraPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
           cameraPreviewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
           cameraPreviewLayer?.frame = self.view.frame
           self.view.layer.insertSublayer(cameraPreviewLayer!, at: 0)
       }
       
       func startRunningCaptureSession() {
           captureSession.startRunning()
       }
       
       override var prefersStatusBarHidden: Bool {
           return true
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
extension PhotoViewController: AVCapturePhotoCaptureDelegate{
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let imageData = photo.fileDataRepresentation(){
            image = UIImage(data: imageData)
            Preview.image = self.image
           present(Preview, animated: true, completion: nil)
            //UIImageWriteToSavedPhotosAlbum(self.image!, nil, nil, nil)
            //performSegue(withIdentifier: "showPhotos", sender: nil)
        }
    }
}
