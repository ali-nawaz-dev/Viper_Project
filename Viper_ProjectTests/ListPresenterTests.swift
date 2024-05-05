//
//  Viper_ProjectTests.swift
//  Viper_ProjectTests
//
//  Created by Sheikh Ali on 03/05/2024.
//

import XCTest
@testable import Viper_Project

final class ListPresenterTests: XCTestCase {
    private var presenter: ListPresenterProtocol!
    private var interactor: MockInteractor!
    private var view: MockView!
    private var router: MockRouter!
    
    override func setUp() {
        interactor = MockInteractor()
        view = MockView()
        router = MockRouter()
        presenter = ListPresenter()
       
        view.presenter = presenter as? ListPresenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
    }
    
    func test_SetPrepareUI() {
        view.viewdidLoad()
        XCTAssertEqual(view.prepareUICounts, 1)
    }
    
    func test_findUniversities() {
        let searchKey = "United Arab Emirates"
        view.search(keyword: searchKey)
        XCTAssertGreaterThan(interactor.searchKeys.count, 0)
    }
    
    func test_findUniversitiesError() {
        interactor.presenter?.itemsFetchFailed(withError: ApiError.urlEncode)
        if view.errors.count == 1 {
            XCTAssertEqual(view.errors[0].localizedDescription, ApiError.urlEncode.localizedDescription)
        } else {
            XCTFail("View: Unexpected error count")
        }
    }

}


private class MockView: ListViewProtocol {
 
    var presenter: ListPresenter!
    var universities: [UniversityEntity] = []
    var errors: [ApiError] = []
    var prepareUICounts = 0
    
    func viewdidLoad() {
        presenter.viewDidLoad()
    }
    
    func prepareUI() {
        prepareUICounts += 1
    }
    
    func search(keyword: String) {
        presenter.fetchItems(keyword: keyword)
    }
    
    func showItems(_ items: [Viper_Project.UniversityEntity]) {
        universities.append(contentsOf: items)
    }
    
    func showError(_ error: ApiError) {
        errors.append(error)
    }
}

private class MockRouter: ListRouterProtocol {
    
    var screens: [String] = []
    
    func navigateToUniversityDetail(with university: Viper_Project.UniversityEntity, from view: UIViewController) {
        screens.append(university.name)
    }
}

private class MockInteractor: ListInteractorProtocol {
    
    var presenter: ListPresenterProtocol?
    
    var searchKeys: [String] = []
    
    func fetchItems(keyword: String) {
        searchKeys.append(keyword)
        if keyword == "United Arab Emirates" {
            if let data = try? ResourceLoader().loadSearch(resource: .mockSearch) {
                presenter?.itemsFetched(data)
            } else {
                presenter?.itemsFetchFailed(withError: ApiError.network(errorMessage: "DATA_NOT_LOAD"))
            }
            
        } else {
            presenter?.itemsFetchFailed(withError: ApiError.network(errorMessage: "NOT_FOUND"))
        }
    }
  
}
