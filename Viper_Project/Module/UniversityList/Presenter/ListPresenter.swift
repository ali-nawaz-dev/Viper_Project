//
//  ListPresenter.swift
//  VIPER_Demo
//
//  Created by Sheikh Ali on 03/05/2024.
//

import Foundation
import UIKit

protocol ListPresenterProtocol: AnyObject {
    var view: ListViewProtocol? { get set }
    var interactor: ListInteractorProtocol? { get set }
    var router: ListRouterProtocol? { get set }
    
    func fetchItems(keyword: String)
    func viewDidLoad()
    func itemsFetched(_ items: [UniversityEntity])
    func itemsFetchFailed(withError error: ApiError)
    func itemsSelected(item: UniversityEntity, from view: UIViewController)
}

class ListPresenter: ListPresenterProtocol {
    
    weak var view: ListViewProtocol?
    var interactor: ListInteractorProtocol?
    var router: ListRouterProtocol?
    
    func viewDidLoad() {
        view?.prepareUI()
    }
    
    func fetchItems(keyword: String) {
        interactor?.fetchItems(keyword: keyword)
    }
    
    func itemsFetched(_ items: [UniversityEntity]) {
        view?.showItems(items)
    }
    
    func itemsFetchFailed(withError error: ApiError) {
        view?.showError(error)
    }
    
    func itemsSelected(item: UniversityEntity, from view: UIViewController) {
        router?.navigateToUniversityDetail(with: item, from: view)
    }
}
