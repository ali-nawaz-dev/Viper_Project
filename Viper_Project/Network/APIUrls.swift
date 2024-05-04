//
//  APIUrls.swift
//  VIPER_Demo
//
//  Created by Sheikh Ali on 03/05/2024.
//

import Foundation

protocol ApiRequestProtocol {
    var method: HttpMethod { get }
    var url: URL { get }
    var body: Encodable? { get }
}

struct UniversitySearchAPI: ApiRequestProtocol {
    var url: URL
    var method: HttpMethod = .GET
    var body: Encodable? = nil
    
    init(keyword: String) throws {
        if let apiUrl = URL(string:  Constant.baseUrl + "search?country=\(keyword)") {
            self.url = apiUrl
        } else {
            throw ApiError.urlEncode
        }
    }
}
