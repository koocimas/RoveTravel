//
//  DestinationRow.swift
//  Rove
//

import SwiftUI

struct DestinationRow: View {
  var destination: Destination
  var body: some View {
    NavigationLink("\(destination.city), \(destination.country)",
                   destination: DestinationPortalView(destination: destination))
    .foregroundStyle(Color.accent)
  }
}

struct DestinationRow_Previews: PreviewProvider {
  static var previews: some View {
    DestinationRow(destination: Destination.previewDestination[0])
  }
}
