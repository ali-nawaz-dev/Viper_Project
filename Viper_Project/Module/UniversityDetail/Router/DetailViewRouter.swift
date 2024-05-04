//
//  DetailViewRouter.swift
//  Viper_Project
//
//  Created by Sheikh Ali on 03/05/2024.
//

import Foundation
import UIKit

protocol DetailRouterProtocol: AnyObject {
    func goBackToListView(from view: UIViewController)
}

class DetailViewRouter: DetailRouterProtocol {
   
    func goBackToListView(from view: UIViewController) {
        
    }
    
    static func createDetailModule(university: UniversityEntity) -> DetailViewController {
      
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: .main)
        let detailView = mainStoryBoard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        detailView.presenter = DetailViewPresenter()
        detailView.presenter?.view = detailView
        detailView.presenter?.router = DetailViewRouter()
        detailView.presenter?.universityDetail = university
        
        
        return detailView
    }
}
