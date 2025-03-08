//
//  HistoryManager.swift
//  TemperatureConverter
//
//  Created by Dan Aupont on 3/8/25.
//


import SwiftUI

/// Manages a history of temperature conversions.
final class HistoryManager: ObservableObject {
    /// Published property that triggers a view update when the history changes.
    @Published private(set) var conversionHistory: [TemperatureRecord] = []
    
    /// Maximum number of history items to keep.
    private let maxHistoryItems = 10
    
    /// Adds a new conversion record to the history.
    /// - Parameter record: The conversion record to add.
    func addRecord(_ record: TemperatureRecord) {
        // Add new record to the beginning of the array
        conversionHistory.insert(record, at: 0)
        
        // Trim history if it exceeds the maximum limit
        if conversionHistory.count > maxHistoryItems {
            conversionHistory = Array(conversionHistory.prefix(maxHistoryItems))
        }
    }
    
    /// Clears all conversion history.
    func clearHistory() {
        conversionHistory.removeAll()
    }
}