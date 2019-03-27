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
        let task = session.dataTask(with: request) {(data, response, error) in
            
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
                let decoder = JSONDecoder()
                let storyData = try decoder.decode(StoryData.self, from: responseData)
               
                print(storyData)
                
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
