//
//  TemperatureConverterView2.swift
//  TemperatureConverter
//
//  Created by Dan Aupont on 3/8/25.
//


import SwiftUI

struct TemperatureConverterView2: View {
    // MARK: - State Properties
    
    /// The user's input temperature as a string.
    @State private var inputTemperature: String = ""
    
    /// The selected input temperature unit.
    @State private var selectedInputUnit: TemperatureUnit = .celsius
    
    /// The selected output temperature unit.
    @State private var selectedOutputUnit: TemperatureUnit = .fahrenheit
    
    /// Controls the display of the history sheet.
    @State private var showingHistory = false
    
    /// Error message to display if conversion fails.
    @State private var errorMessage: String? = nil
    
    /// Controls the display of the error alert.
    @State private var showingError = false
    
    /// Number of decimal places to display in the result.
    @State private var decimalPlaces: Int = 2
    
    /// Observable object for managing conversion history.
    @StateObject private var historyManager = HistoryManager()
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                inputField()
                unitPicker(title: "From:", selection: $selectedInputUnit)
                unitPicker(title: "To:", selection: $selectedOutputUnit)
                
                // Decimal places picker
                HStack {
                    Text("Precision:")
                        .fontWeight(.semibold)
                    Picker("Decimal Places", selection: $decimalPlaces) {
                        ForEach(0...4, id: \.self) { places in
                            Text("\(places)").tag(places)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                .padding(.horizontal)
                
                convertedTemperatureView()
                
                Button(action: {
                    convertAndSave()
                }) {
                    Text("Save Conversion")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding(.horizontal)
                .disabled(inputTemperature.isEmpty)
                
                Button(action: {
                    showingHistory = true
                }) {
                    HStack {
                        Image(systemName: "clock.arrow.circlepath")
                        Text("View History")
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.gray.opacity(0.2))
                    .foregroundColor(.blue)
                    .cornerRadius(8)
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .padding()
            .navigationTitle("Temperature Converter")
            .sheet(isPresented: $showingHistory) {
                historyView()
            }
            .alert(isPresented: $showingError) {
                Alert(
                    title: Text("Conversion Error"),
                    message: Text(errorMessage ?? "An unknown error occurred"),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
    
    // MARK: - Computed Properties
    
    /// The converted temperature based on the selected units.
    var convertedTemperature: String {
        do {
            // Use the TemperatureConverter class to convert the temperature
            let result = try TemperatureConverter.shared.convert(
                inputTemperature.isEmpty ? "0" : inputTemperature,
                from: selectedInputUnit,
                to: selectedOutputUnit
            )
            return TemperatureConverter.shared.formatTemperature(result, decimalPlaces: decimalPlaces)
        } catch {
            // Return a default value and don't show an error
            // Errors are only shown when explicitly attempting to save
            return "0"
        }
    }
    
    // MARK: - Actions
    
    /// Converts the temperature and saves the result to history.
    private func convertAndSave() {
        do {
            let result = try TemperatureConverter.shared.convert(
                inputTemperature,
                from: selectedInputUnit,
                to: selectedOutputUnit
            )
            
            let formattedResult = TemperatureConverter.shared.formatTemperature(result, decimalPlaces: decimalPlaces)
            
            // Create a new record and add it to history
            let record = TemperatureRecord(
                inputValue: inputTemperature,
                fromUnit: selectedInputUnit,
                toUnit: selectedOutputUnit,
                result: formattedResult
            )
            
            historyManager.addRecord(record)
        } catch TemperatureError.invalidInput {
            errorMessage = "Please enter a valid temperature."
            showingError = true
        } catch {
            errorMessage = "An unexpected error occurred."
            showingError = true
        }
    }
    
    // MARK: - View Builder
    
    /// A view that displays an input field for entering the temperature value.
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
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(inputTemperature.isEmpty ? Color.clear :
                            (inputTemperature.isValidTemperature ? Color.green : Color.red),
                            lineWidth: 2)
            )
    }

    /// A view that displays a segmented picker to select the temperature unit.
    @ViewBuilder
    private func unitPicker(title: String, selection: Binding<TemperatureUnit>) -> some View {
        HStack {
            Text(title)
                .fontWeight(.semibold)
            Picker(title, selection: selection) {
                ForEach(TemperatureUnit.allCases) { unit in
                    Text(unit.rawValue).tag(unit)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .accessibilityLabel(title)
            .accessibilityHint("Select temperature unit")
        }
        .padding(.horizontal)
    }

    /// A view that displays the converted temperature value.
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
    
    /// A view that displays the conversion history.
    @ViewBuilder
    private func historyView() -> some View {
        NavigationView {
            List {
                if historyManager.conversionHistory.isEmpty {
                    Text("No conversion history yet")
                        .foregroundColor(.gray)
                        .italic()
                } else {
                    ForEach(historyManager.conversionHistory) { record in
                        VStack(alignment: .leading, spacing: 5) {
                            Text("\(record.inputValue) \(record.fromUnit.abbreviation) → \(record.result) \(record.toUnit.abbreviation)")
                                .font(.headline)
                            Text("Converted at \(record.formattedTimestamp)")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
            .navigationTitle("Conversion History")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        historyManager.clearHistory()
                    }) {
                        Text("Clear")
                    }
                    .disabled(historyManager.conversionHistory.isEmpty)
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        showingHistory = false
                    }) {
                        Text("Done")
                    }
                }
            }
        }
    }
}
