//
//  NewsViewModel.swift
//  RoveTravel
//
//  Created by Sam Cook on 7/16/24.
//

import Foundation

@MainActor
class NewsViewModel: ObservableObject {
    @Published var selectedNews: Article?
    @Published var sheetPresented: Bool = false
    let destination: Destination
    let newsManager: NewsManager

    init(newsManager: NewsManager = NewsManager.shared, sheetPresented: Bool = false,
         selectedNews: Article? = nil, destination: Destination) {
        self.newsManager = newsManager
        self.sheetPresented = sheetPresented
        self.selectedNews = selectedNews
        self.destination = destination

        runSearch()
    }

  func runSearch() {
    Task {
      newsManager.searchText = "\(destination.city), \(destination.country)"
      do {
        try await newsManager.fetchNews()
      }
        objectWillChange.send()
    }
  }
}
