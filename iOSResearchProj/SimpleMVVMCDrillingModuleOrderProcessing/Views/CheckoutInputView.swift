//
//  CheckoutInputView.swift
//  iOSResearchProj
//
//  Created by Lawrence Zeng on 2026-08-19.
//
import SwiftUI

struct CheckoutInputView: View {
    @State private var itemName: String = ""
    @State private var priceText: String = ""
    @State private var quantity: Int = 1
    @State private var isShowingDiscountView = false

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Enter Order Details")) {
                    TextField("Item Name", text: $itemName)
                    TextField("Price", text: $priceText)
                        .keyboardType(.decimalPad)
                    Stepper("Quantity: \(quantity)", value: $quantity, in: 1...100)
                }
                Section {
                    Button("Show Discount") {
                        isShowingDiscountView = true
                    }
                    .disabled(itemName.isEmpty || priceText.isEmpty)
                    .navigationDestination(isPresented: $isShowingDiscountView) {
                        DiscountView(itemName: itemName, priceText: priceText, quantity: quantity)
                    }
                }
            }
            .navigationTitle("Checkout Input")
        }
    }
}

#Preview {
    CheckoutInputView()
}
