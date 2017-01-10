//
//  NetworkManager.swift
//  Altran
//
//  Created by Cesar Vilera on 1/10/17.
//  Copyright © 2017 Cesar Vilera. All rights reserved.
//

import UIKit

class NetworkManager: NSObject {
    
    private let session = URLSession.shared
    
    func createRequestURL(with stringURL: String) -> NSMutableURLRequest? {
        
        guard let url = URL(string: stringURL) else {
            return nil
        }
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "GET"
        
    
        return request
    }
    
    func get(stringURL: String, completion: @escaping (_ response: AnyObject?, _ error: Error?) -> Void) {
        guard var requestURL = createRequestURL(with: stringURL) as URLRequest? else {
            return
        }
        requestURL.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = session.dataTask(with: requestURL) { (data, responseURL, error) in
            guard (error == nil) else {
                completion(nil, error)
                return
            }
            guard let data = data else {
                completion(nil, error)
                return
            }
            do {
                let response = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as AnyObject?
                completion(response, nil)
            }catch {
                completion(nil, error)
            }
        }
        
        task.resume()
        
    }
    
    func getImage(stringURL: String, completion: @escaping (_ response: AnyObject?, _ error: Error?) -> Void) {
        guard var requestURL = createRequestURL(with: stringURL) as URLRequest? else {
            return
        }
        requestURL.addValue("image/jpeg", forHTTPHeaderField: "Content-Type")
        requestURL.cachePolicy = .returnCacheDataElseLoad
        
        let task = session.dataTask(with: requestURL) { (data, responseURL, error) in
            guard (error == nil) else {
                completion(nil, error)
                return
            }
            guard let data = data as AnyObject? else {
                completion(nil, error)
                return
            }
            completion(data, nil)
        }
        
        task.resume()
    }
    
}
