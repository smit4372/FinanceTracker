//
//  ViewModels.swift
//  FinanceTracker
//
//  Created by Smit Desai on 4/5/25.
//

import SwiftUI
import SwiftData
import Combine

class FinancialEntryViewModel: ObservableObject {
    @Published var date = Date()
    @Published var income: String = ""
    @Published var savings: String = ""
    @Published var expenseAmount: String = ""
    @Published var selectedCategory: ExpenseCategory = .food
    @Published var expenses: [Expense] = []
        
    func addExpense() {
        guard let amount = Double(expenseAmount), amount > 0 else { return }
        
        let expense = Expense(amount: amount, category: selectedCategory)
        expenses.append(expense)
        expenseAmount = ""
        selectedCategory = .food
    }
    
    func removeExpense(at offsets: IndexSet) {
        expenses.remove(atOffsets: offsets)
    }
    
    func saveEntry(using modelContext: ModelContext) -> Bool {
        guard let incomeValue = Double(income), incomeValue >= 0 else { return false }
        guard let savingsValue = Double(savings), savingsValue >= 0 else { return false }
        guard !expenses.isEmpty else { return false }
        
        let entry = FinancialEntry(
            date: date,
            income: incomeValue,
            savings: savingsValue,
            expenses: expenses
        )
        
        modelContext.insert(entry)
        
        do {
            try modelContext.save()
            resetForm()
            return true
        } catch {
            print("Error saving data: \(error)")
            return false
        }
    }
    
    private func resetForm() {
        date = Date()
        income = ""
        savings = ""
        expenses = []
    }
}

class FinancialAnalysisViewModel: ObservableObject {
    @Published var entries: [FinancialEntry] = []
    @Published var hasData: Bool = false
    
    
    // getting the data for last 7 das
    func fetchLastSevenDays(modelContext: ModelContext) {
        let descriptor = FetchDescriptor<FinancialEntry>(
            sortBy: [SortDescriptor(\.date, order: .reverse)]
        )
        
        do {
            let allData = try modelContext.fetch(descriptor)
            
            // last 7 days
            let cal = Calendar.current
            let today = cal.startOfDay(for: Date())
            
            let entrisForSevendays = allData.filter { entry in
                let entryDate = cal.startOfDay(for: entry.date)
                if let difference = cal.dateComponents([.day], from: entryDate, to: today).day {
                    return difference < 7
                }
                return false
            }
            
            self.entries = entrisForSevendays
            self.hasData = !entrisForSevendays.isEmpty
            
        } catch {
            print("Error fetching data: \(error)")
            self.entries = []
            self.hasData = false
        }
    }
    
    
    
    // calculations and output based on expenses and savings
    var financialStatus: String {
        guard !entries.isEmpty else { return "No data available yet" }
        
        let totalIncome = entries.reduce(0) { $0 + $1.income }
        let totalExpenses = entries.reduce(0) { $0 + $1.totalExpenses }
        let totalSavings = entries.reduce(0) { $0 + $1.savings }
        
        let avgDailyExpenses = totalExpenses / Double(entries.count)
        let avgDailyIncome = totalIncome / Double(entries.count)
        let avgDailySavings = totalSavings / Double(entries.count)
        
        let expensePercentage = avgDailyExpenses / avgDailyIncome * 100
        let savingsPercentage = avgDailySavings / avgDailyIncome * 100
        
        if expensePercentage > 30 {
            return "You are overspending!"
        } else if savingsPercentage >= 10 && savingsPercentage <= 30 {
            return "You have a balanced budget!"
        } else if savingsPercentage > 30 {
            return "You are saving well!"
        } else {
            return "Review your financial habits"
        }
    }
    
    // data visualization
    var categoryData: [(category: ExpenseCategory, amount: Double)] {
        var data: [ExpenseCategory: Double] = [:]
        
        for entry in entries {
            for expense in entry.expenses {
                data[expense.category, default: 0] += expense.amount
            }
        }
        
        return data.map { ($0.key, $0.value) }
            .sorted { $0.amount > $1.amount }
    }
    
    
    var dailyData: [(day: String, income: Double, expenses: Double, savings: Double)] {
        return entries
            .sorted { $0.date < $1.date }
            .map { entry in
                (entry.monthDayString, entry.income, entry.totalExpenses, entry.savings)
            }
    }
}
