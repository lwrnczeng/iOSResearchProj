//
//  DashboardViewModel.swift
//  iOSResearchProj
//
//  Created by Lawrence Zeng on 2026-08-02.
//

import SwiftUI
import Combine

@MainActor
final class DashboardViewModel: ObservableObject {
    @Published private(set) var totalBalance: Decimal = 125430.50
    @Published var accounts: [Account] = [
        Account(id: "1", name: "Checking", balance: 5430.50),
        Account(id: "2", name: "Investment", balance: 120000.00)
    ]
    
    func updateAccountName(id: String, newName: String) {
        if let index = accounts.firstIndex(where: { $0.id == id }) {
            accounts[index].name = newName
        }
    }
}

struct Account: Identifiable {
    let id: String
    var name: String
    var balance: Decimal
}
