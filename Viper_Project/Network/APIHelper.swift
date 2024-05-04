//
//  APIConstant.swift
//  VIPER_Demo
//
//  Created by Sheikh Ali on 03/05/2024.
//

import Foundation

struct Constant {
    static let baseUrl = "http://universities.hipolabs.com/"
}

enum ApiError: Error {
    case network(errorMessage: String)
    case decoding(errorMessage: String)
    case urlEncode
    
    var localizedDescription: String {
        switch self {
        case .network(let message):
            return message
        case .decoding(let message):
            return message
        case .urlEncode:
            return "Url encode error"
        }
    }
}

enum HttpMethod: String {
    case GET
    case POST
}

extension Encodable {
    func toJSONData() -> Data? { try? JSONEncoder().encode(self) }
}

extension Data {
    func decodeToDictionary() -> [[String: Any]]? {
        do {
            return try JSONSerialization.jsonObject(with: self, options: []) as? [[String: Any]]
        } catch {
            print("Error decoding JSON: \(error)")
            return nil
        }
    }
}


extension Data {
    func toString(encoding: String.Encoding = .utf8) -> String? {
        return String(data: self, encoding: encoding)
    }
}
