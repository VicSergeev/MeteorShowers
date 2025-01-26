//
//  ViewController.swift
//  MeteorShowers
//
//  Created by Vic on 26.01.2025.
//

import UIKit
import SnapKit

final class MainViewController: UIViewController {
    
    // MARK: - Setting UI
    
    // MARK: - Main stack
    lazy private var mainStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .fill
        stackView.distribution = .fill // that will accept topView height of 200 and let TV to get the rest of space
        
        return stackView
    }()
    
    // MARK: - creating view with uiview extension
    lazy var topView: TopView = .fromNib()
    
    
    // MARK: - UITableView
    var tableView = UITableView()

    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.title = "Meteor showers"
        setupUI()
    }


}

// MARK: - Configuring UI

private extension MainViewController {
    
    func setupUI() {
        setDelegates()
        
        view.addSubview(mainStackView)
        mainStackView.addArrangedSubview(topView)
        mainStackView.addArrangedSubview(tableView)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        // constraints
        mainStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-16)
        }
        
        topView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(200) // constraint topview height
            make.width.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom) // stick top of TV to the bottom of topView
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview() // let TV to get the rest of space
        }
        
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
    }

}
