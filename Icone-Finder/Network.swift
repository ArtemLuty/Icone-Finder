//
//  Network.swift
//  Icone Finder
//
//  Created by Корістувач on 25.04.2020.
//  Copyright © 2020 kolesnikov. All rights reserved.
//

import UIKit
import Alamofire

class Network: NSObject {
    
    static let shared = Network()
    private override init() {}
    
    // MARK: Icone-finder API
    
    
    func searchIcon (string: String, completion: @escaping ([Icon]?, Error?) -> Void) {
        
        let params: Parameters = ["prant_type": "jwt_bearer", "client_id": "eE3M9svq7UuOtF6L8UmsPOEO5WtfMkzj7ng5ZJPdhlwYd6tSnOyv3Vpr7EPcflEd",
                                  "client_secret": "9QYXRtK5CUqukQdYWDLgaWbuEKYCgcEHjnDAX1k5pJraVks1KYmutRJGixgnUSuq"]
        let url = "https://api.iconfinder.com/v3/icons/search?query=" + string + "&premium=0&count=100"
        
        Alamofire.request(url, method: .get, parameters: params, encoding: URLEncoding.default, headers: nil).validate(contentType: ["application/json"]).responseJSON { response in
            
            switch response.result {
            case.success(let JSON):
               
                guard let dictionary = JSON as? [String: AnyObject ] else { return }
                guard let array = dictionary["icons"] as? [[String: AnyObject]] else { return }
                var icons = [Icon]()
                
                for item in array {
                    if let icon = self.parseIcon(item) {
                        icons.append(icon)
                    }
                }
                let finalArray = icons.count > 0 ? icons : nil
                completion(finalArray, nil)
            case .failure(let error):
                print(error.localizedDescription)
                completion(nil, error)
            }
            
        }
        
    }
    
    func parseIcon(_ dictionary: [String: AnyObject]) -> Icon? {
        let icon = Icon(link: getLink(dictionary),
                        tags: getTags(dictionary))
        return icon
    }
    
    func getLink(_ dictionary: [String: AnyObject]) ->String? {
        guard let rasterArray = dictionary["raster_sizes"] as? [[String: AnyObject]] else {return nil}
        guard let object512 = rasterArray.first(where: {$0["size_width"] as! Int == 512 }) else {return nil}
        guard let formats = object512["formats"] as? [[String: AnyObject]] else {return nil}
        guard let firstFormatObject = formats.first else {return nil}
        guard let link = firstFormatObject["preview_url"] as? String else {return nil}
        return link
    }
    
    func getTags(_ dictionary: [String: AnyObject]) -> [String]? {
        guard let tags = dictionary["tags"] as? [String] else {return nil}
        return tags
        
    }
}

