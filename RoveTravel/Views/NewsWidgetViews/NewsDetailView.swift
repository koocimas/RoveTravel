//
//  NewsDetailView.swift
//  Rove
//

import SwiftUI

struct NewsDetailView: View {
  @Environment(\.presentationMode) var presentationMode
  let articles: Article

  var body: some View {
    NavigationStack {
      ScrollView {
        VStack {
          AsyncImage(url: URL(string: "\(String(describing: articles.urlToImage ?? ""))")) { image in
            image
              .resizable()
              .frame(maxWidth: .infinity, maxHeight: .infinity)
              .aspectRatio(contentMode: .fit)
          } placeholder: {
            ProgressView()
          }
          .padding(Constants.General.newsDetailPadding)
          Text(articles.title ?? "")
            .font(.headline)
            .multilineTextAlignment(.center)
            .padding()
            .foregroundStyle(Color(.accent))
            .fontWeight(.light)
          Text("Published: \(getStringFrom(strDate: articles.publishedAt ?? ""))")
            .font(.caption)
            .fontWeight(.light)
            .multilineTextAlignment(.center)
            .foregroundStyle(Color(.accent))
          Text("Author(s): \(articles.author ?? "Author unavailable")")
            .font(.caption)
            .fontWeight(.light)
            .multilineTextAlignment(.center)
            .foregroundStyle(Color(.accent))
          Link("Go To Article", destination: URL(string: articles.url ?? "https://www.newsapi.org")!)
            .font(.caption)
            .padding(.bottom)
            .foregroundStyle(Color(.accent))
            .fontWeight(.semibold)
          Text(articles.description ?? "Content unavailable")
            .font(.callout)
            .fontWeight(.light)
            .multilineTextAlignment(.leading)
            .foregroundStyle(Color(.accent))
        }
        .padding()
      }
      .toolbar(content: {
        ToolbarItem(placement: .topBarTrailing) {
          Button(action: {
            Task {
              self.presentationMode.wrappedValue.dismiss()
            }
          }, label: {
            Text("Dismiss")
              .foregroundStyle(.accent)
              .fontWeight(.light)
          })
        }
      })
      .background(
        AngularGradient(
          gradient: Gradient(
            colors: [.dark, .light]),
          center: .topLeading,
          startAngle: .degrees(Constants.General.startAngle),
          endAngle: .degrees(Constants.General.endAngle))
      )
    }
  }
}
