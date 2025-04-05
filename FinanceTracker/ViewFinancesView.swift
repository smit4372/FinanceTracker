//
//  ViewFinancesView.swift
//  FinanceTracker
//
//  Created by Smit Desai on 4/5/25.
//

import SwiftUI
import SwiftData
import Charts

struct ViewFinancesView: View {
    @Environment(\.modelContext) private var modelContext
    @StateObject private var viewModel = FinancialAnalysisViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    if viewModel.hasData {
                        // summary view
                        VStack(alignment: .leading) {
                            Text("7-Day Financial Summary")
                                .font(.headline)
                                .padding(.bottom, 5)
                            
                            // Bar chart output
                            Chart {
                                ForEach(viewModel.dailyData, id: \.day) { item in
                                    BarMark(
                                        x: .value("Day", item.day),
                                        y: .value("Income", item.income)
                                    )
                                    .foregroundStyle(.green)
                                    
                                    BarMark(
                                        x: .value("Day", item.day),
                                        y: .value("Expenses", item.expenses)
                                    )
                                    .foregroundStyle(.red)
                                    
                                    BarMark(
                                        x: .value("Day", item.day),
                                        y: .value("Savings", item.savings)
                                    )
                                    .foregroundStyle(.blue)
                                }
                            }
                            .frame(height: 250)
                            .padding()
                            .chartLegend(position: .bottom, alignment: .center)
                        }
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                        

                        VStack(alignment: .leading) {
                            Text("Recent Entries")
                                .font(.headline)
                                .padding(.bottom, 5)
                            
                            ForEach(viewModel.entries) { entry in
                                VStack(alignment: .leading) {
                                    HStack {
                                        Text(entry.dayString)
                                            .font(.headline)
                                        Spacer()
                                        Text("Income: $\(entry.income, specifier: "%.2f")")
                                            .foregroundColor(.green)
                                    }
                                    
                                    Divider()
                                    
                                    Text("Expenses:")
                                        .font(.subheadline)
                                    
                                    ForEach(entry.expenses) { expense in
                                        HStack {
                                            Image(systemName: expense.category.icon)
                                                .foregroundColor(.gray)
                                            Text(expense.category.rawValue)
                                            Spacer()
                                            Text("$\(expense.amount, specifier: "%.2f")")
                                                .foregroundColor(.red)
                                        }
                                    }
                                    
                                    Divider()
                                    
                                    HStack {
                                        Text("Savings:")
                                            .font(.subheadline)
                                        Spacer()
                                        Text("$\(entry.savings, specifier: "%.2f")")
                                            .foregroundColor(.blue)
                                    }
                                }
                                .padding()
                                .background(Color.white)
                                .cornerRadius(10)
                                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                                .padding(.vertical, 5)
                            }
                        }
                        .padding()
                        
                    } else {
                        VStack {
                            Spacer()
                            Text("No financial data available")
                                .font(.headline)
                                .foregroundColor(.secondary)
                            Text("Add your first entry in the 'Enter Data' tab")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            Spacer()
                        }
                        .frame(maxWidth: .infinity, maxHeight: 300)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                        .padding()
                    }
                }
                .padding()
            }
            .navigationTitle("View My Finances")
            .onAppear {
                viewModel.fetchLastSevenDays(modelContext: modelContext)
            }
        }
    }
}
