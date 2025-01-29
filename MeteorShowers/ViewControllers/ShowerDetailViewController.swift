//
//  ShowerDetailViewController.swift
//  MeteorShowers
//
//  Created by Vic on 29.01.2025.
//

import UIKit
import SnapKit

final class ShowerDetailViewController: UIViewController {
    
    // MARK: - Main stack
    lazy private var stackView: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .fill
        stackView.distribution = .fill
        
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

}
