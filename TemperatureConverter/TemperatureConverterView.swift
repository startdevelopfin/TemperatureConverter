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
    @State private var inputTemperature = ""
    /// The index of the selected input unit.
    @State private var selectedInputUnit = 0
    /// The index of the selected output unit.
    @State private var selectedOutputUnit = 1
    
    // MARK: - Constants
    
    /// Available temperature units.
    private let temperatureUnits = ["Celsius", "Fahrenheit", "Kelvin"]
    
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
    ///   - fromUnit: The index of the input unit (0 = Celsius, 1 = Fahrenheit, 2 = Kelvin).
    ///   - toUnit: The index of the output unit (0 = Celsius, 1 = Fahrenheit, 2 = Kelvin).
    /// - Returns: The converted temperature as a formatted string.
    private func convertTemperature(_ input: String, from fromUnit: Int, to toUnit: Int) -> String {
        let inputValue = Double(input) ?? 0
        let valueInCelsius: Double
        
        // Convert input temperature to Celsius first
        switch fromUnit {
        case 0: valueInCelsius = inputValue // Celsius
        case 1: valueInCelsius = (inputValue - 32) * 5 / 9 // Fahrenheit
        case 2: valueInCelsius = inputValue - 273.15 // Kelvin
        default: valueInCelsius = inputValue
        }
        
        let outputValue: Double
        
        // Convert from Celsius to the desired output unit
        switch toUnit {
        case 0: outputValue = valueInCelsius // Celsius
        case 1: outputValue = (valueInCelsius * 9 / 5) + 32 // Fahrenheit
        case 2: outputValue = valueInCelsius + 273.15 // Kelvin
        default: outputValue = valueInCelsius
        }
        
        return String(format: "%.2f", outputValue)
    }
    
    // MARK: - Computed Porerties
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
    ///   - selection: A binding to the selected index of the temperature unit.
    @ViewBuilder
    private func unitPicker(title: String, selection: Binding<Int>) -> some View {
        HStack {
            Text(title)
                .fontWeight(.semibold)
            Picker(title, selection: selection) {
                ForEach(0..<temperatureUnits.count, id: \.self) {
                    Text(temperatureUnits[$0])
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
        Text("Converted Temperature: \(convertedTemperature)")
            .font(.title2)
            .fontWeight(.medium)
            .padding()
            .accessibilityLabel("Converted temperature")
            .accessibilityValue("\(convertedTemperature) degrees")
            .accessibilityHint("Displays the converted temperature based on the selected units")
    }

}

#Preview {
    TemperatureConverterView()
}
