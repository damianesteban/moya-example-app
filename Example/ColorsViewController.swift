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
    
    var state: UIState = .loading {
        didSet {
            update(state: state)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        viewModel?.delegate = self
        // Fetches the objects from the server
        viewModel?.fetchAndUpdateColors() {

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
            presentLoadingView()
        case .success:
            printState(state: state)
            presentSuccessView()
        case .failure(_):
            printState(state: state)
            presentFailureView()
        }
    }
    
    func printState(state: UIState) {
        print("Did update state to: \(state)")
    }
    
    func presentLoadingView() {
       self.displayActivityHUD()
    }
    
    func presentSuccessView() {
        self.hideActivityIndicator()
        self.tableView.reloadData()
    }
    
    func presentFailureView() {
        self.displayTextErrorHUD()
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
