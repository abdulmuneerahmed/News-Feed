//
//  NewsDataCell.swift
//  NewsFeed
//
//  Created by admin on 27/03/19.
//  Copyright © 2019 AcknoTech. All rights reserved.
//

import UIKit

class NewsDataCell:UITableViewCell{
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addCellViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate lazy var headingLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenirnext-Heavyitalic", size: 20)
        label.numberOfLines = 0
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate lazy var imageBanner:CustomImageView = {
        let imageView = CustomImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .gray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    fileprivate lazy var descriptionLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenirnext-Heavy", size: 18)
        label.textColor = .gray
        label.numberOfLines = 0
        label.textAlignment = .justified
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate lazy var topicLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenirnext", size: 18)
        label.textColor = .lightGray
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate lazy var authorLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenirnext", size: 18)
        label.textColor = .lightGray
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate func addCellViews(){
        addSubview(headingLabel)
        NSLayoutConstraint.activate([
            headingLabel.topAnchor.constraint(equalTo: self.topAnchor),
            headingLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            headingLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor)
            ])
        addSubview(imageBanner)
        NSLayoutConstraint.activate([
            imageBanner.topAnchor.constraint(equalTo: headingLabel.bottomAnchor),
            imageBanner.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageBanner.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageBanner.heightAnchor.constraint(equalToConstant: 100)
            ])
        addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: imageBanner.bottomAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            ])
        addSubview(topicLabel)
        NSLayoutConstraint.activate([
            topicLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor),
            topicLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            topicLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            topicLabel.widthAnchor.constraint(equalToConstant: 150)
            ])
        
        addSubview(authorLabel)
        NSLayoutConstraint.activate([
            topicLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor),
            topicLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            topicLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            topicLabel.widthAnchor.constraint(equalToConstant: 200)
            ])
    }
    
    func updateCellData(newsData:NewsData){
        
        if !newsData.imageString.isEmpty{
            imageBanner.loadImageUsingURLString(urlString: newsData.imageString)
        }
        headingLabel.text = newsData.headLines
        descriptionLabel.text = newsData.description
        authorLabel.text = newsData.author
        topicLabel.text = newsData.newsType
        
    }
}
