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
    @State private var type = ""
    @State private var amount = ""
    var types = ["Personal", "Business"]
    
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
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
