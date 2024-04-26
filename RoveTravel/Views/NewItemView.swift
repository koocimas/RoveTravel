//
//  NewItemView.swift
//  Rove
//

import SwiftUI

struct NewItemView: View {
  @Environment(\.presentationMode) var presentationMode
  @ObservedObject var tripPlannerManager: TripPlannerManager
  @State private var name = ""
  @State private var notes = ""
  var destination: Destination
  var body: some View {
    NavigationStack {
      Form {
        Section(header: Text("Item Name")) {
          TextField("Item Name", text: $name)
            .fontWeight(.light)
            .listRowBackground(Color.light)
        }
        Section(header: Text("Item Notes")) {
          TextField("Item Notes", text: $notes, axis: .vertical)
            .lineLimit(5...)
            .fontWeight(.light)
            .listRowBackground(Color.light)
        }
      }
      .toolbar {
        ToolbarItem(placement: .navigationBarLeading) {
          Button(action: {
            Task {
              tripPlannerManager.addingItem = false
              self.presentationMode.wrappedValue.dismiss()
            }
          }, label: {
            Text("Cancel")
              .foregroundStyle(.accent)
              .fontWeight(.light)
          })
        }
        ToolbarItem(placement: .principal) {
          Text("Add New Item")
            .font(.title3)
            .fontWeight(.light)
            .foregroundStyle(.accent)
        }
        ToolbarItem(placement: .navigationBarTrailing) {
          Button(action: {
            tripPlannerManager.addNewItem(name: name, destinationID: destination.city)
            tripPlannerManager.addingItem = false
            self.presentationMode.wrappedValue.dismiss()
          }, label: {
            Text("Add")
              .fontWeight(.light)
          })
          .disabled(name.isEmpty)
        }
      }
      .navigationBarTitleDisplayMode(.inline)
      .scrollContentBackground(.hidden)
      .background(.dark)
    }
  }
}

struct NewItemView_Previews: PreviewProvider {
  static var previews: some View {
    NewItemView(tripPlannerManager: TripPlannerManager(), destination: Destination.previewDestination[0])
  }
}
