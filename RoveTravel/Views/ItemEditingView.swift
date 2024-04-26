//
//  ItemEditingView.swift
//  Rove
//

import SwiftUI

struct ItemEditingView: View {
  @Environment(\.presentationMode) var presentationMode
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
      .toolbar {
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
          })
        }
      }
      .navigationBarTitleDisplayMode(.inline)
      .scrollContentBackground(.hidden)
      .background(.dark)
    }
  }
}

struct ItemEditingView_Previews: PreviewProvider {
  static var previews: some View {
    ItemEditingView(
      item: .constant(Item(name: "", destinationID: "Amman"))
    )
  }
}
