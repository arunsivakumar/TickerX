//
//  NetworkManager.swift
//  TickerX
//
//  Created by blackbriar on 4/26/17.
//  Copyright © 2017 com.teressa. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


typealias ServiceResponse = ((JSON?, Error?) -> Void)
class NetworkManager {
    
    let endPoint = "http://api.giphy.com/v1/gifs/"
    
    let apiKey = "dc6zaTOxFJmzC"
    
    let trending = "trending"
    
    let search = "search"
    
    static let sharedInstance = NetworkManager()
    fileprivate init() {}
    
    func getTrending(_ completion: @escaping ServiceResponse)
    {
        let params = [ "api_key" : apiKey]
        Alamofire.request(endPoint+trending, method: .get, parameters: params, encoding: JSONEncoding.default, headers: nil).validate().responseJSON() { response in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print("DATA \(json)")
                    completion(json, nil)
                }
            case .failure(let error):
                print(error)
                completion(nil, error)
            }
        }
    }
    func getInfoWithPath(path: String, completion: @escaping ServiceResponse)
    {
        let headers = [
            "Accept": "application/json"
        ]
        let params = [ "q" : path.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil),
                       "api_key" : apiKey ]
        Alamofire.request(endPoint+search, method: .get, parameters: params, headers: headers).validate().responseJSON() { response in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print("DATA \(json)")
                    completion(json, nil)
                }
            case .failure(let error):
                print(error)
                completion(nil, error)
            }
        }
    }

    func getStocksForSymbol(symbol: String, completion: @escaping ServiceResponse)
    {
        let params = ["region": "US", "lang": "en-US"]
        let finalEndPoint = Constants.symbolsUrlPrefix + Constants.urlBorder +
            symbol + Constants.urlBorder + Constants.symbolsUrlSuffix
//        print("FINAL ENDPoint\(finalEndPoint)")
        Alamofire.request(finalEndPoint, method: .get, parameters: params).validate().responseJSON() { response in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
//                    print("DATA \(json)")
                    completion(json, nil)
                }
            case .failure(let error):
                print(error)
                completion(nil, error)
            }
        }
    }
    
    func searchSymbol(query: String, completion: @escaping ServiceResponse)
    {
        let params = ["region": "US",
                      "lang": "en-US",
                      "query" : query]
        Alamofire.request(Constants.searchEndPoint, method: .get, parameters: params).validate().responseJSON() { response in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print("DATA \(json)")
                    completion(json, nil)
                }
            case .failure(let error):
                print(error)
                completion(nil, error)
            }
        }
    }
    
    
    
    
}


