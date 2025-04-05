//
//  FinancialInsightsView.swift
//  FinanceTracker
//
//  Created by Smit Desai on 4/5/25.
//

import SwiftUI
import SwiftData
import Charts

struct FinancialInsightsView: View {
    @Environment(\.modelContext) private var modelContext
    @StateObject private var viewModel = FinancialAnalysisViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    if viewModel.hasData {
                        // cards
                        VStack {
                            Text("Your Financial Status")
                                .font(.headline)
                                .padding(.bottom, 10)
                            
                            Text(viewModel.financialStatus)
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(statusColor)
                                .multilineTextAlignment(.center)
                                .padding()
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(statusColor.opacity(0.1))
                        .cornerRadius(15)
                        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                        
                        // Pie chart for different types of spending
                        VStack {
                            Text("Expense Breakdown")
                                .font(.headline)
                                .padding(.bottom, 10)
                            
                            Chart {
                                ForEach(viewModel.categoryData, id: \.category) { item in
                                    SectorMark(
                                        angle: .value("Amount", item.amount),
                                        innerRadius: .ratio(0.5),
                                        angularInset: 1.0
                                    )
                                    .foregroundStyle(by: .value("Category", item.category.rawValue))
                                    .annotation(position: .overlay) {
                                        Text("$\(item.amount, specifier: "%.0f")")
                                            .font(.caption)
                                            .fontWeight(.bold)
                                    }
                                }
                            }
                            .frame(height: 250)
                            .padding()
                            .chartLegend(position: .bottom)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(15)
                        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                        
                        
                        // random tips
                        VStack(alignment: .leading, spacing: 15) {
                            Text("Financial Tips")
                                .font(.headline)
                                .padding(.bottom, 5)
                            
                            ForEach(financialTips, id: \.self) { tip in
                                HStack(alignment: .top) {
                                    Image(systemName: "lightbulb.fill")
                                        .foregroundColor(.yellow)
                                        .padding(.top, 2)
                                    Text(tip)
                                        .font(.body)
                                }
                                .padding(.vertical, 5)
                            }
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(15)
                        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                        
                    } else {
                        VStack {
                            Spacer()
                            Image(systemName: "chart.pie")
                                .font(.system(size: 60))
                                .foregroundColor(.gray)
                                .padding()
                            
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
            .navigationTitle("How Am I Doing?")
            .onAppear {
                viewModel.fetchLastSevenDays(modelContext: modelContext)
            }
        }
    }
    

    // output
    private var statusColor: Color {
        switch viewModel.financialStatus {
        case "You are overspending!":
            return .red
        case "You have a balanced budget!":
            return .yellow
        case "You are saving well!":
            return .green
        default:
            return .gray
        }
    }
    
    
    // tips
    private var financialTips: [String] {
        switch viewModel.financialStatus {
        case "You are overspending!":
            return [
                "Try to identify non-essential expenses that you can reduce.",
                "Consider creating a detailed budget to track where your money is going.",
                "Look for opportunities to increase your income sources."
            ]
        case "You have a balanced budget!":
            return [
                "Continue monitoring your expenses to maintain your balanced budget.",
                "Consider setting specific financial goals to improve further.",
                "Look into opportunities for investments with your savings."
            ]
        case "You are saving well!":
            return [
                "Consider investing your savings for potential growth.",
                "Make sure you're also enjoying your life while saving.",
                "Look into tax-advantaged savings options."
            ]
        default:
            return [
                "Start by tracking all your expenses.",
                "Create a budget to help guide your spending.",
                "Set financial goals to work towards."
            ]
        }
    }
}
