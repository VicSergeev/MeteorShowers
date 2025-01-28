//
//  ViewController.swift
//  MeteorShowers
//
//  Created by Vic on 26.01.2025.
//

import UIKit
import SnapKit

final class MainViewController: UIViewController {
    
    // MARK: - Properties
    private let showers = Showers.shared.getAllShowers()
    
    // MARK: - Main stack
    private lazy var mainStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
    
    // MARK: - creating view with uiview extension
    private lazy var topView: TopView = .fromNib()
    
    // MARK: - UITableView
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .clear
        table.separatorStyle = .none
        table.showsVerticalScrollIndicator = false
        return table
    }()

    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .mainBg
        setupUI()
        
        if let currentShower = Showers.shared.getCurrentShower() {
            // Configure top view with current shower
            // TODO: Add configuration method to TopView
        }
    }
}

// MARK: - Configuring UI
private extension MainViewController {
    
    func setupUI() {
        setDelegates()
        
        view.addSubview(mainStackView)
        mainStackView.addArrangedSubview(topView)
        mainStackView.addArrangedSubview(tableView)
        
        // MARK: - Cell registration
        tableView.register(MeteorShowerTableViewCell.self, forCellReuseIdentifier: "MeteorShowerTableViewCell")
        
        // constraints
        mainStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        
        topView.snp.makeConstraints { make in
            make.height.equalTo(100)
        }
        
        tableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
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
        return showers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MeteorShowerTableViewCell", for: indexPath) as! MeteorShowerTableViewCell
        let shower = showers[indexPath.row]
        cell.configure(with: shower)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
