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
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    TemperatureConverterView()
}
