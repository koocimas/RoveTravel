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
  var destination: Destination

  var body: some View {
    NavigationStack {
      List {
        ForEach(tripPlannerManager.items.filter({($0).destinationID.contains(destination.city)}), id: \.self) { item in
          NavigationLink(value: item) {
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
              self.sheetPresented = true }){
                Image(systemName: "plus.circle.fill")
                  .opacity(0.9)
                  .foregroundStyle(Color.accentColor)
                  .font(.title)
              }
        }) {
          EmptyView()
        }
      }
      .navigationDestination(for: Item.self) { item in
        ItemEditingView(item: $tripPlannerManager.items
          .first(where: { $0.id == item.id })!)
      }
      .background(
        AngularGradient(
          gradient: Gradient(colors: [Color("DarkColor"), .light]),
          center: .topLeading,
          startAngle: .degrees(90), endAngle: .degrees(20))
      )
      .listStyle(InsetGroupedListStyle())
      .scrollContentBackground(.hidden)
    }
    .sheet(isPresented: $sheetPresented) {
      NewItemView(tripPlannerManager: self.tripPlannerManager, destination: destination)
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
