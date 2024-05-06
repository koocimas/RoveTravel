//
//  NewsManager.swift
//  Rove
//

import Foundation

class NewsManager: ObservableObject {
  @Published var articles: [Article] = []
  @Published var searchText: String = "Amman"

  func fetchNews() async throws {
      let apiKey = newsApiKey
      let query = searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
      let urlString = "https://newsapi.org/v2/everything?q=\(query)&pageSize=10&language=en"
      guard let url = URL(string: urlString) else {
        print("Error here")
        return
      }
      var request = URLRequest(url: url)
      request.httpMethod = "GET"
      request.setValue(apiKey, forHTTPHeaderField: "X-API-Key")

      do {
        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
          print("Error here")
          return
        }
        if (200..<300).contains(httpResponse.statusCode) {
          try await MainActor.run {
            let decodedResponse = try JSONDecoder().decode(NewsResults.self, from: data)
            self.articles = decodedResponse.articles ?? []
          }
        } else {
          print("HTTP status code for news: \(httpResponse.statusCode)")
        }
      } catch {
        print("Error fetching data: \(error)")
      }
  }

  var newsApiKey: String {
    guard let filePath = Bundle.main.path(forResource: "News-Info", ofType: "plist") else {
      fatalError("Couldn't find file 'News-Info.plist'.")
    }
    let plist = NSDictionary(contentsOfFile: filePath)
    guard let value = plist?.object(forKey: "API_KEY") as? String else {
      fatalError("Couldn't find key 'API_KEY' in 'News-Info.plist'.")
    }
    return value
  }

}
