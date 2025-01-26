//
//  TopTableView.swift
//  MeteorShowers
//
//  Created by Vic on 26.01.2025.
//

import UIKit

final class TopView: UIView {

    // MARK: - UIs
    @IBOutlet weak var sunriseTimeLabel: UILabel!
    @IBOutlet weak var sunsetTimeLabel: UILabel!
    
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var forecastIconImageView: UIImageView!
    
    @IBOutlet weak var moonPhaseIconImageView: UIImageView!
    @IBOutlet weak var IlluminationLabel: UILabel!
    @IBOutlet weak var moonPhaseLabel: UILabel!
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.clipsToBounds = true
        
        // Настройка скругления углов
        self.layer.cornerRadius = 9
        self.layer.masksToBounds = true
        
        // Configure SF Symbols
        configureImageViews()
    }
    
    private func configureImageViews() {
        // Configure forecast icon
        if let forecastIcon = UIImage(systemName: "cloud.sun.fill") {
            forecastIconImageView.image = forecastIcon
            forecastIconImageView.contentMode = .scaleAspectFit
            forecastIconImageView.tintColor = .systemBlue
        }
        
        // Configure moon phase icon
        if let moonPhaseIcon = UIImage(systemName: "moonphase.waning.crescent.inverse") {
            moonPhaseIconImageView.image = moonPhaseIcon
            moonPhaseIconImageView.contentMode = .scaleAspectFit
            moonPhaseIconImageView.tintColor = .systemBlue
        }
    }
}
