//
//  NewsDataService.swift
//  NewsFeed
//
//  Created by admin on 27/03/19.
//  Copyright © 2019 AcknoTech. All rights reserved.
//

import Foundation

class NewsDataService{
    
    static let service = NewsDataService()
    
    var newsDetails = [NewsData]()
    
    func getNewsDetails() -> [NewsData]{
        return newsDetails
    }
    
}
