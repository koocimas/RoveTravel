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
      Text("News Feed")
        .foregroundStyle(.accent)
        .font(.title3)
        .fontWeight(.light)
        .multilineTextAlignment(.center)
        .padding(.top)
      List {
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
                  .frame(width: 75, height: 75)
              } placeholder: {
                ProgressView()
              }
              Text(article.title ?? "")
                .foregroundStyle(Color.accentColor)
                .fontWeight(.light)
                .font(.footnote)
                .lineLimit(3)
            }
          }
        }
        .padding(-10)
        .listRowBackground(Color.clear)
        .listRowSeparatorTint(Color.accentColor.opacity(0.3))
      }
      .accessibilityIdentifier("newsList")
      .padding(.top, -40)
      .scrollContentBackground(.hidden)
      .sheet(isPresented: $sheetPresented) { [selectedNews] in
        if let selectedNews {
          NewsDetailView(articles: selectedNews)
        }
      }
    }
    .frame(minHeight: 350, maxHeight: .infinity)
    .background(RoundedRectangle(cornerRadius: 20)
      .fill(
        LinearGradient(
          gradient: Gradient(colors: [.light, Color("DarkColor")]),
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
