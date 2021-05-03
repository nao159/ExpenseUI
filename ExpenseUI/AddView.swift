//
//  AddView.swift
//  ExpenseUI
//
//  Created by Максим Нуждин on 02.05.2021.
//

import SwiftUI

struct AddView: View {
    
    @ObservedObject var expenses: Expenses
    @State private var name = ""
    @State private var type = "None"
    @State private var amount = ""
    var types = ["Personal", "Business"]
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Input item name")) {
                    TextField("name", text: $name)
                }
                Section(header: Text("Select type of item")) {
                    Picker("select type", selection: $type) {
                        ForEach(types, id: \.self) {
                            Text("\($0)")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text("type amount")) {
                    TextField("type amount", text: $amount)
                        .keyboardType(.numberPad)
                }
            }
            .navigationTitle("Add new item")
            .navigationBarItems(trailing: Button("save") {
                if let convertedAmount = Int(amount) {
                    let item = ExpenseItem(name: name, type: type, amount: convertedAmount)
                    expenses.items.append(item)
                    presentationMode.wrappedValue.dismiss()
                }
            })
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
