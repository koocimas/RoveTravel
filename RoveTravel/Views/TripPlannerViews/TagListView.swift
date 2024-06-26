//
//  TagListView.swift
//  RoveTravel
//
//  Created by Sam Cook on 5/28/24.
//

import SwiftUI

struct TagListView: View {
  @State var selectedTags: [Item.Tag]
  var body: some View {
    List {
      ForEach(Item.Tag.allCases, id: \.self) { tag in
        TagRowView(isSelected: selectedTags.contains(tag), tagName: tag.rawValue)
          .onTapGesture {
            if let index = selectedTags.firstIndex(of: tag) {
              selectedTags.remove(at: index)
            } else {
              selectedTags.append(tag)
            }
          }
      }
    }
  }
}

#Preview {
  TagListView(selectedTags: [])
}
