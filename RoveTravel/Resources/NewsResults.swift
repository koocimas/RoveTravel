//
//  NewsResults.swift
//  Rove
//

import Foundation

struct NewsResults: Codable {
  var status: String
  var totalResults: Int
  var articles: [Article]? = []
}

struct Article: Codable {
  var source: Source?
  var author: String?
  var title, description: String?
  var url: String?
  var urlToImage: String?
  var publishedAt: String?
  var content: String?
}

struct Source: Codable, Identifiable {
  var id: String?
  var name: String?
}

func getStringFrom(strDate: String) -> String {
  let formatter = DateFormatter()
  formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
  let date = formatter.date(from: strDate) ?? Date()

  let outformatter = DateFormatter()
  outformatter.dateFormat = "MMM dd, yyyy"
  return outformatter.string(from: date)
}
