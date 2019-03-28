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
        label.font = UIFont(name: "Avenirnext-Heavyitalic", size: 18)
        label.numberOfLines = 0
        label.textColor = .black
        label.textAlignment = .justified
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate lazy var imageBanner:CustomImageView = {
        let imageView = CustomImageView()
        imageView.backgroundColor = .gray
        imageView.layer.cornerRadius = 8
        imageView.image = UIImage(named: "new")
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    fileprivate lazy var descriptionLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenirnext-Bold", size: 17)
        label.textColor = UIColor(red: 33/255, green: 33/255, blue: 33/255, alpha: 1)
        label.numberOfLines = 0
        label.textAlignment = .justified
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate lazy var topicLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenirnext-Demibolditalic", size: 15)
        label.textColor = .gray
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate lazy var authorLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenirnext-Demibolditalic", size: 15)
        label.textColor = .gray
        label.numberOfLines = 3
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    fileprivate lazy var cardView:UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate func addCellViews(){
        
        addSubview(cardView)
        
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            cardView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            cardView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            cardView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
            ])
        cardViewEffects()
        let horitzonalView = stackViews(views: [topicLabel,authorLabel])
        horitzonalView.axis = .horizontal
        horitzonalView.spacing = 10
        let stackView = stackViews(views:[headingLabel,imageBanner,descriptionLabel,horitzonalView])
        
        cardView.addSubview(stackView)
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 10
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -10),
            stackView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -10)
            ])
        
        NSLayoutConstraint.activate([
            imageBanner.heightAnchor.constraint(equalToConstant: 300),
            ])
        


    }
    
    fileprivate func cardViewEffects(){
        cardView.layer.shadowColor = UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 153/255).cgColor
        cardView.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        cardView.layer.borderWidth = 0.1
        cardView.layer.shadowOffset = CGSize(width: 8, height: 8)
        cardView.layer.shadowRadius = 8
        cardView.layer.shadowOpacity = 0.8
    }
    
    fileprivate func stackViews(views:[UIView]) -> UIStackView{
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }
    
    func updateCellData(newsData:NewsData){
        
        if !newsData.imageString.isEmpty{
            imageBanner.loadImageUsingURLString(urlString: newsData.imageString)
        }else{
            imageBanner.image = UIImage(named: "new")
        }
        headingLabel.text = newsData.headLines
        descriptionLabel.text = newsData.description
        authorLabel.text = newsData.author
        topicLabel.text = newsData.newsType
        
    }
}
