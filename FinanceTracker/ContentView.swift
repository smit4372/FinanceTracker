//
//  ContentView.swift
//  FinanceTracker
//
//  Created by Smit Desai on 4/5/25.
//
import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            EnterFinancialDataView()
                .tabItem {
                    Label("Enter Data", systemImage: "plus.circle")
                }
            
            ViewFinancesView()
                .tabItem {
                    Label("Your Finances", systemImage: "chart.bar")
                }
            
            FinancialInsightsView()
                .tabItem {
                    Label("How am I Doin?", systemImage: "chart.pie")
                }
        }
    }
}

#Preview {
    ContentView()
}
