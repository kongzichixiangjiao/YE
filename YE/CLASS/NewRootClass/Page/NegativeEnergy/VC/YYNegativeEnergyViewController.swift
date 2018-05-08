//
//  YYNegativeEnergyViewController.swift
//  YE
//
//  Created by 侯佳男 on 2018/5/7.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit

class YYNegativeEnergyViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchResultView: UIView!
    
    var searchResultVC: YYNegativeEnergyResultViewController!
    
    var dataList: [String] = []
    
    lazy var searchBar: YYSearchBar = {
        let v = YYSearchBar.loadView()
        v.frame = CGRect(x: 0, y: 0, width: self.tableView.frame.size.width, height: YYSearchBar.height)
        v.delegate = self
        return v
    }()
    
    lazy var searchBarView: UIView = {
        let v = UIView(frame: CGRect(x: 0, y: 20, width: self.tableView.frame.size.width, height: YYSearchBar.height))
        v.addSubview(self.searchBar)
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        
        searchResultVC = childViewControllers.first as! YYNegativeEnergyResultViewController
        
        initViews()
        
    }
    
    func initViews() {
        self.view.addSubview(self.searchBarView)
        self.tableView.register(UINib(nibName: YYNegativeEnergyResultCell.identifier, bundle: nil), forCellReuseIdentifier: YYNegativeEnergyResultCell.identifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func back(_ sender: UIBarButtonItem) {
        guard let nav: YYNavigationViewController = self.parent?.parent?.parent as? YYNavigationViewController else {
            return
        }
        _ = nav.popToRootViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

extension YYNegativeEnergyViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: YYNegativeEnergyResultCell.identifier) as! YYNegativeEnergyResultCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataList.count
    }
    
}

extension YYNegativeEnergyViewController: YYSearchBarDelegate {
    func searchBarDidBeginEditing(text: String) {
        print(text)
        self.tableView.isHidden = true
        self.searchResultView.isHidden = false
    }
    
    func searchBarChangedValue(text: String) {
        searchResultVC.resultText = text 
    }
    
    func searchBarDidEndEditing(text: String) {
        print(text)
        self.tableView.isHidden = false
        self.searchResultView.isHidden = true
    }
    
    func searchBarClickedCancleButton() {
        self.tableView.isHidden = false
        self.searchResultView.isHidden = true
        
    }
}
