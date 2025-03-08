//
//  TemperatureRecord.swift
//  TemperatureConverter
//
//  Created by Dan Aupont on 3/8/25.
//


import SwiftUI

/// Represents a temperature conversion record.
struct TemperatureRecord: Identifiable {
    /// Unique identifier for the record.
    let id = UUID()
    
    /// The original temperature value entered by the user.
    let inputValue: String
    
    /// The unit of the input temperature.
    let fromUnit: TemperatureUnit
    
    /// The unit of the output temperature.
    let toUnit: TemperatureUnit
    
    /// The converted temperature value.
    let result: String
    
    /// The date and time when the conversion was performed.
    let timestamp: Date = Date()
    
    /// Formatted timestamp for display purposes.
    var formattedTimestamp: String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: timestamp)
    }
}