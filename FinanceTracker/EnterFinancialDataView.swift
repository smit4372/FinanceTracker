//
//  EnterFinancialDataView.swift
//  FinanceTracker
//
//  Created by Smit Desai on 4/5/25.
//


import SwiftUI
import SwiftData

struct EnterFinancialDataView: View {
    @Environment(\.modelContext) private var modelContext
    @StateObject private var viewModel = FinancialEntryViewModel()
    @State private var showingAlert = false
    @State private var alertMessage = ""
    
    
    // enter data
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Date")) {
                    DatePicker("Select Date", selection: $viewModel.date, displayedComponents: .date)
                }
                
                Section(header: Text("Income and Savings")) {
                    TextField("Income ($)", text: $viewModel.income)
                        .keyboardType(.decimalPad)
                    
                    TextField("Savings ($)", text: $viewModel.savings)
                        .keyboardType(.decimalPad)
                }
                
                
                // categpry selection
                Section(header: Text("Add Expenses")) {
                    HStack {
                        TextField("Amount ($)", text: $viewModel.expenseAmount)
                            .keyboardType(.decimalPad)
                        
                        Picker("Type:", selection: $viewModel.selectedCategory) {
                            ForEach(ExpenseCategory.allCases, id: \.self) { category in
                                Label(category.rawValue, systemImage: category.icon)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        
                        Button(action: viewModel.addExpense) {
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(.blue)
                        }
                    }
                }
                

                
                if !viewModel.expenses.isEmpty {
                    Section(header: Text("Current Expenses")) {
                        List {
                            ForEach(viewModel.expenses.indices, id: \.self) { index in
                                let expense = viewModel.expenses[index]
                                HStack {
                                    Image(systemName: expense.category.icon)
                                    Text(expense.category.rawValue)
                                    Spacer()
                                    Text("$\(expense.amount, specifier: "%.2f")")
                                        .bold()
                                }
                            }
                            .onDelete(perform: viewModel.removeExpense)
                        }
                    }
                }
                
                Button("Save Financial Entry") {
                    if viewModel.saveEntry(using: modelContext) {
                        alertMessage = "Financial data saved successfully!"
                        showingAlert = true
                    } else {
                        alertMessage = "Please fill in all fields correctly."
                        showingAlert = true
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .listRowInsets(EdgeInsets())
            }
            .navigationTitle("Enter Financial Data")
            .alert(isPresented: $showingAlert) {
                Alert(
                    title: Text("Notification"),
                    message: Text(alertMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
}
