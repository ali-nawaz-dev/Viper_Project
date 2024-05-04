//
//  DetailViewController.swift
//  Viper_Project
//
//  Created by Sheikh Ali on 03/05/2024.
//

import UIKit

protocol DetailViewInterface: AnyObject {
    func showUniversityDetail(with university: UniversityEntity)
}

class DetailViewController: UIViewController, DetailViewInterface {
  
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var webPageTextView: UITextView!
    
    var presenter: DetailViewPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    func showUniversityDetail(with university: UniversityEntity) {
        nameLabel.text = university.name
        countryLabel.text = university.country
        webPageTextView.text = university.webpages.first?.url 
    }
}
