//
//  ListInteractor.swift
//  VIPER_Demo
//
//  Created by Sheikh Ali on 03/05/2024.
//

import Foundation
import RealmSwift

protocol ListInteractorProtocol: AnyObject {
    func fetchItems(keyword: String)
}

class ListInteractor: ListInteractorProtocol {
    
    var presenter: ListPresenterProtocol?
    
    func fetchItems(keyword: String) {
        fetchDataFromAPI(text: keyword)
    }
    
    private func fetchDataFromAPI(text: String) {
        let service = APIService()
        do {
            let request = try UniversitySearchAPI(keyword: text)
            service.getData(request: request) { [weak self] (result) in
                switch result {
                case .success(let response):
                    if let responceData = response.decodeToDictionary() {
                        var universityItems: [UniversityEntity] = []
                        
                        for dict in responceData {
                            universityItems.append(UniversityEntity(from: dict))
                        }
                        DispatchQueue.main.async {
                            self?.saveItems(universityItems)
                        }
                    } else {
                        DispatchQueue.main.async { [weak self] in
                            self?.fetchDataFromRealm()
                        }
                    }
                case .failure:
                    DispatchQueue.main.async { [weak self] in
                        self?.fetchDataFromRealm()
                    }
                }
            }
        } catch {
            DispatchQueue.main.async { [weak self] in
                self?.fetchDataFromRealm()
            }
        }
    }
       
       private func fetchDataFromRealm() {
           do {
               let realm = try Realm()
               let items = realm.objects(UniversityEntity.self)
               presenter?.itemsFetched(Array(items))
           } catch {
               presenter?.itemsFetchFailed(withError: error)
           }
       }
       
       private func saveItems(_ items: [UniversityEntity]) {
           do {
               let realm = try Realm()
               try realm.write {
                   for item in items {
                       realm.add(item, update: .modified)
                   }
               }
               presenter?.itemsFetched(items)
           } catch {
               print("Failed to save items with error: \(error)")
               fetchDataFromRealm()
           }
       }
}
