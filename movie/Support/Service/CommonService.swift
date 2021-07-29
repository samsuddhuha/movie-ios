//
//  CommonService.swift
//  movie
//
//  Created by Samsud Dhuha on 29/07/21.
//

import Foundation
import Moya
import SwiftyJSON

enum Common: Equatable {
    case genre(language: String)
    case movie(genre: String, language: String, page: Int)
    case trailer(id: Int)
}

let commonClosure = { (target: Common) -> Endpoint in
    let defaultEndpoint = MoyaProvider.defaultEndpointMapping(for: target)
    
    switch target {
    case .genre, .movie, .trailer:
        return defaultEndpoint
//        return defaultEndpoint.adding(newHTTPHeaderFields: ["Authorization" : API_KEY])
    }
}

let commonService = MoyaProvider<Common>(endpointClosure: commonClosure)

extension Common: TargetType {
    var baseURL: URL {
        return URL(string: BASE_URL)!
    }
    
    var path: String {
        switch self {
        case .genre:
            return "/genre/movie/list"
        case .movie:
            return "/discover/movie"
        case .trailer(let id):
            return "/movie/\(id)/videos"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    
    var task: Task {
        var data = [String:Any]()
        
        switch self {
        case .genre(let language):
            data["api_key"] = API_KEY
            data["language"] = language
            
            return .requestParameters(parameters: data, encoding: URLEncoding.queryString)
            
        case .movie(let genre, let language, let page):
            data["api_key"] = API_KEY
            data["with_genres"] = genre
            data["page"] = page
            data["language"] = language
            
            return .requestParameters(parameters: data, encoding: URLEncoding.queryString)
            
        case .trailer(_):
            data["api_key"] = API_KEY
            
            return .requestParameters(parameters: data, encoding: URLEncoding.queryString)
        }
        
    }
    
    var headers: [String : String]? {
        return nil
    }
    
}

