//
//  TagRowView.swift
//  RoveTravel
//
//  Created by Sam Cook on 5/28/24.
//

import SwiftUI

struct TagRowView: View {
  let isSelected: Bool
  let tagName: String
    var body: some View {
      HStack {
        Image(systemName: isSelected ? "checkmark.square" : "square")
        Text(tagName)
      }
    }
}

#Preview {
  TagRowView(isSelected: true, tagName: "")
}
