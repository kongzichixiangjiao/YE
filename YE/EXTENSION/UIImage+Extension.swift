//
//  UIImage+Extension.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/6/5.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit

protocol UIImageSizeProtocol {
    var width: CGFloat! {get}
    var height: CGFloat! {get}
}

extension UIImage: UIImageSizeProtocol {
    var height: CGFloat! {
        get {
            return self.size.height
        }
    }

    var width: CGFloat! {
        get {
            return self.size.width
        }
    }
}

extension UIImage {
    static func yy_init(_ color: UIColor, andFrame frame: CGRect) -> UIImage {
        UIGraphicsBeginImageContext(frame.size)

        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(frame)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return image!
    }
}

extension UIImage {
    ///对指定图片进行拉伸
    func resizableImage(_ name: String) -> UIImage {
        var normal = UIImage(named: name)!
        let imageWidth = normal.size.width * 0.5
        let imageHeight = normal.size.height * 0.5
        normal = resizableImage(withCapInsets: UIEdgeInsetsMake(imageHeight, imageWidth, imageHeight, imageWidth))
        
        return normal
    }
    
    /**
     *  压缩上传图片到指定字节
     *
     *  image     压缩的图片
     *  maxLength 压缩后最大字节大小
     *
     *  return 压缩后图片的二进制
     */
    func compressImage(_ maxLength: Int) -> Data? {
        
        let newSize = self.scaleImage(self, imageLength: 300)
        let newImage = self.resizeImage(newSize: newSize)
        
        var compress:CGFloat = 0.9
        var data = UIImageJPEGRepresentation(newImage, compress)
        
        while data!.count > maxLength && compress > 0.01 {
            compress -= 0.02
            data = UIImageJPEGRepresentation(newImage, compress)
        }
        
        return data
    }
    
    /**
     *  通过指定图片最长边，获得等比例的图片size
     *
     *  image       原始图片
     *  imageLength 图片允许的最长宽度（高度）
     *
     *  return 获得等比例的size
     */
    func scaleImage(_ image: UIImage, imageLength: CGFloat) -> CGSize {
        
        var newWidth:CGFloat = 0.0
        var newHeight:CGFloat = 0.0
        let width = image.size.width
        let height = image.size.height
        
        if (width > imageLength || height > imageLength){
            
            if (width > height) {
                
                newWidth = imageLength;
                newHeight = newWidth * height / width;
                
            }else if(height > width){
                
                newHeight = imageLength;
                newWidth = newHeight * width / height;
                
            }else{
                
                newWidth = imageLength;
                newHeight = imageLength;
            }
            
        }
        return CGSize(width: newWidth, height: newHeight)
    }
    
    /**
     *  获得指定size的图片
     *
     *  image   原始图片
     *  newSize 指定的size
     *  scale 缩放比例 <2 虚
     *
     *  return 调整后的图片
     */
    func resizeImage(newSize: CGSize, scale: CGFloat = 2) -> UIImage {
        UIGraphicsBeginImageContext(newSize)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, scale)
        
        self.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
}

extension UIImage {
    var yy_mainColor: UIColor {
        //获取图片信息
        let imgWidth:Int = Int(self.size.width) / 2
        let imgHeight:Int = Int(self.size.height) / 2
        
        //位图的大小＝图片宽＊图片高＊图片中每点包含的信息量
        let bitmapByteCount = imgWidth * imgHeight * 4
        
        //使用系统的颜色空间
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        //根据位图大小，申请内存空间
        let bitmapData = malloc(bitmapByteCount)
        defer {free(bitmapData)}
        
        //创建一个位图
        let context = CGContext(data: bitmapData,
                                width: imgWidth,
                                height: imgHeight,
                                bitsPerComponent:8,
                                bytesPerRow: imgWidth * 4,
                                space: colorSpace,
                                bitmapInfo:CGImageAlphaInfo.premultipliedLast.rawValue)
        
        //图片的rect
        let rect = CGRect(x:0, y:0, width:CGFloat(imgWidth), height:CGFloat(imgHeight))
        //将图片画到位图中
        context?.draw(self.cgImage!, in: rect)
        
        //获取位图数据
        let bitData = context?.data
        let data = unsafeBitCast(bitData, to:UnsafePointer<CUnsignedChar>.self)
        
        let cls = NSCountedSet.init(capacity: imgWidth * imgHeight)
        for x in 0..<imgWidth {
            for y in 0..<imgHeight {
                let offSet = (y * imgWidth + x) * 4
                let r = (data + offSet).pointee
                let g = (data + offSet+1).pointee
                let b = (data + offSet+2).pointee
                let a = (data + offSet+3).pointee
                if a > 0 {
                    //去除透明
                    if !(r == 255 && g == 255 && b == 255) {
                        //去除白色
                        cls.add([CGFloat(r),CGFloat(g),CGFloat(b),CGFloat(a)])
                    }
                }
            }
        }
        
        //找到出现次数最多的颜色
        let enumerator = cls.objectEnumerator()
        var maxColor:Array<CGFloat>? = nil
        var maxCount = 0
        while let curColor = enumerator.nextObject() {
            let tmpCount = cls.count(for: curColor)
            if tmpCount >= maxCount{
                maxCount = tmpCount
                maxColor = curColor as? Array<CGFloat>
            }
        }
        return UIColor.init(red: (maxColor![0] / 255), green: (maxColor![1] / 255), blue: (maxColor![2] / 255), alpha: (maxColor![3] / 255))
    }
    
}

