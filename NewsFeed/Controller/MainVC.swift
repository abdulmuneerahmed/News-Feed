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
    fileprivate lazy var navButtonTitle = "home"
    
    fileprivate let newsService = NewsApi.service
    
    var dropDownHeightAnchor:NSLayoutConstraint!
    var tableViewTopAnchor:NSLayoutConstraint!
    
    
//        MARK:- View init Methods

    override func loadView() {
        super.loadView()
        navBarSetup()
        addDropDown()
        addTableView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
 
//       MARK:- SubViews Declaration
    
    //TableView Declare & initialization
    fileprivate lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .red
        tableView.showsVerticalScrollIndicator = false
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    //Nav Bar Button Setup
    fileprivate lazy var navButton: UIButton = {
        let button = UIButton()
        button.tag = 0
        button.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        button.setTitle("\(navButtonTitle) ⌄", for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenirnext-Heavyitalic", size: 20)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(navButtonAction(sender:)), for: .touchUpInside)
        return button
    }()
    
    fileprivate lazy var dropDownView:DropDownMenu = {
        let dropDown = DropDownMenu()
        dropDown.delegate = self
        dropDown.translatesAutoresizingMaskIntoConstraints = false
        return dropDown
    }()


//      MARK:- Function Declarations
    
    //Nav Bar Setup Functions
    private func navBarSetup(){
        view.backgroundColor = .orange
        navigationController?.navigationBar.barTintColor = .orange
        navigationItem.titleView = navButton
    }
    
    private func addDropDown(){
        view.addSubview(dropDownView)
        dropDownConstraints()
    }
    
    private func dropDownConstraints(){
        NSLayoutConstraint.activate([
            dropDownView.topAnchor.constraint(equalTo: view.topAnchor),
            dropDownView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dropDownView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
        dropDownHeightAnchor = dropDownView.heightAnchor.constraint(equalToConstant: 0)
        dropDownHeightAnchor.isActive = true
    }
    
    private func addTableView(){
        view.addSubview(tableView)
        tableViewConstraints()
    }
    private func tableViewConstraints(){
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        tableViewTopAnchor = tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        tableViewTopAnchor.isActive = true
    }
    
     fileprivate func showDropDown(){
        navButton.setTitle("\(navButtonTitle) ⌃", for: .normal)
        dropDownHeightAnchor.constant = view.frame.height/3
        tableViewTopAnchor.isActive = false
        updateTableViewTopAnchor(activate: true)
    }
    
     fileprivate func hideDropDown(){
        navButton.setTitle("\(navButtonTitle) ⌄", for: .normal)
        dropDownHeightAnchor.constant = 0
        tableViewTopAnchor.isActive = false
        updateTableViewTopAnchor(activate: false)
    }
    
    private func updateTableViewTopAnchor(activate:Bool){
        tableViewTopAnchor = activate ? tableView.topAnchor.constraint(equalTo: dropDownView.bottomAnchor) : tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
            tableViewTopAnchor.isActive = true

        
    }
    
    func animatedDropDown(tag:Int){
        UIView.animate(withDuration: 0.5) {
            tag == 0 ? self.showDropDown() : self.hideDropDown()
            self.view.layoutIfNeeded()
        }
    }
    
}


extension MainVC:DropDownDelegate{
    func selectedMenu(item: DropDown) {
        let navItem = navButtonTitle
        navButtonTitle = item.section
        navButton.setTitle("\(navButtonTitle) ⌄", for: .normal)
        animatedDropDown(tag: 1)
        navButton.tag = 0
        guard (navItem != item.section) else{return}
        retriveData(item: item.section)
    }
    
    
    func retriveData(item:String){
        let requestInfo = newsService.createRequest(section: item)
        
        guard let session = requestInfo?.session, let request = requestInfo?.request else {
            return
        }
        
        newsService.retrieveDataFromServer(session: session, request: request) { (status) in
            print("completed")
        }
        
    }
}


