//
//  TemperatureConverterView.swift
//  TemperatureConverter
//
//  Created by Dan Aupont on 2/28/25.
//

import SwiftUI

struct TemperatureConverterView: View {
    // MARK: - State Properties
    
    /// The user's input temperature as a string.
    @State private var inputTemperature: String = ""
    
    /// The selected input temperature unit.
    @State private var selectedInputUnit: TemperatureUnit = .celsius
    
    /// The selected output temperature unit.
    @State private var selectedOutputUnit: TemperatureUnit = .fahrenheit
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Input Field
                TextField("Enter temperature", text: $inputTemperature)
                    .keyboardType(.decimalPad)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                    .accessibilityLabel("Temperature input field")
                    .accessibilityHint("Enter a numerical value to be converted")
                    .accessibilityValue(inputTemperature)
                
                // From Unit Picker
                HStack {
                    Text("From")
                        .fontWeight(.semibold)
                    Picker("From:", selection: $selectedInputUnit) {
                        ForEach(TemperatureUnit.allCases) { unit in
                            Text(unit.rawValue).tag(unit)  // Use tag for binding
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .accessibilityLabel("From")
                    .accessibilityHint("Select temperature unit")
                }
                .padding(.horizontal)
                
                // To Unit Picker
                HStack {
                    Text("To")
                        .fontWeight(.semibold)
                    Picker("To:", selection: $selectedOutputUnit) {
                        ForEach(TemperatureUnit.allCases) { unit in
                            Text(unit.rawValue).tag(unit)  // Use tag for binding
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .accessibilityLabel("To")
                    .accessibilityHint("Select temperature unit")
                }
                .padding(.horizontal)
                
                // Converted Temperature
                Text("Converted Temperature: \(convertedTemperature) \(selectedOutputUnit.abbreviation)")
                    .font(.title3)
                    .fontWeight(.medium)
                    .padding()
                    .monospacedDigit()
                    .contentTransition(.numericText())
                    .accessibilityLabel("Converted temperature")
                    .accessibilityValue("\(convertedTemperature) \(selectedOutputUnit.abbreviation)")
                    .accessibilityHint("Displays the converted temperature based on the selected units")
                
                Spacer()
            }
            .padding()
            .navigationTitle("Temperature Converter")
        }
    }
    
    // MARK: - Functions
    
    /// Converts a given temperature from one unit to another.
    /// - Parameters:
    ///   - input: The temperature value to convert.
    ///   - fromUnit: The selected input unit.
    ///   - toUnit: The selected output unit.
    ///
    /// - Returns: The converted temperature as a formatted string.
    private func convertTemperature(_ input: String, from fromUnit: TemperatureUnit, to toUnit: TemperatureUnit) -> String {
        guard let inputValue = Double(input) else { return "0.0" }
        var valueInCelsius: Double
        
        // Convert input temperature to Celsius first
        switch fromUnit {
        case .celsius: valueInCelsius = inputValue
        case .fahrenheit: valueInCelsius = (inputValue - 32) * 5 / 9
        case .kelvin: valueInCelsius = inputValue - 273.15
        }
        
        var outputValue: Double
        
        // Convert from Celsius to the desired output unit
        switch toUnit {
        case .celsius: outputValue = valueInCelsius
        case .fahrenheit: outputValue = (valueInCelsius * 9 / 5) + 32
        case .kelvin: outputValue = valueInCelsius + 273.15
        }
        
        return String(format: "%.2f", outputValue)
    }
    
    // MARK: - Computed Properties
    
    /// The converted temperature based on the selected units.
    var convertedTemperature: String {
        convertTemperature(inputTemperature, from: selectedInputUnit, to: selectedOutputUnit)
    }
}


#Preview {
    TemperatureConverterView()
}

