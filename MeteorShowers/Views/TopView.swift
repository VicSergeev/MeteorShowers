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
        
        self.clipsToBounds = true // just in case, because in XIB this setting marked as checked
        
        // setting border radius
        self.layer.cornerRadius = 9
        self.layer.masksToBounds = true
    }
}
