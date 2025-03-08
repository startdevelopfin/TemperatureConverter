//
//  Enum.swift
//  TemperatureConverter
//
//  Created by Dan Aupont on 2/28/25.
//

import SwiftUI

// MARK: - Temperature Conversion Protocol

/// Protocol defining temperature conversion capabilities.
protocol TemperatureConvertible {
    /// Converts a temperature from one unit to another.
    /// - Parameters:
    ///   - value: The temperature value to convert.
    ///   - fromUnit: The unit of the input temperature.
    ///   - toUnit: The unit to convert the temperature to.
    /// - Returns: The converted temperature value.
    /// - Throws: `TemperatureError.invalidInput` if the provided value is not a valid number.
    func convert(_ value: String, from fromUnit: TemperatureUnit, to toUnit: TemperatureUnit) throws -> Double
    
    /// Formats a temperature value according to the given specifications.
    /// - Parameters:
    ///   - value: The temperature value to format.
    ///   - decimalPlaces: The number of decimal places to include in the formatted string.
    /// - Returns: A formatted string representation of the temperature.
    func formatTemperature(_ value: Double, decimalPlaces: Int) -> String
}

// MARK: - Temperature Unit Enum

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

// MARK: - Temperature Error

/// Errors that can occur during temperature conversion.
enum TemperatureError: Error {
    case invalidInput
    
    /// User-friendly error description.
    var localizedDescription: String {
        switch self {
        case .invalidInput:
            return "Please enter a valid number for the temperature."
        }
    }
}


// MARK: - Temperature Validator Extension

extension String {
    /// Checks if the string can be converted to a valid Double.
    var isValidTemperature: Bool {
        return Double(self) != nil
    }
}
