//
//  NewsApi.swift
//  NewsFeed
//
//  Created by admin on 27/03/19.
//  Copyright © 2019 AcknoTech. All rights reserved.
//

import Foundation

class NewsApi{

    static let service = NewsApi()
    
    private let service = NewsDataService.service
    
    private let requestedAPI = ApiKey.key.getApi()
    
    private let headerValue = ApiKey.headerValue.getApi()
    
    private let header = ApiKey.header.getApi()
    
    
    func createRequest(section item:String) -> (session:URLSession,request:URLRequest)?{
        let sessionConfig = URLSessionConfiguration.default
        let sessionReturn = URLSession(configuration: sessionConfig)
        
        let urlString = "https://api.nytimes.com/svc/topstories/v2/\(item).json?api-key=\(requestedAPI)"
        
        guard let url = URL(string: urlString)else{return nil}
        
        var requestReturn = URLRequest(url: url)
        requestReturn.httpMethod = "GET"
        requestReturn.addValue(headerValue, forHTTPHeaderField: header)
        return (sessionReturn,requestReturn)
    }
    
    
    func retrieveDataFromServer(session:URLSession,request:URLRequest,completion: @escaping(_ status:Bool)->()){
        let task = session.dataTask(with: request) {[weak self](data, response, error) in
            
            guard let self = self else{return}
            
            if let error = error{
                print(error.localizedDescription)
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,(200...299).contains(httpResponse.statusCode)else{
                print(response.debugDescription)
                return
            }
            
            guard let responseData = data else{return}
            
            do{
                self.service.newsDetails.removeAll()
                let decoder = JSONDecoder()
                let storyData = try decoder.decode(StoryData.self, from: responseData)
               
                for results in storyData.results{
                    let title = results.title
                    let abstract = results.abstract
                    let section = results.section
                    let byline = results.byline
                    if results.multimedia.isEmpty{
                        self.service.newsDetails.append(NewsData(imageString: "", headLines: title, description: abstract, newsType: section, author: byline))
                    }else{
                        let imageData = results.multimedia[3].url
                        self.service.newsDetails.append(NewsData(imageString: imageData, headLines: title, description: abstract, newsType: section, author: byline))
                    }
                    
                    
                }
                completion(true)
                
            }catch let errore as NSError{
                print(errore.userInfo)
            }
            
        }
        task.resume()
    }
    
    
}

fileprivate enum ApiKey:String{
    case key = "1GGYTLi4oWixmWAeUq9dCGj6XCp55m1m"
    case headerValue = "application/json"
    case header = "Accept"
    fileprivate func getApi()->String{
        return self.rawValue
    }
}
