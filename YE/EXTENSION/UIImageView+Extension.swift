//
//  UIImageView+Extension.swift
//  YE
//
//  Created by 侯佳男 on 2017/12/11.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    func yy_setResizeImage(urlString: String = "", width: CGFloat) {
        
        if GARegular.match(urlString, "", regularEnum: .html) {
            if let url = URL(string: urlString) {
                let catche = ImageCache(name: urlString)
                if var catcheImage: UIImage = catche.retrieveImageInDiskCache(forKey: urlString) {
                    if catcheImage.size.width > width {
                        let size = CGSize(width: width, height: catcheImage.size.height * (width / catcheImage.size.width))
                        catcheImage = catcheImage.resizeImage(newSize: size)
                    }
                    self.image = catcheImage
                } else {
                    ImageDownloader(name: urlString).downloadImage(with: url, retrieveImageTask: nil, options: nil, progressBlock: nil, completionHandler: { (image, error, url, data) in
                        guard var image: UIImage = image else {
                            return
                        }
                        DispatchQueue.main.async {
                            if image.size.width > width {
                                let size = CGSize(width: width, height: image.size.height * (width / image.size.width))
                                image = image.resizeImage(newSize: size)
                            }
                            self.image = image
                        }
                    })
                }
            }
        } else {
            guard var image = UIImage(named: urlString) else {
                return
            }
            if image.size.width > width {
                let size = CGSize(width: width, height: image.size.height * (width / image.size.width))
                image = image.resizeImage(newSize: size)
            }
            self.image = image
        }
    }
}


extension UIImageView {
    func yy_vidoeImage(url:String) {
        DispatchQueue.global().async {
            let opts = [AVURLAssetPreferPreciseDurationAndTimingKey : false]
            let asset = AVURLAsset(url: URL(string: url)!, options: opts)
            let generator = AVAssetImageGenerator(asset: asset)
            generator.appliesPreferredTrackTransform = true
            var actualTime = CMTimeMake(0,600) //  CMTimeMake(a,b) a/b = 当前秒   a当前第几帧, b每秒钟多少帧
            let time = CMTimeMakeWithSeconds(10, 60) //  CMTimeMakeWithSeconds(a,b) a当前时间,b每秒钟多少帧
            var cgImage: CGImage!
            do{
                cgImage = try generator.copyCGImage(at: time, actualTime: &actualTime)
                DispatchQueue.main.async {
                    self.image = UIImage(cgImage: cgImage)
                }
            }catch let error as NSError{
                print(error)
            }
        }
    }
}
