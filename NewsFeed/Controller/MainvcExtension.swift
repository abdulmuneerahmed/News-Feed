//
//  MainvcExtension.swift
//  NewsFeed
//
//  Created by admin on 27/03/19.
//  Copyright © 2019 AcknoTech. All rights reserved.
//

import UIKit

extension MainVC{
    
    //     MARK:-Selectors
    
    //Nav Bar Button Action
    @objc func navButtonAction(sender:UIButton){
        switch sender.tag {
        case 1:
           animatedDropDown(tag: sender.tag)
            sender.tag = 0
        default:
            animatedDropDown(tag: sender.tag)
            sender.tag = 1
        }
    }
}
