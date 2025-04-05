//
//  FinanceTrackerApp.swift
//  FinanceTracker
//
//  Created by Smit Desai on 4/5/25.
//

import SwiftUI

@main
struct hw2SmitApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [FinancialEntry.self, Expense.self])

    }
}
