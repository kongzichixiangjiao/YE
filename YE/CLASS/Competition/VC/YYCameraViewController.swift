//
//  YYCameraViewController.swift
//  YE
//
//  Created by 侯佳男 on 2018/3/2.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit

class YYCameraViewController: YYBaseViewController {

    var session: AVCaptureSession!
    var captureOutput: AVCaptureStillImageOutput!
    var device: AVCaptureDevice!
    
    var input: AVCaptureDeviceInput!
    var output: AVCaptureMetadataOutput!
    var preview: AVCaptureVideoPreviewLayer!
    
    var timer: Timer!
    
    var dataSource: [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNeedsStatusBarAppearanceUpdate()
        
        initCameraMain()
        initTopView()
        initDownView()
    }
    
    let photoSize = (MainScreenWidth - 60) / 5
    lazy var collectionView: UICollectionView = {
        let flow = UICollectionViewFlowLayout()
        flow.minimumInteritemSpacing = 10
        flow.minimumLineSpacing = 10
        flow.itemSize = CGSize(width: photoSize, height: photoSize)
        flow.scrollDirection = .horizontal
        let c = UICollectionView(frame: CGRect(x: 10, y: 10, width: MainScreenWidth - 20, height: photoSize), collectionViewLayout: flow)
        c.register(UINib(nibName: YYCameraCell.identifier, bundle: nil), forCellWithReuseIdentifier: YYCameraCell.identifier)
        c.backgroundColor = UIColor.lightGray
        c.delegate = self
        c.dataSource = self
        c.isUserInteractionEnabled = true
        self.downView.addSubview(c)
        return c
    }()
    
    lazy var downView: UIView = {
       let v = UIView(frame: CGRect(x: 0, y: MainScreenHeight - 64 - self.photoSize - 20, width: MainScreenWidth, height: 64 + photoSize + 20))
        v.backgroundColor = UIColor.black
        self.view.addSubview(v)
        return v
    }()
    
