//
//  ColorsViewController.swift
//  Example
//
//  Created by Damian Esteban on 11/20/16.
//  Copyright © 2016 betterPT. All rights reserved.
//

import UIKit
import RealmSwift

class ColorsViewController: UIViewController, UIStateDelegate {
    
    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Properties
    
    // Called when the user selects a color
    var didSelectColor: (ColorModel) -> Void = {_ in }
    
   // Realm NotificationToken
    var notifications: NotificationToken?
    
    // ViewModel
    var viewModel: ColorsListViewModel?
    
    var state: UIState = .loading

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        
        // Fetches the objects from the server
        viewModel?.fetchAndUpdateColors() { _ in
            print("fetched")
        }
        
        viewModel?.didUpdateState = { state in
            self.update(state: state)
            
        }
        // When the Realm Collection receives a notification the tableView is reloaded.
        // NOTE: This is only a basic example of what can be done with Realm notifications.
        notifications = viewModel?.results.addNotificationBlock { [weak self] changes in
            guard let tableView = self?.tableView else {
                return
            }
            tableView.reloadData()
        }
    }
    
    func update(state: UIState) {
        switch state {
        case .success:
            self.hideActivityIndicator()
            tableView.reloadData()
        case .loading:
            self.displayActivityHUD()
        case .failure(_):
            self.hideActivityIndicator()
            self.displayErrorHUD()
        }
    }
}

// MARK: UITableViewDataSource Methods
extension ColorsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else {
            fatalError("No viewmodel present")
        }
        return viewModel.numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = viewModel else {
            fatalError("No viewmodel present")
        }
        
        let item = viewModel.item(at: indexPath.row)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {
            fatalError("No cell available for reuse")
        }
        
        cell.textLabel?.text = item.name
        cell.detailTextLabel?.text = item.pantoneValue
        
        return cell
    }
}
