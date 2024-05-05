//
//  ListViewController.swift
//  VIPER_Demo
//
//  Created by Sheikh Ali on 02/05/2024.
//

import UIKit

protocol ListViewProtocol: AnyObject {
    func prepareUI()
    func showItems(_ items: [UniversityEntity])
    func showError(_ error: ApiError)
}

class ListViewController: UIViewController, ListViewProtocol {
   
    weak var presenter: ListPresenter?
    private var universitiies: [UniversityEntity] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    func prepareUI() {
        presenter?.fetchItems(keyword: "United Arab Emirates")
        title = "Universities"
       
        tableView.register(ListTableViewCell.self, forCellReuseIdentifier: "ListTableViewCell")
              
    }
    
    func showItems(_ items: [UniversityEntity]) {
        universitiies = items
        tableView.reloadData()
    }
    
    func showError(_ error: ApiError) {
        let okAction = UIAlertAction(title: "OK",
                                     style: .default) { _ in
            print("OK button tapped")
        }
        
        let retryAction = UIAlertAction(title: "Retry",
                                        style: .default) { [weak self] _ in
            print("retry button tapped")
            self?.presenter?.fetchItems(keyword: "United Arab Emirates")
        }

        UIAlertController.showAlert(title: "Alert",
                                    message: error.localizedDescription,
                                    controller: self,
                                    actions: [okAction, retryAction]) {
            print("Alert dismissed")
        }
    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        universitiies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard 
            let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell",
                                                       for: indexPath) as? ListTableViewCell
        else {
            fatalError("Failed to dequeue CustomTableViewCell")
        }
        cell.titleLabel.text = universitiies[indexPath.row].name
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.itemsSelected(item: universitiies[indexPath.row], from: self)
    }
}
