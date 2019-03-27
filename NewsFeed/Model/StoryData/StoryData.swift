//
//  StoryData.swift
//  NewsFeed
//
//  Created by admin on 27/03/19.
//  Copyright © 2019 AcknoTech. All rights reserved.
//

import UIKit

struct StoryData:Codable {
    let status:String
    let copyright:String
    let section:String
    let last_updated:String
    let num_results:Int
    let results:[results]
}

struct results:Codable {
    let section:String
    let subsection:String
    let title:String
    let abstract:String
    let url:String
    let byline:String
    let item_type:String
    let updated_date:String
    let created_date:String
    let published_date:String
    let material_type_facet:String
    let kicker:String
//    let short_url:String
    let des_facet:[String]
    let org_facet:[String]
    let per_facet:[String]
    let geo_facet:[String]
    let multimedia:[multimedia]
}

struct multimedia:Codable {
    let url:String
    let format:String
    let height: Int
    let width: Int
    let type:String
    let subtype:String
    let caption:String
    let copyright:String
}
