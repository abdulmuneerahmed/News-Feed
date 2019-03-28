//
//  imageExtension.swift
//  NewsFeed
//
//  Created by admin on 27/03/19.
//  Copyright © 2019 AcknoTech. All rights reserved.
//

import UIKit

private let imageCache = NSCache<AnyObject, AnyObject>()

class CustomImageView:UIImageView{
    var imageUrlString:String?
    
    func loadImageUsingURLString(urlString:String){
        imageUrlString = urlString
        
        guard let url = URL(string: urlString) else{return}
        
        image = nil
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage{
            self.image = imageFromCache
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil{
                print(error.debugDescription)
                return
            }
            
            guard let imageData = data else{return}
            
            DispatchQueue.main.async {
                let imageToCache = UIImage(data: imageData)
                
                if self.imageUrlString == urlString{
                    self.image = imageToCache
                }
                guard let imagetoCache = imageToCache else{return}
                imageCache.setObject(imagetoCache, forKey: urlString as AnyObject)
            }
        }.resume()
    }
}


extension UIImage {
    func getcropRatio()->CGFloat{
        let widthRatio = CGFloat(self.size.width/self.size.height)
        return widthRatio
    }
}
