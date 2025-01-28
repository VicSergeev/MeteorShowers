//
//  MeteorShowerTableViewCell.swift
//  MeteorShowers
//
//  Created by Vic on 27.01.2025.
//

import UIKit
import SnapKit

final class MeteorShowerTableViewCell: UITableViewCell {
    
    // MARK: - UI Elements
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .topBg
        view.layer.cornerRadius = 9
        view.clipsToBounds = true
        return view
    }()
    
    // MARK: - Stacks
    private lazy var mainStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        
        return stack
    }()
    
    // used for info about shower
    private lazy var infoStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        
        return stack
    }()
    
    // dates inside info, inside this stack three labels
    private lazy var datesStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillEqually
        
        return stack
    }()
    
    // used for moon phase, img+zhr label
    private lazy var moonStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 16
        stack.distribution = .fillEqually
        
        return stack
    }()
    
    private lazy var originStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        
        return stack
    }()
    
    // MARK: - Labels
    // title
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .gray
        label.text = "Meteor Shower"
        return label
    }()
    
    // dates labels
    private lazy var datePeakLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .gray
        label.text = "Peak: TBD"
        return label
    }()
    
    private lazy var dateBeginLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .gray
        label.text = "Begins: TBD"
        return label
    }()
    
    private lazy var dateEndLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .gray
        label.text = "Ends: TBD"
        return label
    }()
    
    // moon image
    private lazy var moonIconImageView: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "moonphase.waxing.gibbous"))
        image.tintColor = .lightGray
        return image
    }()
    
    // ZHR label
    private lazy var ZHRLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        label.text = ""
        return label
    }()
    
    // Shower origin
    private lazy var originLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .boldSystemFont(ofSize: 12)
        label.numberOfLines = 2
        label.textColor = .lightGray
        label.text = "Comet"
        
        return label
    }()
    
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        backgroundColor = .clear
        selectionStyle = .none
        
        // filling screen with contents
        contentView.addSubview(containerView)
        containerView.addSubview(mainStackView)
        
        mainStackView.addArrangedSubview(titleLabel)
        mainStackView.addArrangedSubview(infoStackView)
        
        infoStackView.addArrangedSubview(datesStackView)
        infoStackView.addArrangedSubview(moonStackView)
        infoStackView.addArrangedSubview(originStackView)
        
        datesStackView.addArrangedSubview(dateBeginLabel)
        datesStackView.addArrangedSubview(datePeakLabel)
        datesStackView.addArrangedSubview(dateEndLabel)
        
        moonStackView.addArrangedSubview(moonIconImageView)
        moonStackView.addArrangedSubview(ZHRLabel)
        
        originStackView.addArrangedSubview(originLabel)
        
        // main container
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 4, left: 0, bottom: 4, right: 0))
        }
        
        // main stackview in main container
        mainStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
        }
        
        infoStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(12)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-12)
        }
    }
    
    // MARK: - Configure cell
    func configure(with shower: MeteorShower) {
        titleLabel.text = shower.name
        dateBeginLabel.text = "Begins: \(shower.formattedBeginDate)"
        datePeakLabel.text = "Peak: \(shower.formattedPeakDate)"
        dateEndLabel.text = "Ends: \(shower.formattedEndDate)"
        ZHRLabel.text = "ZHR: \(shower.zhr)"
        originLabel.text = """
        Origin body:
        \(shower.parentBody)
"""
    }
}
