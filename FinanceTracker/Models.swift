//
//  Models.swift
//  FinanceTracker
//
//  Created by Smit Desai on 4/5/25.
//

import SwiftUI
import SwiftData

@Model
class FinancialEntry {
    var date: Date
    var income: Double
    var savings: Double
    var expenses: [Expense]
    
    init(date: Date, income: Double, savings: Double, expenses: [Expense] = []) {
        self.date = date
        self.income = income
        self.savings = savings
        self.expenses = expenses
    }
    
    var totalExpenses: Double {
        expenses.reduce(0) { $0 + $1.amount }
    }
    
    var dayString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter.string(from: date)
    }
    
    var monthDayString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd"
        return formatter.string(from: date)
    }
}

@Model
class Expense {
    var amount: Double
    var category: ExpenseCategory
    
    init(amount: Double, category: ExpenseCategory) {
        self.amount = amount
        self.category = category
    }
}

enum ExpenseCategory: String, Codable, CaseIterable {
    case food = "Food"
    case entertainment = "Entertainment"
    case transportation = "Transportation"
    case rentMortgage = "Rent/Mortgage"
    case miscellaneous = "Miscellaneous"
    
    var icon: String {
        switch self {
        case .food:
            return "fork.knife"
        case .entertainment:
            return "tv"
        case .transportation:
            return "car"
        case .rentMortgage:
            return "house"
        case .miscellaneous:
            return "ellipsis.circle"
        }
    }
}
