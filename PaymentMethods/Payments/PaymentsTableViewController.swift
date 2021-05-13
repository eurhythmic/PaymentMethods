//
//  PaymentsTableViewController.swift
//  PaymentMethods
//
//  Created by RnD on 5/11/21.
//

import UIKit
import Combine

class PaymentsTableViewController: UITableViewController {
    var paymentsViewModel = PaymentsViewModel()
    private var subscriptions = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Payment methods"
        
        paymentsViewModel.loadPayments()
        
        // Reload table view upon receiving data
        paymentsViewModel.results
            .receive(on: DispatchQueue.main)
            .sink { [unowned self] _ in
                self.tableView.reloadData()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    self.tableView.reloadData()
                }
            }
            .store(in: &subscriptions)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return paymentsViewModel.results.value.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PaymentsCell", for: indexPath)
        let results = paymentsViewModel.results.value[indexPath.row]
        cell.imageView?.getImage(from: results.links.logo)
        cell.textLabel?.text = results.label

        return cell
    }

}
