//
//  Enum.swift
//  TemperatureConverter
//
//  Created by Dan Aupont on 2/28/25.
//

import SwiftUI

/// Represents the different temperature units supported in the converter.
enum TemperatureUnit: String, CaseIterable, Identifiable {
    case celsius = "Celsius"
    case fahrenheit = "Fahrenheit"
    case kelvin = "Kelvin"
    
    /// The abbreviation for each temperature unit.
    var abbreviation: String {
        switch self {
        case .celsius:
            return "°C"
        case .fahrenheit:
            return "°F"
        case .kelvin:
            return "K"
        }
    }
    
    var id: String { rawValue }
}

