//
//  HandlingTableData.swift
//  NewsFeed
//
//  Created by admin on 28/03/19.
//  Copyright © 2019 AcknoTech. All rights reserved.
//

import UIKit


extension MainVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsDataService.getNewsDetails().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reusableCell, for: indexPath) as? NewsDataCell else{return UITableViewCell()}
        cell.selectionStyle = .none
        cell.updateCellData(newsData: newsDataService.getNewsDetails()[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
