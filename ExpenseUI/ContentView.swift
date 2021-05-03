//
//  ContentView.swift
//  ExpenseUI
//
//  Created by Максим Нуждин on 30.04.2021.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    let name: String
    private(set) var id = UUID()
    let type: String
    let amount: Int
}

class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]() {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: "items")
            }
        }
    }
    init() {
        if let items = UserDefaults.standard.data(forKey: "items") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([ExpenseItem].self, from: items) {
                self.items = decoded
                return
            }
        }
        self.items = []
    }
}
struct ContentView: View {
    
    @ObservedObject var expenses = Expenses()
    let defaults = UserDefaults.standard
    @State private var showingAddNewItem = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) { item in
                    VStack(alignment: .leading) {
                        Text("\(item.name)")
                        Text("Type: \(item.type)")
                        Text("Count: \(item.amount)")
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationBarTitle("ExpenseUI")
            .navigationBarItems(leading:
                                    Button(action: {
                                        showingAddNewItem.toggle()
                                    }, label: {
                                        Image(systemName: "plus")
                                    }
                                    ).sheet(isPresented: $showingAddNewItem, content: {
                                        AddView(expenses: expenses)
                                    })
            )
        }
    }
    func removeItems(offset: IndexSet) {
        expenses.items.remove(atOffsets: offset)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
