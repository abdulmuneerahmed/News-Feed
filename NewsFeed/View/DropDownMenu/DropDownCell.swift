//
//  DropDownCell.swift
//  NewsFeed
//
//  Created by admin on 27/03/19.
//  Copyright © 2019 AcknoTech. All rights reserved.
//

import UIKit

class DropDownCell:UITableViewCell{
    
    //    MARK:- init Method
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addCellViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//        MARK:- Cell views Declaration

    
    //label for cell
    fileprivate lazy var sectionLabel: UILabel = {
        let sectionLabel = UILabel()
        sectionLabel.font = UIFont(name: "Avenirnext-Heavy", size: 20)
        sectionLabel.backgroundColor = .orange
        sectionLabel.textAlignment = .center
        sectionLabel.textColor = .white
        sectionLabel.translatesAutoresizingMaskIntoConstraints = false
        return sectionLabel
    }()
    
    private func addCellViews(){
        addSubview(sectionLabel)
        loadConstraints()
    }
    
    private func loadConstraints(){
        
        NSLayoutConstraint.activate([
            sectionLabel.topAnchor.constraint(equalTo: self.topAnchor),
            sectionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            sectionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            sectionLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            ])
    }
    
    func updateCellLabel(dropDown:DropDown){
        sectionLabel.text = dropDown.section
    }
}
