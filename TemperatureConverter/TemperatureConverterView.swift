//
//  TemperatureConverterView.swift
//  TemperatureConverter
//
//  Created by Dan Aupont on 2/28/25.
//

import SwiftUI

struct TemperatureConverterView: View {
    
    /// The user's input temperature as a string.
    @State private var inputTemperature = ""
    /// The index of the selected input unit.
    @State private var selectedInputUnit = 0
    /// The index of the selected output unit.
    @State private var selectedOutputUnit = 1
    
    /// Available temperature units.
    private let temperatureUnits = ["Celsius", "Fahrenheit", "Kelvin"]
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Temperature Converter")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top)
            
            TextField("Enter temperature", text: $inputTemperature)
                .keyboardType(.decimalPad)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .accessibilityLabel("Temperature input field")
            
            // Input unit selection
            HStack {
                Text("From:")
                    .fontWeight(.semibold)
                Picker("Input Unit", selection: $selectedInputUnit) {
                    ForEach(0..<temperatureUnits.count, id: \..self) {
                        Text(temperatureUnits[$0])
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            .padding(.horizontal)
            
            // Output unit selection
            HStack {
                Text("To:")
                    .fontWeight(.semibold)
                Picker("Output Unit", selection: $selectedOutputUnit) {
                    ForEach(0..<temperatureUnits.count, id: \..self) {
                        Text(temperatureUnits[$0])
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            .padding(.horizontal)
            
            // Display converted temperature
            Text("Converted Temperature: ")
                .font(.title2)
                .fontWeight(.medium)
                .padding()
                .accessibilityLabel("Converted temperature result")
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    TemperatureConverterView()
}
