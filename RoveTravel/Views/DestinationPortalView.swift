//
//  TabView.swift
//  Rove
//

import SwiftUI

struct DestinationPortalView: View {
  var destination: Destination
  var timeManager = TimeManager.shared
  var timeResults = TimeResults.timeExample
  init(destination: Destination) {
    self.destination = destination
    self.timeManager.latitude = Float(destination.latitude)
    self.timeManager.longitude = Float(destination.longitude)
    UITabBarItem.appearance().badgeColor = .badge
    UINavigationBar.appearance().largeTitleTextAttributes =
    [.font: UIFont.systemFont(ofSize: Constants.General.titleSize, weight: .light, width: .expanded),
     .foregroundColor: UIColor.accent]
    UINavigationBar.appearance().barTintColor = UIColor.dark
    UITabBar.appearance().barTintColor = UIColor.dark
  }
  var body: some View {
    TabView {
      SnapshotView(destination: destination, timeResults: timeResults)
        .tabItem {
          Label("Snapshot", systemImage: "dot.circle.viewfinder")
        }
      TripPlannerView(
        tripPlannerManager: TripPlannerManager.shared,
        destination: destination
      )
      .tabItem {
        Label("Trip Planner", systemImage: "pencil.and.list.clipboard")
      }
    }.navigationTitle(destination.city)
  }
}

#Preview {
  DestinationPortalView(destination: Destination.previewDestination[0])
    .preferredColorScheme(.light)
}
#Preview {
  DestinationPortalView(destination: Destination.previewDestination[0])
    .preferredColorScheme(.dark)
}
