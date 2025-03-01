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
                inputField()
                unitPicker(title: "From:", selection: $selectedInputUnit)
                unitPicker(title: "To:", selection: $selectedOutputUnit)
                convertedTemperatureView()
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
    
    // MARK: - View Builder
    
    /// A view that displays an input field for entering the temperature value.
    /// The field allows only decimal input and provides helpful accessibility hints for users.
    ///
    /// - Returns: A `TextField` view that allows the user to input a temperature.
    @ViewBuilder
    private func inputField() -> some View {
        TextField("Enter temperature", text: $inputTemperature)
            .keyboardType(.decimalPad)
            .padding()
            .background(Color.gray.opacity(0.2))
            .cornerRadius(8)
            .accessibilityLabel("Temperature input field")
            .accessibilityHint("Enter a numerical value to be converted")
            .accessibilityValue(inputTemperature)
    }

    /// A view that displays a segmented picker to select the temperature unit.
    /// The picker allows users to choose between different temperature units such as Celsius, Fahrenheit, etc.
    ///
    /// - Parameters:
    ///   - title: The title displayed above the picker.
    ///   - selection: A binding to the selected temperature unit.
    @ViewBuilder
    private func unitPicker(title: String, selection: Binding<TemperatureUnit>) -> some View {
        HStack {
            Text(title)
                .fontWeight(.semibold)
            Picker(title, selection: selection) {
                ForEach(TemperatureUnit.allCases) { unit in
                    Text(unit.rawValue).tag(unit)  // Use tag for binding
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .accessibilityLabel(title)
            .accessibilityHint("Select temperature unit")
        }
        .padding(.horizontal)
    }

    /// A view that displays the converted temperature value.
    /// The value is shown in a title-sized font and is updated based on the selected temperature unit.
    ///
    /// - Returns: A `Text` view displaying the converted temperature.
    @ViewBuilder
    private func convertedTemperatureView() -> some View {
        Text("Converted Temperature: \(convertedTemperature) \(selectedOutputUnit.abbreviation)")
            .font(.title3)
            .fontWeight(.medium)
            .padding()
            .monospacedDigit()
            .contentTransition(.numericText())
            .accessibilityLabel("Converted temperature")
            .accessibilityValue("\(convertedTemperature) \(selectedOutputUnit.abbreviation)")
            .accessibilityHint("Displays the converted temperature based on the selected units")
    }
}


#Preview {
    TemperatureConverterView()
}
