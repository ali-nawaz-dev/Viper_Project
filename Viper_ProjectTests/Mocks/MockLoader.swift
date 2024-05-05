//
//  MockLoader.swift
//  Viper_ProjectTests
//
//  Created by Sheikh Ali on 04/05/2024.
//

import Foundation
@testable import Viper_Project

class ResourceLoader {
    
    enum Search: String {
        case mockSearch = "MockAPIResponse"
    }
    
    
    func loadSearch(resource: Search) throws -> [UniversityEntity] {
        
        let bundle = Bundle.test
        if let path = bundle.url(forResource: resource.rawValue, withExtension: "json")
        {
            let jsonData = try? Data(contentsOf: path).decodeToDictionary()
            
            var universityItems: [UniversityEntity] = []
            
            for dict in jsonData ?? [] {
                universityItems.append(UniversityEntity(from: dict))
            }
            
            return universityItems
        }
        fatalError("File not loaded")
    }
}
private extension Bundle {
    class Dummy { }
    static let test = Bundle(for: Dummy.self)
}
