//
//  ContentView.swift
//  Rove
//

import SwiftUI

struct ContentView: View {
  var destinations: [Destination] = Destination.previewDestination
  var destination: Destination
  var body: some View {
    NavigationStack {
        List {
            ForEach(destinations, id: \.id) { destination in
                DestinationRow(destination: destination)
                    .listRowBackground(Color.dark).ignoresSafeArea()
                    .foregroundStyle(Color.accentColor)
            }
        }
      .background(Color.dark)
      .listStyle(.plain)
      .navigationTitle("Where to Rove")
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView(destination: Destination.previewDestination[0])
    .preferredColorScheme(.light)
    ContentView(destination: Destination.previewDestination[0])
    .preferredColorScheme(.dark)
  }
}
