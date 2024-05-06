//
//  DestinationRow.swift
//  Rove
//

import SwiftUI

struct DestinationRow: View {
  @State var destination: Destination
  @StateObject var timeManager = TimeManager()
  var timeResults: TimeResults
  var body: some View {
    NavigationLink("\(destination.city), \(destination.country)",
                   destination: DestinationPortalView(destination: destination,
                                                      timeResults: timeResults))
    .foregroundStyle(Color.accent)
  }
}

struct DestinationRow_Previews: PreviewProvider {
  static var previews: some View {
    DestinationRow(destination: Destination.previewDestination[0], timeResults: TimeResults.timeExample)
  }
}
