//
//  ViewController.swift
//  MeteorShowers
//
//  Created by Vic on 26.01.2025.
//

import UIKit
import SnapKit

final class MainViewController: UIViewController {
    
    // MARK: - UITableView
    var tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
    }


}

// MARK: - Configuring UITableView

private extension MainViewController {
    func tableViewConfig() {
        setDelegates()
        view.addSubview(tableView)
        
        
        
    }
}

// MARK: - UITableViewDelegates

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func setDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }

}
