//
//  ColorsViewController.swift
//  Example
//
//  Created by Damian Esteban on 11/20/16.
//  Copyright © 2016 betterPT. All rights reserved.
//

import UIKit
import RealmSwift

class ColorsViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Properties
    
    // Called when the user selects a color
    var didSelectColor: (RealmColorModel) -> Void = {_ in }
    
    var notifications: NotificationToken?
    var viewModel: ColorsListViewModel = {
        let realm = try! Realm()
        return ColorsListViewModel(realm: realm)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        // Whenever the ViewModel's didUpdate closure is called the tableView will reload data.
        notifications = viewModel.results.addNotificationBlock { [weak self] changes in
            guard let tableView = self?.tableView else {
                return
            }
            tableView.reloadData()
        }
        log
        // Do any additional setup after loading the view.
    }
}

// MARK: UITableViewDataSource Methods
extension ColorsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return viewModel.numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = viewModel.item(at: indexPath.row)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {
            fatalError("No cell available for reuse")
        }
        // Needs Implementation
        cell.textLabel?.text = item.name
        cell.detailTextLabel?.text = item.pantoneValue
        
        return cell
    }
}
