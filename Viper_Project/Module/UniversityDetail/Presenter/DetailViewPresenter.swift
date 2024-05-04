//
//  DetailViewPresenter.swift
//  Viper_Project
//
//  Created by Sheikh Ali on 03/05/2024.
//

import Foundation
import UIKit

protocol DetailPresenterInterface: AnyObject {
    func viewDidLoad()
    func backButtonPressed(from view: UIViewController)
}

class DetailViewPresenter: DetailPresenterInterface {

    weak var view: DetailViewInterface?
    var router: DetailViewRouter?
    
    var universityDetail: UniversityEntity?
    
    func viewDidLoad() {
        if let universityDetail = universityDetail {
            view?.showUniversityDetail(with: universityDetail)
        }
    }
    
    func backButtonPressed(from view: UIViewController) {
        
    }
}
