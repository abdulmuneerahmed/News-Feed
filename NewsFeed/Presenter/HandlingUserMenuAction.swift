//
//  HandlingUserMenuAction.swift
//  NewsFeed
//
//  Created by admin on 28/03/19.
//  Copyright © 2019 AcknoTech. All rights reserved.
//

import UIKit

extension MainVC:DropDownDelegate{
    
    func selectedMenu(item: DropDown) {
        let navItem = navButtonTitle
        navButtonTitle = item.section
        navButton.setTitle("\(navButtonTitle) ⌄", for: .normal)
        animatedDropDown(tag: 1)
        navButton.tag = 0
        guard (navItem != item.section) else{return}
        retriveData(item: item.section)
    }
    
    
     func retriveData(item:String){
        let requestInfo = newsService.createRequest(section: item)
        
        guard let session = requestInfo?.session, let request = requestInfo?.request else {
            return
        }
        tableClean()
        newsService.retrieveDataFromServer(session: session, request: request) {[weak self] (status) in
            
            guard let self = self else{return}
            
            DispatchQueue.main.async {
                self.completionTask()
            }
            
        }
        
    }
    
    fileprivate func completionTask(){
        tableView.reloadData()
        tableView.isHidden = false
        spinner.stopAnimating()
    }
    
    fileprivate func tableClean(){
        tableView.isHidden = true
        spinner.startAnimating()
        tableView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
}
