//
//  ItemEditingView.swift
//  Rove
//

import SwiftUI

struct ItemEditingView: View {
  @Binding var item: Item
  var body: some View {
    Form {
      Section(header: Text("Item Name")) {
        TextField("Item Name", text: $item.name)
          .foregroundStyle(.accent)
          .fontWeight(.light)
          .listRowBackground(Color.light)
      }
      Section(header: Text("Item Notes")) {
        TextField("Item Notes", text: $item.notes, axis: .vertical)
          .lineLimit(5...)
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
    .scrollContentBackground(.hidden)
    .background(.dark)
  }
}

struct ItemEditingView_Previews: PreviewProvider {
  static var previews: some View {
    ItemEditingView(
      item: .constant(Item(name: "", destinationID: "Amman"))
    )
  }
}
