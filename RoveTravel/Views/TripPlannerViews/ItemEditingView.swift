//
//  ItemEditingView.swift
//  Rove
//

import SwiftUI

struct ItemEditingView: View {
  @Environment(\.presentationMode) var presentationMode
  @ObservedObject var tripPlannerManager: TripPlannerManager
  @Binding var item: Item
  var body: some View {
    NavigationStack {
      Form {
        Section(header: Text("Item Name")) {
          TextField("Item Name", text: $item.name)
            .foregroundStyle(.accent)
            .fontWeight(.light)
            .listRowBackground(Color.light)
        }
        Section(header: Text("Item Notes")) {
          TextField("Item Notes", text: $item.notes, axis: .vertical)
            .lineLimit(Constants.General.notesLineLimit...)
            .foregroundStyle(.accent)
            .fontWeight(.light)
            .listRowBackground(Color.light)
        }
        Section {
          Toggle("Completed", isOn: $item.completed)
            .foregroundStyle(.accent)
            .fontWeight(.light)
            .listRowBackground(Color.light)
        }
      }
      .toolbar {
        ToolbarItem(placement: .navigationBarLeading) {
          Button(action: {
            tripPlannerManager.removeItem(item: item)
            self.presentationMode.wrappedValue.dismiss()

          }, label: {
            Text("Delete")
              .fontWeight(.light)
              .foregroundStyle(.accent)
          })
        }
        ToolbarItem(placement: .principal) {
          Text("Edit Item")
            .font(.title3)
            .fontWeight(.light)
            .foregroundStyle(.accent)
        }
        ToolbarItem(placement: .navigationBarTrailing) {
          Button(action: {
            self.presentationMode.wrappedValue.dismiss()
          }, label: {
            Text("Done")
              .fontWeight(.light)
              .foregroundStyle(.accent)
          })
        }
      }
      .navigationBarTitleDisplayMode(.inline)
      .scrollContentBackground(.hidden)
      .background(.dark)
    }
  }
}
