//
//  RowView.swift
//  Rove
//

import SwiftUI

struct RowView: View {
  @ObservedObject var tripPlannerManager: TripPlannerManager
  @State var isAnimating = false
  @Binding var completed: Bool
  var item: Item
  var body: some View {
    HStack {
      Text(item.name)
        .fontWeight(.light)
        .foregroundStyle(.accent)
      Spacer()
      Button(action: {
        withAnimation(.easeInOut(duration: 0.75)) {
          isAnimating.toggle()
          DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
            tripPlannerManager.toggleItemCompletion(item: item)
          }
        }
        // swiftlint:disable multiple_closures_with_trailing_closure
        // swiftlint:disable opening_brace
        completed.toggle() })
      { Image(systemName: item.completed == isAnimating ? "square.dotted" : "checkmark")
          .fontWeight(.light)
        // swiftlint:enable multiple_closures_with_trailing_closure
        // swiftlint:enable opening_brace
      }
      .buttonStyle(BorderlessButtonStyle())
    }.lineLimit(2)
  }
}
