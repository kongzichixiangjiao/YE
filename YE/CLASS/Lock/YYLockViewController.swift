//
//  YYLockViewController.swift
//  YE
//
//  Created by 侯佳男 on 2018/1/31.
//  Copyright © 2018年 侯佳男. All rights reserved.
//  锁是最常用的同步工具
//  1、操作线程外的变量

import UIKit
import WebKit

class YYLockViewController: YYBaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myTitle = "Lock"
        
        
//        let webView = WKWebView(frame: self.view.bounds)
//        let url = Bundle.main.url(forResource: "home", withExtension: "html")
//        let request = URLRequest(url: url!)
//        webView.load(request)
        
        let webView = YYWebView(frame: self.view.bounds, url: "", fileName: "home")
        webView.backgroundColor = UIColor.lightGray
        self.view.addSubview(webView)
        
//        lock()
//        testLock()
    }
    
    func testLock() {
        // 1、操作线程外的变量
        DispatchQueue.global().async {
            self.operation()
        }
    }
    
    func operation() {
        // 操作imgs
        // 如果imgs线程外的变量，并且操作这个变量，此时需要加锁。
    }
    
    func lock() {
        semaphoreLock()
        
        huChiLock()
        
        condition()
        
        recursive()
    }
    
    // 信号量锁
    func semaphoreLock() {
        // 信号量和group
        // 各组执行完才会执行notify
        // 使用信号量 当异步延迟执行完才执行notify
        // 如果没有信号量控制 6的打印就是正常延迟3秒后执行
        let queue = DispatchQueue.global(qos: .default)
        let group = DispatchGroup()
        let sem = DispatchSemaphore(value: 0)
        queue.async(group: group, execute: {
            print(1)
            // Double(Int64(3 * 1000 * 1000000)) / Double(NSEC_PER_SEC)
            queue.asyncAfter(deadline: DispatchTime.now() + Double(Int64(3 * 1000 * 1000000)) / Double(NSEC_PER_SEC), execute: {
                sem.wait()
                print(6)
            })
            
            sem.signal()
        })
        queue.async(group: group, execute: {
            print(2)
        })
        queue.async(group: group, execute: {
            print(3)
        })
        group.notify(queue: queue, execute: {
            print(5)
        })
        
    }
    
    // 互斥锁
    func huChiLock() {
        var lock = pthread_mutex_t()
        
        for i in 0...2 {
            pthread_mutex_lock(&lock)
            
            // 要加锁的代码
            print(i)
            
            pthread_mutex_unlock(&lock)
        }
    }
    
    // 条件锁
    func condition() {
        // 001
        let lock = NSCondition()
        //002
//        let lock = NSConditionLock(condition: 1)
        
        for i in 0...2 {
            lock.lock()
            print(i)
            lock.unlock()
        }
    }
    
    // 递归锁
    func recursive() {
        let lock = NSRecursiveLock()
        for i in 0...2 {
            lock.lock()
            print(i)
            lock.unlock()
        }
    }
}

