//
//  TabView.swift
//  Rove
//

import SwiftUI

struct DestinationPortalView: View {
  @State var destination: Destination
  @State var timeResults: TimeResults
  @ObservedObject var tripPlannerManager = TripPlannerManager()
  @ObservedObject var timeManager = TimeManager()

  init(destination: Destination, timeResults: TimeResults, tripPlannerManager: TripPlannerManager = TripPlannerManager()) {
    self.destination = destination
    self.timeResults = timeResults
    self.timeManager.latitude = Float(destination.latitude)
    self.timeManager.longitude = Float(destination.longitude)
    UITabBarItem.appearance().badgeColor = .badge
    UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont.systemFont(ofSize: 30, weight: .light, width: .expanded), .foregroundColor: UIColor.accent]
    UINavigationBar.appearance().barTintColor = UIColor.dark
    UITabBar.appearance().barTintColor = UIColor.dark
  }
  var body: some View {
    TabView {
      SnapshotView(destination: destination, timeResults: timeResults)
        .accessibilityIdentifier("Snapshot")
        .tabItem {
          Label("Snapshot", systemImage: "dot.circle.viewfinder")
        }
       TripPlannerView(tripPlannerManager: TripPlannerManager(), destination: destination)
        .accessibilityIdentifier("Trip Planner")
        .tabItem {
          Label("Trip Planner", systemImage: "pencil.and.list.clipboard")
        }
    }.navigationTitle(destination.city)
  }
}

#Preview {
  DestinationPortalView(destination: Destination.previewDestination[0], timeResults: TimeResults.timeExample)
    .preferredColorScheme(.light)
}
#Preview {
  DestinationPortalView(destination: Destination.previewDestination[0], timeResults: TimeResults.timeExample)
    .preferredColorScheme(.dark)
}
