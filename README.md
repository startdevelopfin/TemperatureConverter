# 🌡️ Temperature Converter

A simple, intuitive SwiftUI app that converts temperatures between Celsius, Fahrenheit, and Kelvin. Designed with best practices in mind, this app provides a clean user interface, real-time conversion, and accessibility support.
<br></br>

## 📌 Features
- 🔄 **Instant Conversion**: Converts input temperature dynamically as you type.
- 🎚 **Three Supported Units**: Celsius, Fahrenheit, and Kelvin.
- 📱 **Intuitive UI**: Uses segmented pickers for unit selection.
- ♿ **Accessibility**: VoiceOver-friendly labels for better usability.
- 🎨 **SwiftUI Best Practices**: Uses `@State` for reactivity and follows Apple’s UI guidelines.
<br></br>

## 🚀 Getting Started
### Prerequisites
- Xcode 15 or later
- iOS 17 or later
<br></br>

### Installation
1. **Clone the repository:**
   ```sh
   git clone https://github.com/startdevelopfin/TemperatureConverter.git
   cd TemperatureConverter
   ```
2. **Open the project in Xcode:**
   ```sh
   open TemperatureConverter.xcodeproj
   ```
3. **Build and run the app:**
   - Select an iOS Simulator or device.
   - Press `Cmd + R` to run.
<br></br>

## 🏗️ Code Structure
### `TemperatureConverterView.swift`
- **State Management**: Stores user input and selected units.
- **Conversion Logic**: Converts input temperature to an intermediate Celsius value before converting to the selected output unit.
- **User Interface**: Uses `TextField`, `SegmentedPicker`, and `Text` for real-time conversion display.
<br></br>


## 🎨 UI Preview
| Input | Converted Output |
|-------|----------------|
| 100°C | 212°F / 373.15K |
| 32°F | 0°C / 273.15K |
| 273.15K | 0°C / 32°F |
<br></br>

## 📌 Roadmap
- [ ] Support for decimal separator localization
- [ ] Dark Mode support
- [ ] Haptic feedback on unit selection
<br></br>

## 📬 Contact
Have questions? Reach out via:
- Twitter: [@startdevelopfin](https://twitter.com/startdevelopfin)

---
Happy Coding! 🚀



