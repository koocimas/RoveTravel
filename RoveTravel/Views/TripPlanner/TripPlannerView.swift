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
            gradient: Gradient(colors: [.light, .dark]),
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
                .opacity(Constants.General.addItemButtonOpacity)
                .foregroundStyle(Color.accent)
                .font(.title)
              // swiftlint:enable multiple_closures_with_trailing_closure
            }
      }) {
        EmptyView()
      }
    }
    .overlay(Group {
      let destinationItems = tripPlannerManager.items.filter({($0).destinationID.contains(destination.city)})
      if destinationItems.isEmpty {
        Button(
          action: {
            // swiftlint:disable multiple_closures_with_trailing_closure
            self.sheetPresented = true }) {
              Text("You have no trip planning items... \nGet started!")
                .fontWeight(.light)
                .foregroundStyle(Color.accent)
                .multilineTextAlignment(.center)
              // swiftlint:enable multiple_closures_with_trailing_closure
            }
      }
    })
    .background(
      AngularGradient(
        gradient: Gradient(colors: [.dark, .light]),
        center: .topLeading,
        startAngle: .degrees(Constants.General.startAngle), endAngle: .degrees(Constants.General.endAngle))
    )
    .listStyle(InsetGroupedListStyle())
    .scrollContentBackground(.hidden)
    .sheet(isPresented: $sheetPresented) {
        NewItemView(tripPlannerManager: self.tripPlannerManager, destination: destination)
    }
    .sheet(item: $selectedItem) {selectedItem in
      ItemEditingView(
        tripPlannerManager: self.tripPlannerManager,
        item: $tripPlannerManager.items
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
