//
//  ViewController.swift
//  NewsFeed
//
//  Created by admin on 27/03/19.
//  Copyright © 2019 AcknoTech. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
    
//              MARK:- Variable Declaration
    
    // Nav button Title variable
    var navButtonTitle = "home"
    
    
    
//        MARK:- View init Methods

    override func loadView() {
        super.loadView()
        navBarSetup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
 
//       MARK:- SubViews Declaration
    
    //TableView Declare & initialization
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.showsVerticalScrollIndicator = false
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    //Nav Bar Button Setup
    lazy var navButton: UIButton = {
        let button = UIButton()
        button.tag = 0
        button.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        button.setTitle("\(navButtonTitle) ⌄", for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenirnext-Heavyitalic", size: 20)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(navButtonAction(sender:)), for: .touchUpInside)
        return button
    }()

    
//      MARK:- Function Declarations
    
    //Nav Bar Setup Functions
    private func navBarSetup(){
        view.backgroundColor = .white
        navigationController?.navigationBar.barTintColor = .orange
        navigationItem.titleView = navButton
    }
    
    

    
//     MARK:-Selectors
    
    //Nav Bar Button Action
    @objc func navButtonAction(sender:UIButton){
        
    }
    
}

