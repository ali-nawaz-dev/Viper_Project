//
//  ListRouter.swift
//  VIPER_Demo
//
//  Created by Sheikh Ali on 03/05/2024.
//

import Foundation
import UIKit

protocol ListRouterProtocol: AnyObject {
    func navigateToUniversityDetail(with university: UniversityEntity, from view: UIViewController)
}

class ListRouter: ListRouterProtocol {
    
    static func listViewController() -> ListViewController {
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: .main)
        let view: ListViewController = mainStoryBoard.instantiateViewController(withIdentifier: "ListViewController") as! ListViewController
        let presenter = ListPresenter()
        let interactor = ListInteractor()
        
        let router = ListRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
       
        return view
    }
    
    func navigateToUniversityDetail(with university: UniversityEntity, from view: UIViewController) {
        let detailView = DetailViewRouter.createDetailModule(university: university)
        view.navigationController?.pushViewController(detailView, animated: true)
    }
}
