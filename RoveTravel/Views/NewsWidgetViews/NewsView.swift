//
//  NewsView.swift
//  Rove
//

import SwiftUI

struct NewsView: View {
  @StateObject private var newsManager = NewsManager()
  @State private var sheetPresented: Bool = false
  @State private var selectedNews: Article?
  var destination: Destination
  var body: some View {
    VStack {
      List {
        Text("News Feed")
          .foregroundStyle(.accent)
          .font(.title3)
          .fontWeight(.light)
          .padding(.top)
          .listRowBackground(Color.clear)
          .frame(maxWidth: .infinity, alignment: .center)
          .listRowSeparator(.hidden)
        ForEach(newsManager.articles, id: \.title) { article in
          Button(action: {
            selectedNews = article
            sheetPresented = true
            // swiftlint:disable:next multiple_closures_with_trailing_closure
          }) {
            HStack {
              AsyncImage( url: URL(string: article.urlToImage ?? "")) { image in
                image
                  .resizable()
                  .aspectRatio(contentMode: .fit)
                  .frame(width: Constants.General.newsImage, height: Constants.General.newsImage)
              } placeholder: {
                ProgressView()
              }
              Text(article.title ?? "News Article Unavailable")
                .foregroundStyle(Color.accent)
                .fontWeight(.light)
                .font(.body)
                .lineLimit(Constants.General.newsTitleLineLimit)
            }
          }
        }
        .padding(Constants.General.newsTitlePadding)
        .listRowBackground(Color.clear)
        .listRowSeparatorTint(Color.accentColor.opacity(Constants.General.newsSeparatorLineOpacity))
      }
      .clipped()
      .accessibilityIdentifier("newsList")
      .padding(.top, Constants.General.newsWidgetPadding)
      .scrollContentBackground(.hidden)
      .sheet(isPresented: $sheetPresented) { [selectedNews] in
        if let selectedNews {
          NewsDetailView(articles: selectedNews)
        }
      }
    }
    .clipped()
    .frame(minHeight: Constants.General.rowFrameMaxHeight, maxHeight: .infinity)
    .background(RoundedRectangle(cornerRadius: Constants.General.roundRectCornerRadius)
      .fill(
        LinearGradient(
          gradient: Gradient(colors: [.light, .dark]),
          startPoint: .leading,
          endPoint: .trailing))
        .ignoresSafeArea()
    )
    .task {
      do {
        runSearch()
      }
    }
  }
  func runSearch() {
    Task {
      newsManager.searchText = "\(destination.city), \(destination.country)"
      do {
        try await newsManager.fetchNews()
      }
    }
  }
}

struct NewsView_Previews: PreviewProvider {
  static var previews: some View {
    NewsView(destination: Destination.previewDestination[0])
  }
}
