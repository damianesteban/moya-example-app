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
        viewModel?.fetchAndUpdateColors() { state in
            self.update(state: state)
//            async {
//                self.update(state: state)
//                print("fetched")
//            }
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
    
    func update(state newState: UIState) {
        print("Updating state.....")
        switch state {
        case .loading:
            printState(state: state)
            loadingView()
        case .success:
            printState(state: state)
            viewForSuccess()
        case .failure(_):
            printState(state: state)
            viewForFailure()
        }
    }
    
    func printState(state: UIState) {
        print("Did update state to: \(state)")
    }
    
    func loadingView() {
       self.displayActivityHUD()
    }
    
    func viewForSuccess() {
        self.hideActivityIndicator()
        self.tableView.reloadData()
    }
    
    func viewForFailure() {
        async {
        self.hideActivityIndicator()
        self.displayTextErrorHUD()
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

func async(block: @escaping () -> Void) {
    DispatchQueue.main.async {
        block()
    }
}
