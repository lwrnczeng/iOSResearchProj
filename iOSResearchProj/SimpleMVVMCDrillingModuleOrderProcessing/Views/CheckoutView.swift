import SwiftUI

struct CheckoutSummaryView: View {
    let itemName: String
    let unitPrice: Double
    let quantity: Int
    let discountPercent: Double
    let enableBuyXGetOneFree: Bool
    let buyXThreshold: Int
    let subtotal: Double
    let totalDiscount: Double
    let total: Double

    private func currency(_ value: Double) -> String {
        let f = NumberFormatter()
        f.numberStyle = .currency
        return f.string(from: NSNumber(value: value)) ?? String(format: "$%.2f", value)
    }

    var body: some View {
        Form {
            Section(header: Text("Items")) {
                HStack {
                    Text("Item")
                    Spacer()
                    Text(itemName)
                }
                HStack {
                    Text("Unit Price")
                    Spacer()
                    Text(currency(unitPrice))
                }
                HStack {
                    Text("Quantity")
                    Spacer()
                    Text("\(quantity)")
                }
            }

            Section(header: Text("Discounts")) {
                HStack {
                    Text("Percent")
                    Spacer()
                    Text("\(Int(discountPercent))%")
                }
                if enableBuyXGetOneFree {
                    HStack {
                        Text("Buy X Get 1 Free")
                        Spacer()
                        Text("X = \(buyXThreshold)")
                    }
                } else {
                    Text("No BxG offer applied").foregroundStyle(.secondary)
                }
            }

            Section(header: Text("Summary")) {
                HStack {
                    Text("Subtotal")
                    Spacer()
                    Text(currency(subtotal))
                        .monospacedDigit()
                }
                HStack {
                    Text("Discounts")
                    Spacer()
                    Text("-" + currency(totalDiscount))
                        .foregroundStyle(.red)
                        .monospacedDigit()
                }
                HStack {
                    Text("Total")
                        .font(.headline)
                    Spacer()
                    Text(currency(total))
                        .font(.headline)
                        .monospacedDigit()
                }
            }
        }
        .navigationTitle("Checkout Summary")
    }
}

#Preview {
    NavigationStack {
        CheckoutSummaryView(
            itemName: "Coffee Beans",
            unitPrice: 12.99,
            quantity: 5,
            discountPercent: 10,
            enableBuyXGetOneFree: true,
            buyXThreshold: 3,
            subtotal: 64.95,
            totalDiscount: 12.99 + 6.495,
            total: 64.95 - (12.99 + 6.495)
        )
    }
}
