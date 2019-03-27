//
//  DropDownService.swift
//  NewsFeed
//
//  Created by admin on 27/03/19.
//  Copyright © 2019 AcknoTech. All rights reserved.
//

import Foundation

class DropDownService{
    
    public static let dropDownService = DropDownService()
    
    private init(){
        
    }
    
    let dropDownSection = [
        DropDown(section: "arts"),DropDown(section: "automobiles"),
        DropDown(section: "books"),DropDown(section: "business"),
        DropDown(section: "fashion"),DropDown(section: "food"),
        DropDown(section: "health"),DropDown(section: "home"),
        DropDown(section: "insider"),DropDown(section: "magazine"),
        DropDown(section: "movies"),DropDown(section: "national"),
        DropDown(section: "nyregion"),DropDown(section: "obituaries"),
        DropDown(section: "opinion"),DropDown(section: "politics"),
        DropDown(section: "realestate"),DropDown(section: "science"),
        DropDown(section: "sports"),DropDown(section: "sundayreview"),
        DropDown(section: "technology"),DropDown(section: "theater"),
        DropDown(section: "tmagazine"),DropDown(section: "travel"),
        DropDown(section: "upshot"),DropDown(section: "world")
    ]
    
    func getDropDownSections() -> [DropDown]{
        return dropDownSection
    }
}
