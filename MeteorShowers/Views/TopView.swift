//
//  TopTableView.swift
//  MeteorShowers
//
//  Created by Vic on 26.01.2025.
//

import UIKit

final class TopView: UIView {
    
    // MARK: - Properties
    private let moonPhaseCalculator = MoonPhaseCalculation()

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
        
        self.clipsToBounds = true // just in case, because in XIB this setting marked as checked
        
        // setting border radius
        self.layer.cornerRadius = 9
        self.layer.masksToBounds = true
        
        // Update moon phase for current date
        let moonInfo = moonPhaseCalculator.getMoonPhase()
        updateMoonPhaseUI(with: moonInfo)
    }
    
    // MARK: - Private Methods
    private func updateMoonPhaseUI(with moonInfo: (phase: String, illumination: Double, age: Double)) {
        // Set moon phase label
        moonPhaseLabel.text = moonInfo.phase
        
        // Set illumination with 1 decimal place
        IlluminationLabel.text = String(format: "%.1f%%", moonInfo.illumination)
        
        // Set moon phase icon
        if let moonPhase = MoonPhase.allCases.first(where: { $0.rawValue == moonInfo.phase }) {
            moonPhaseIconImageView.image = moonPhase.icon
            moonPhaseIconImageView.tintColor = .lightGray
        }
    }
}
