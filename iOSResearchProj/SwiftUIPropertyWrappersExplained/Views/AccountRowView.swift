//
//  AccountRowView.swift
//  iOSResearchProj
//
//  Created by Lawrence Zeng on 2026-08-02.
//
import SwiftUI

struct AccountRowView: View {
    let account: Account
    
    // 3. @Binding: Does NOT own the state. It is a 2-way connection to
    // 'isPrivacyModeEnabled' owned by BankingDashboardView.
    @Binding var isPrivacyMode: Bool

    var body: some View {
        HStack {
            Text(account.name)
            Spacer()
            if isPrivacyMode {
                Text("••••••")
                    .foregroundColor(.gray)
            } else {
                Text(account.balance, format: .currency(code: "USD"))
            }
        }
    }
}
