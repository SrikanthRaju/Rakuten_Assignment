//
//  LaureatsListController.swift
//  Rakuten_Assignment
//
//  Created by Srikanth on 16/12/20.
//

import Foundation
import UIKit



class LaureatsListController: UIViewController {
    // MARK: Properties
    var viewModel: LaureatsListViewModal!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Layout Views
    private func configureUI() {
        self.tableView.tableFooterView = UIView()

        viewModel.reloadList = {
            
            self.tableView.reloadData()
        }
        
    }
    
}

extension LaureatsListController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.nobelLaureatsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LaureateCell", for: indexPath) as? LaureateCell else {
            return UITableViewCell()
        }
        
        let model = self.viewModel.nobelLaureats(at: indexPath.row)
        cell.configure(model)
        return cell
        
    }
    
    
}