    func initDownView() {
        let cancleBtn = UIButton(frame: CGRect(x: 30, y: photoSize + 37, width: 50, height: 30))
        cancleBtn.setTitle("取消", for: .normal)
        cancleBtn.setTitleColor(UIColor.white, for: .normal)
        cancleBtn.addTarget(self, action: #selector(cancle), for: .touchUpInside)
        downView.addSubview(cancleBtn)
        
        let doneBtn = UIButton(frame: CGRect(x: MainScreenWidth - 80, y: photoSize + 37, width: 50, height: 30))
        doneBtn.setTitle("完成", for: .normal)
        doneBtn.setTitleColor(UIColor.white, for: .normal)
        doneBtn.addTarget(self, action: #selector(done), for: .touchUpInside)
        downView.addSubview(doneBtn)
        
        let x = (downView.frame.size.width - 50) / 2;
        let takePhotoBtn = UIButton(frame: CGRect(x: x, y: photoSize + 27, width: 50, height: 50))
        takePhotoBtn.setImage(UIImage(named: "take_photo_pic.png"), for: .normal)
        takePhotoBtn.addTarget(self, action: #selector(takePhoto), for: .touchDown)
        takePhotoBtn.addTarget(self, action: #selector(takePhotoFinished), for: .touchUpInside)
        downView.addSubview(takePhotoBtn)
    }
    
    @objc func takePhoto() {
        timer = Timer(timeInterval: 0.3, target: self, selector: #selector(tackCamsender), userInfo: nil, repeats: true)
        RunLoop.main.add(timer, forMode: .commonModes)
    }
    
    @objc func tackCamsender() {
        print("2")
        captureImage()
    }
    
    @objc func takePhotoFinished() {
        timer.invalidate()
    }
    
    deinit {
        
    }
    
    @objc func cancle() {
        popRoot()
    }
    
    @objc func done() {
        
    }
    
    func initTopView() {
        let topView = UIView(frame: CGRect(x: 0, y: 0, width: MainScreenWidth, height: 44))
        topView.backgroundColor = UIColor.black
        topView.alpha = 0.7;
        self.view.addSubview(topView)
        
        let flashBtn = UIButton(frame: CGRect(x: 10, y: 7, width: 30, height: 30))
        if device.flashMode.rawValue == 0 {
            flashBtn.setImage(UIImage(named: "flash_close_pic.png"), for: .normal)
        } else if device.flashMode.rawValue == 1 {
            flashBtn.setImage(UIImage(named: "flash_open_pic.png"), for: .normal)
        }
        flashBtn.addTarget(self, action: #selector(flashOfCamera(sender:)), for: .touchUpInside)
        topView.addSubview(flashBtn)
        
        let changeBtn = UIButton(frame: CGRect(x: MainScreenWidth - 40, y: 7, width: 30, height: 30))
        changeBtn.setImage(UIImage(named: "change_camera_pic.png"), for: .normal)
        changeBtn.addTarget(self, action: #selector(changeCameraDevice(sender:)), for: .touchUpInside)
        topView.addSubview(changeBtn)
    }
    
    @objc func flashOfCamera(sender: UIButton) {
        if (device.flashMode.rawValue == 0) {
            setupFlash(sender: sender, falshMode: .on, imgNamed: "flash_open_pic.png")
        } else if (device.flashMode.rawValue == 1) {
            setupFlash(sender: sender, falshMode: .off, imgNamed: "flash_close_pic.png")
        } else {
            
        }
    }
    
    func setupFlash(sender: UIButton, falshMode: AVCaptureDevice.FlashMode, imgNamed: String) {
        session.beginConfiguration()
        try! device.lockForConfiguration()
        device.flashMode = falshMode
        device.unlockForConfiguration()
        session.commitConfiguration()
        session.startRunning()
        sender.setImage(UIImage(named: imgNamed), for: .normal)
    }
    
    @objc func changeCameraDevice(sender: UIButton) {
        let inputs = session.inputs
        for input in inputs {
            let device = (input as! AVCaptureDeviceInput).device
            if (device.hasMediaType(.video)) {
                let position = device.position
                var newCamera: AVCaptureDevice!

                newCamera = cameraWithPosition(position: position == .front ? .back : .front)
                
                let newInput = try! AVCaptureDeviceInput.init(device: newCamera)
                session.beginConfiguration()
                session.removeInput(input)
                session.addInput(newInput)
                session.commitConfiguration()
            }
        }
    }
    
    func cameraWithPosition(position: AVCaptureDevice.Position) -> AVCaptureDevice? {
        let devices = AVCaptureDevice.devices(for: .video)
        for device in devices {
            if (device.position == position) {
                return device
            }
        }
        return nil
    }
    
    func initCameraMain() {
        device = AVCaptureDevice.default(for: .video)
        
        do {
            input = try AVCaptureDeviceInput(device: device)
        } catch {
            print(" -- input error")
        }
        
        captureOutput = AVCaptureStillImageOutput()
        captureOutput.outputSettings = [AVVideoCodecKey : AVVideoCodecJPEG]
        
        session = AVCaptureSession()
        session.canSetSessionPreset(.high)
        if (session.canAddInput(input)) {
            session.addInput(input)
        }
        if (session.canAddOutput(captureOutput)) {
            session.addOutput(captureOutput)
        }
        
        preview = AVCaptureVideoPreviewLayer(session: session)
        preview.videoGravity = AVLayerVideoGravity.resizeAspectFill
        preview.frame = self.view.bounds
        
        self.view.layer .insertSublayer(preview, at: 0)
        
        self.session.startRunning()
        
        initCameraFocusView()
    }
    
    func initCameraFocusView() {
        
    }
    
    func captureImage() {
        var videoConnection: AVCaptureConnection? = nil
        
        for connection in captureOutput.connections {
            for port in connection.inputPorts {
                if (port.mediaType == AVMediaType.video) {
                    videoConnection = connection
                }
            }
        }

        captureOutput.captureStillImageAsynchronously(from: videoConnection!) {
            [weak self] imgBuffer, error in
            if let weakSelf = self {
                let imgData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(imgBuffer!)
                var img = UIImage(data: imgData!)
                img = weakSelf.fixOrientation(img: img!)
                
                UIImageWriteToSavedPhotosAlbum(img!, self, #selector(weakSelf.imageSavedToPhotosAlbum(img:error:contextInfo:)), nil)
                
                // 处理img
                weakSelf.dataSource.append(img!)
                weakSelf.collectionView.reloadData()
            }
        }
    }
    
    @objc func imageSavedToPhotosAlbum(img: UIImage, error: Error, contextInfo: Any) {
        
    }

    func fixOrientation(img: UIImage) -> UIImage {
        if(img.imageOrientation == .up)  {
            return img
        }
        
        let w: CGFloat = img.size.width
        let h: CGFloat = img.size.height
        
        var transform = CGAffineTransform.identity
        switch img.imageOrientation {
        case .down, .downMirrored:
            transform = CGAffineTransform(translationX: w, y: h)
            transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
            break
        case .left, .leftMirrored:
            transform = CGAffineTransform(translationX: w, y: 0)
            transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi / 2))
            break
        case .right, .rightMirrored:
            transform = CGAffineTransform(translationX: 0, y: h)
            transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi / 2))
            break
        case .up, .upMirrored:
            break
            
        }
        switch img.imageOrientation {
        case .downMirrored:
            transform = CGAffineTransform(translationX: w, y: 0)
            transform = CGAffineTransform(scaleX: -1, y: 1)
            break
        case .leftMirrored:
            transform = CGAffineTransform(translationX: h, y: 0)
            transform = CGAffineTransform(scaleX: -1, y: 1)
            break
        case .right, .rightMirrored: break
        case .up, .upMirrored: break
        case .down: break
        case .left:
            break
        }
        
//        let context = CGContext(data: nil , width: Int(w), height: Int(h), bitsPerComponent: img.cgImage!.bitsPerComponent, bytesPerRow: 0, space: img.cgImage!.colorSpace!, bitmapInfo: img.cgImage!.bitmapInfo.rawValue)
//
//        context!.concatenate(transform)
//        switch img.imageOrientation {
//        case .right, .rightMirrored, .left, .leftMirrored:
//            context!.draw(img.cgImage!, in: CGRect(x: 0, y: 0, width: h, height: w))
//            break
//        default:
//            context!.draw(img.cgImage!, in: CGRect(x: 0, y: 0, width: w, height: h))
//            break
//        }
//
//        let cgImg = context!.makeImage()
//        let img = UIImage(cgImage: cgImg!)
        return img
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

extension YYCameraViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: YYCameraCell.identifier, for: indexPath) as! YYCameraCell
        cell.imgView.image = dataSource[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
}
