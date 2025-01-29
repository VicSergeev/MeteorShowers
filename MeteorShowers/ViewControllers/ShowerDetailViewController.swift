//
//  ShowerDetailViewController.swift
//  MeteorShowers
//
//  Created by Vic on 29.01.2025.
//

import UIKit
import SnapKit

final class ShowerDetailViewController: UIViewController {
    
    // Add moonPhaseCalculator property
    private let moonPhaseCalculator = MoonPhaseCalculation()
    
    // MARK: - Main stack
    lazy private var mainStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .fill
        stackView.distribution = .fill
        
        return stackView
    }()
    
    // MARK: - content stack
    lazy private var contentStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .fill
        stackView.distribution = .fill
        
        return stackView
    }()
    
    // MARK: - contents
    lazy private var titleLabel: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .lightGray
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
    
    lazy private var peakLabel: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    lazy private var ZHRLabel: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    lazy private var originLabel: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    lazy private var moonPhaseIcon: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(systemName: "moon")
        imageView.tintColor = .lightGray
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    
    // MARK: - life cycle method
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .topBg
        setupUI()
    }

}

// MARK: - Setup UI
extension ShowerDetailViewController {
    func setupUI() {
        view.addSubview(mainStackView)
        
        mainStackView.addArrangedSubview(titleLabel)
        mainStackView.addArrangedSubview(notificationIcon)
        mainStackView.addArrangedSubview(contentStackView)
        
        contentStackView.addArrangedSubview(mainImageView)
        contentStackView.addArrangedSubview(peakLabel)
        contentStackView.addArrangedSubview(ZHRLabel)
        contentStackView.addArrangedSubview(originLabel)
        contentStackView.addArrangedSubview(moonPhaseIcon)
        
        mainStackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        mainImageView.snp.makeConstraints { make in
            make.height.equalTo(200)
        }
        
        moonPhaseIcon.snp.makeConstraints { make in
            make.height.width.equalTo(48)
            make.centerX.equalToSuperview()
        }
    }
}

// MARK: - Fill with contents

extension ShowerDetailViewController {
    func configure(with shower: MeteorShower) {
        titleLabel.text = shower.name
//        dateBeginLabel.text = "Begins: \(shower.formattedBeginDate)"
        peakLabel.text = "Peak: \(shower.formattedPeakDate)"
//        dateEndLabel.text = "Ends: \(shower.formattedEndDate)"
        ZHRLabel.text = "\(shower.formattedZHR)"
        originLabel.text = "\(shower.parentBodyLabel)"
        
        // Calculate moon phase for shower's peak date
        let moonPhase = moonPhaseCalculator.getMoonPhase(date: shower.datePeak)
        if let phase = MoonPhase(rawValue: moonPhase.phase) {
            moonPhaseIcon.image = phase.icon
        }
    }
}
