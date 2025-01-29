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
    lazy private var mainStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .fill
        stackView.distribution = .fill
        
        return stackView
    }()
    
    // MARK: - Main stack
    lazy private var contentStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .fill
        stackView.distribution = .fill
        
        return stackView
    }()
    
    lazy private var titleLabel: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    lazy private var mainImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(systemName: "moon")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy private var notificationIcon: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(systemName: "bell.fill")
        imageView.tintColor = .systemGreen
        imageView.contentMode = .scaleAspectFit
        imageView.snp.makeConstraints { make in
            make.height.width.equalTo(24)
        }
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

}

extension ShowerDetailViewController {
    func setupUI() {
        view.addSubview(mainStackView)
        
        mainStackView.addArrangedSubview(titleLabel)
        mainStackView.addArrangedSubview(notificationIcon)
        mainStackView.addArrangedSubview(contentStackView)
        
        contentStackView.addArrangedSubview(mainImageView)
        
        
        mainImageView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
        
        contentStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().offset(12)
        }
    }
}
