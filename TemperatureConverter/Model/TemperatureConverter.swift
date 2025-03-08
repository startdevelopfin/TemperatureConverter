//
//  that.swift
//  TemperatureConverter
//
//  Created by Dan Aupont on 3/8/25.
//


import SwiftUI

/// A class that provides temperature conversion functionality.
final class TemperatureConverter: TemperatureConvertible {
    /// Shared instance for using the temperature converter throughout the app.
    static let shared = TemperatureConverter()
    
    /// Private initializer for singleton pattern.
    private init() {}
    
    /// Converts a temperature value from one unit to another.
    /// - Parameters:
    ///   - value: The temperature value to convert as a string.
    ///   - fromUnit: The unit of the input temperature.
    ///   - toUnit: The unit to convert the temperature to.
    /// - Returns: The converted temperature value.
    /// - Throws: `TemperatureError.invalidInput` if the provided value is not a valid number.
    func convert(_ value: String, from fromUnit: TemperatureUnit, to toUnit: TemperatureUnit) throws -> Double {
        // If input and output units are the same, return the original value
        if fromUnit == toUnit, let doubleValue = Double(value) {
            return doubleValue
        }
        
        guard let inputValue = Double(value) else {
            throw TemperatureError.invalidInput
        }
        
        // Convert to celsius first (base unit for conversion)
        let valueInCelsius = toCelsius(inputValue, from: fromUnit)
        
        // Then convert from celsius to the desired output unit
        return fromCelsius(valueInCelsius, to: toUnit)
    }
    
    /// Formats a temperature value with the specified number of decimal places.
    /// - Parameters:
    ///   - value: The temperature value to format.
    ///   - decimalPlaces: The number of decimal places to include (default is 2).
    /// - Returns: A formatted string representation of the temperature.
    func formatTemperature(_ value: Double, decimalPlaces: Int = 2) -> String {
        return String(format: "%.\(decimalPlaces)f", value)
    }
    
    // MARK: - Private Helpers
    
    /// Converts a temperature from any unit to Celsius.
    /// - Parameters:
    ///   - value: The temperature value to convert.
    ///   - unit: The unit of the temperature value.
    /// - Returns: The temperature value in Celsius.
    private func toCelsius(_ value: Double, from unit: TemperatureUnit) -> Double {
        switch unit {
        case .celsius:
            return value
        case .fahrenheit:
            return (value - 32) * 5 / 9
        case .kelvin:
            return value - 273.15
        }
    }
    
    /// Converts a temperature from Celsius to another unit.
    /// - Parameters:
    ///   - value: The temperature value in Celsius.
    ///   - unit: The unit to convert the temperature to.
    /// - Returns: The converted temperature value.
    private func fromCelsius(_ value: Double, to unit: TemperatureUnit) -> Double {
        switch unit {
        case .celsius:
            return value
        case .fahrenheit:
            return (value * 9 / 5) + 32
        case .kelvin:
            return value + 273.15
        }
    }
}