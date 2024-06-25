//
//  ContentView.swift
//  Ghost Spot
//
//  Created by Zack Edds on 6/24/24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @State private var showingAddGraffiti = false
    
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.name, ascending: true)],
        animation: .default)

    
    private var items: FetchedResults<Item>

    var body: some View {
        NavigationView {
            List {
                ForEach(items) { item in
                    NavigationLink(destination: GraffitiDetailView(item: item)) {
                        VStack(alignment: .leading) {
                            Text(item.name ?? "Unknown Name").font(.headline)
                            Text(item.descript ?? "No Description").font(.subheadline)
                        }
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddGraffiti.toggle()
                    } label: {
                        Label("Add ghost", systemImage: "plus")
                    }
                }
            }                
            .sheet(isPresented: $showingAddGraffiti) {
                AddGraffiti()
            }
            Text("Select an item")
        }
    }


    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
