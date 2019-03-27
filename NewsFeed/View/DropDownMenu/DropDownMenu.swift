//
//  DropDownMenu.swift
//  NewsFeed
//
//  Created by admin on 27/03/19.
//  Copyright © 2019 AcknoTech. All rights reserved.
//

import UIKit

protocol DropDownDelegate:AnyObject{
    func selectedMenu(item:DropDown)
}

class DropDownMenu:UIView{
    
//    MARK:- Variable Declaration
    
    fileprivate let service = DropDownService.dropDownService
    
    //reusableCell
    private let reuseCell = "CellId"
    
    weak var delegate:DropDownDelegate?
    
//        MARK:- View init
    override init(frame: CGRect) {
        super.init(frame: frame)
        tableViewSetup()
        tableDataSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
//    MARK:- declare View
    
    fileprivate lazy var tableView:UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .orange
        tableView.separatorColor = .white
        tableView.indicatorStyle = .white
        tableView.separatorInset.left = 0
        tableView.separatorInset.right = 0
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private func tableViewSetup(){
        addSubview(tableView)
        tableViewConstraints()
    }
    
    private func tableViewConstraints(){
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
            ])
    }
    
    private func tableDataSetup(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(DropDownCell.self, forCellReuseIdentifier: reuseCell)
    }
}

extension DropDownMenu:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return service.getDropDownSections().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseCell, for: indexPath) as? DropDownCell else{return UITableViewCell()}
        cell.updateCellLabel(dropDown: service.getDropDownSections()[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.selectedMenu(item: service.getDropDownSections()[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
