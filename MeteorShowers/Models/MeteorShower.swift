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
    let speed: Int // optional you might add this value, but it's average, I don't see any point off adding it
    let parentBody: String
    
    // Formatted string getters
    var formattedBeginDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        return formatter.string(from: dateBegin)
    }
    
    var formattedPeakDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        return formatter.string(from: datePeak)
    }
    
    var formattedEndDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        return formatter.string(from: dateEnd)
    }
    
    var parentBodyLabel: String {
        """
 Parent body: 
 \(parentBody)
"""
    }
    
    var formattedZHR: String {
        "ZHR: \(zhr)"
    }
}
