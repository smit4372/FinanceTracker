# Personal Finance Tracker

A SwiftUI app designed to help users track their daily finances, analyze spending habits, and gain insights into their financial health.

## Features

### 1. Enter Financial Data
- Input daily income, expenses, and savings
- Categorize expenses (Food, Entertainment, Transportation, Rent/Mortgage, Miscellaneous)
- Date selection for each entry
- Persistent storage using SwiftData

### 2. View My Finances
- Display financial summary for the last 7 days
- Visualize daily income, expenses, and savings with charts
- Review detailed breakdown of recent financial entries
- View expenses by category

### 3. How Am I Doing?
- Get personalized financial insights based on spending and saving habits
- Color-coded status indicators (green for saving well, yellow for balanced, red for overspending)
- Visualize expense breakdown with interactive pie charts
- Receive tailored financial tips based on your current status

## Architecture

This app follows the MVVM (Model-View-ViewModel) architecture:

- **Models**: `FinancialEntry` and `Expense` with SwiftData annotations
- **ViewModels**: `FinancialEntryViewModel` and `FinancialAnalysisViewModel`
- **Views**: `EnterFinancialDataView`, `ViewFinancesView`, and `FinancialInsightsView`

## Financial Analysis Metrics

The app analyzes your financial health using the following indicators:

- **Overspending**: If average daily expenses exceed 30% of income
- **Balanced Budget**: If average daily savings are between 10% to 30% of income
- **Saving Well**: If average daily savings exceed 30% of income

## Technology Stack

- SwiftUI for the user interface
- Swift Charts for data visualization
- SwiftData for persistent storage
- MVVM architecture pattern

## Screenshots

[Add screenshots of your app here]

## Requirements

- iOS 17.0+
- Xcode 15.0+
- Swift 5.9+

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/smit4372/FinanceTracker.git
   ```

2. Open the project in Xcode:
   ```bash
   cd FinanceTracker
   open hw2Smit.xcodeproj
   ```

3. Build and run the application on your iOS device or simulator.

## Usage

### Adding a New Financial Entry

1. Navigate to the "Enter Data" tab
2. Select the date for the entry
3. Enter your income and savings amounts
4. Add expenses by entering the amount and selecting a category
5. Tap "Save Financial Entry" to store your data

### Viewing Your Financial Data

1. Navigate to the "View Finances" tab
2. Review your 7-day financial summary in the bar chart
3. Scroll down to see detailed information for each day's entries

### Checking Your Financial Status

1. Navigate to the "How Am I Doing?" tab
2. View your overall financial status
3. Check the expense breakdown pie chart
4. Read the personalized financial tips based on your current status

## License

[Include license information here]

## Author

Smit Desai

## Acknowledgments

- Swift Charts documentation for visualization guidance
- SwiftData documentation for persistence implementation