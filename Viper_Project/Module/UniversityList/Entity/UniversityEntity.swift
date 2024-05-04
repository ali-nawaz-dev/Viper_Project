//
//  UniversityEntity.swift
//  VIPER_Demo
//
//  Created by Sheikh Ali on 03/05/2024.
//

import Foundation
import RealmSwift

class UniversityEntity: Object {

    @Persisted var alphaTowCode: String
    @Persisted(primaryKey: true) var name: String
    @Persisted var country: String
    @Persisted var stateProvince: String
    
    @Persisted var domains = List<DomainEntity>()
    @Persisted var webpages = List<DomainEntity>()
    
    convenience init(from json: [String: Any]) {
        self.init()
   
        alphaTowCode = json["alpha_two_code"] as? String ?? ""
        name = json["name"] as? String ?? ""
        country = json["country"] as? String ?? ""
        stateProvince = json["state-province"] as? String ?? ""
        
        
        if let domains = json["domains"] as? [String], domains.count > 0 {
            for domain in domains {
                let domainObject = DomainEntity()
                domainObject.url  = domain
                self.domains.append(domainObject)
            }
        }
        
        if let webPages = json["web_pages"] as? [String], webPages.count > 0 {
            for webPage in webPages {
                let domainObject = DomainEntity()
                domainObject.url  = webPage
                self.webpages.append(domainObject)
            }
        }
    }
}

class DomainEntity: Object {
    @Persisted var url: String
}

