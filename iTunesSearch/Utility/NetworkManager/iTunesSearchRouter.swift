//
//  iTunesSearchAPIRouter.swift
//  iTunesSearch
//
//  Created by JinwooLee on 4/5/24.
//

import Foundation
import Alamofire

// Routher Pattern with Alamorfire
enum iTunesSearchAPIRouter : URLRequestConvertible {
    
    case search(term : String)
    
    var baseURL: URL {
        return URL(string: "https://itunes.apple.com/")!
    }
    
    var path : String {
        switch self {
        case .search:
            return "search"
        }
    }
    
    var method : HTTPMethod {
        switch self {
        case .search :
            return .get
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .search(let term):
            return [
                "term" : term,
                "country" : "KR",
                "media" : "software",
                "limit" : 50
            ]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        
        let url = URL(string : baseURL.appendingPathComponent(path).absoluteString.removingPercentEncoding!)
        var request = URLRequest.init(url: url!)
        request.httpMethod = method.rawValue
        
        return try URLEncoding.default.encode(request, with: parameters)
    }
}
