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
    
     let reusableCell = "CellId"
    
     lazy var navButtonTitle = "home"
    
     let newsService = NewsApi.service
    
     let newsDataService = NewsDataService.service
    
    var dropDownHeightAnchor:NSLayoutConstraint!
    var tableViewContainerTopAnchor:NSLayoutConstraint!
    
    
    //        MARK:- View init Methods
    
    override func loadView() {
        super.loadView()
        navBarSetup()
        addDropDown()
        addtableViewContainer()
        addTableView()
        addSpinner()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewDataSetup()
        retriveData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    
    //       MARK:- SubViews Declaration
    
    
    fileprivate lazy var tableviewContainer:UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //TableView Declare & initialization
     lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
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
    
    fileprivate lazy var dropDownView:DropDownMenu = {
        let dropDown = DropDownMenu()
        dropDown.delegate = self
        dropDown.translatesAutoresizingMaskIntoConstraints = false
        return dropDown
    }()
    
    lazy var spinner:UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.hidesWhenStopped = true
        spinner.style = .whiteLarge
        spinner.color = UIColor(red: 0/255, green: 150/255, blue: 255/255, alpha: 1)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
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
    
    private func addtableViewContainer(){
        view.addSubview(tableviewContainer)
        tableViewContanierConstraints()
    }
    
    private func addTableView(){
        tableviewContainer.addSubview(tableView)
        tableViewConstraints()
    }
    
    
    
    private func tableViewContanierConstraints(){
        NSLayoutConstraint.activate([
            tableviewContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableviewContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableviewContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        tableViewContainerTopAnchor = tableviewContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        tableViewContainerTopAnchor.isActive = true
    }
    
    private func tableViewConstraints(){
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: tableviewContainer.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: tableviewContainer.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: tableviewContainer.bottomAnchor),
            tableView.topAnchor.constraint(equalTo: tableviewContainer.topAnchor)
            ])
        
    }
    
    private func addSpinner(){
        tableviewContainer.addSubview(spinner)
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: tableviewContainer.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: tableviewContainer.centerYAnchor),
            spinner.heightAnchor.constraint(equalToConstant: 50),
            spinner.widthAnchor.constraint(equalToConstant: 50)
            ])
    }
    
    fileprivate func showDropDown(){
        navButton.setTitle("\(navButtonTitle) ⌃", for: .normal)
        dropDownHeightAnchor.constant = view.frame.height/3
        tableViewContainerTopAnchor.isActive = false
        updateTableViewTopAnchor(activate: true)
    }
    
    fileprivate func tableViewDataSetup(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(NewsDataCell.self, forCellReuseIdentifier: reusableCell)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 500
    }
    
    fileprivate func hideDropDown(){
        navButton.setTitle("\(navButtonTitle) ⌄", for: .normal)
        dropDownHeightAnchor.constant = 0
        tableViewContainerTopAnchor.isActive = false
        updateTableViewTopAnchor(activate: false)
    }
    
    private func updateTableViewTopAnchor(activate:Bool){
        tableViewContainerTopAnchor = activate ? tableView.topAnchor.constraint(equalTo: dropDownView.bottomAnchor) : tableviewContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        tableViewContainerTopAnchor.isActive = true
        
        
    }
    
    private func retriveData(){
        
        retriveData(item: navButtonTitle)
    }
    
    func animatedDropDown(tag:Int){
        UIView.animate(withDuration: 1.0, delay: 0.0, usingSpringWithDamping: 0.35, initialSpringVelocity: 20.0, options: [], animations: {
            UIView.animate(withDuration: 0.5) {
                tag == 0 ? self.showDropDown() : self.hideDropDown()
                self.view.layoutIfNeeded()
            }
        }, completion: nil)
        
    }
    
}




