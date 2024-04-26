//
//
// TripPlannerView.swift
//  Rove
//

import SwiftUI

struct TripPlannerView: View {
  @ObservedObject var tripPlannerManager: TripPlannerManager
  @State var completed = false
  @State var sheetPresented = false
  @State private var selectedItem: Item?
  var destination: Destination

  var body: some View {
    List {
      ForEach(tripPlannerManager.items.filter({($0).destinationID.contains(destination.city)}), id: \.self) { item in
        Button {
          selectedItem = item
        } label: {
          RowView(tripPlannerManager: tripPlannerManager, completed: $completed, item: item)
        }
        .listRowBackground(
          LinearGradient(
            gradient: Gradient(colors: [.light, Color("DarkColor")]),
            startPoint: .leading,
            endPoint: .trailing)
        )
      }
      Section(footer:
                HStack {
        Button(
          action: {
            // swiftlint:disable multiple_closures_with_trailing_closure
            self.sheetPresented = true }) {
              Image(systemName: "plus.circle.fill")
                .opacity(0.9)
                .foregroundStyle(Color.accentColor)
                .font(.title)
              // swiftlint:enable multiple_closures_with_trailing_closure
            }
      }) {
        EmptyView()
      }
    }
    .background(
      AngularGradient(
        gradient: Gradient(colors: [Color("DarkColor"), .light]),
        center: .topLeading,
        startAngle: .degrees(90), endAngle: .degrees(20))
    )
    .listStyle(InsetGroupedListStyle())
    .scrollContentBackground(.hidden)
    .sheet(isPresented: $sheetPresented) {
      NewItemView(tripPlannerManager: self.tripPlannerManager, destination: destination)
    }
    .sheet(item: $selectedItem) {selectedItem in
      ItemEditingView(item: $tripPlannerManager.items
        .first(where: { $0.id == selectedItem.id })!)
    }
  }
}

struct TripPlannerView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationStack {
      TripPlannerView(tripPlannerManager: TripPlannerManager(), destination: Destination.previewDestination[0])
    }
  }
}
