//
//  MeteorShower.swift
//  MeteorShowers
//
//  Created by Vic on 26.01.2025.
//

import Foundation

struct MeteorShower {
    let name: String
    let dateBegin: Date
    let datePeak: Date
    let dateEnd: Date
    let zhr: Int
    let parentBody: String
    // optionally you might add average speed of bolids
    
    // Formatted string getters
    var formattedBeginDate: String {
        dateBegin.formatted(date: .abbreviated, time: .omitted)
    }
    
    var formattedPeakDate: String {
        datePeak.formatted(date: .abbreviated, time: .omitted)
    }
    
    var formattedEndDate: String {
        dateEnd.formatted(date: .abbreviated, time: .omitted)
    }
    
    var formattedZHR: String {
        "ZHR: \(zhr)"
    }
}
