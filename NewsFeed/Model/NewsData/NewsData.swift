//
//  NewsData.swift
//  NewsFeed
//
//  Created by admin on 27/03/19.
//  Copyright © 2019 AcknoTech. All rights reserved.
//

import Foundation

struct NewsData {
    let imageString:String
    let headLines:String
    let description:String
    let newsType:String
    let author:String
    
    init(imageString:String,headLines:String,description:String,newsType:String,author:String) {
        self.imageString = imageString
        self.headLines = headLines
        self.description = description
        self.newsType = newsType
        self.author = author
    }
}
