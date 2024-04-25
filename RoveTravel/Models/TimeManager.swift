//
//  TimeManager.swift
//  Rove
//

import Foundation

class TimeManager: ObservableObject {
  @Published var latitude: Float = 0.0
  @Published var longitude: Float = 0.0
  @Published var dateTime: String = ""
  @Published var timeZone: String = ""
  @Published var hour: Int = 0
  @Published var dayOfWeek: String = ""

  func fetchDateTime() async throws {
    do {
      let urlString = "https://timeapi.io/api/Time/current/coordinate?latitude=\(latitude)&longitude=\(longitude)"
      guard let url = URL(string: urlString) else {
        print("Error here")
        return
      }
      var request = URLRequest(url: url)
      request.httpMethod = "GET"

      do {
        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse else {
          print("Error here too")
          return
        }

        if (200..<300).contains(httpResponse.statusCode) {
          let decodedResponse = try JSONDecoder().decode(TimeResults.self, from: data)

          await MainActor.run {
            self.dateTime = decodedResponse.dateTime
          }
        } else {
          print("HTTP status code: \(httpResponse.statusCode)")
        }
      } catch {
        print("Error fetching data: \(error)")
      }

      let (data, _) = try await URLSession.shared.data(for: request)

      let decodedResponse = try JSONDecoder().decode(TimeResults.self, from: data)
      await MainActor.run {
        self.dateTime = decodedResponse.dateTime
      }
    } catch {
      print("error there")
      print(error)
    }
  }

  func fetchTimeZone() async throws {
    do {
      let urlString = "https://timeapi.io/api/Time/current/coordinate?latitude=\(latitude)&longitude=\(longitude)"
      guard let url = URL(string: urlString) else {
        print("Error here")
        return
      }
      var request = URLRequest(url: url)
      request.httpMethod = "GET"

      do {
        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse else {
          print("Error here too")
          return
        }

        if (200..<300).contains(httpResponse.statusCode) {
          let decodedResponse = try JSONDecoder().decode(TimeResults.self, from: data)

          await MainActor.run {
            self.timeZone = decodedResponse.timeZone
          }
        } else {
          print("HTTP status code: \(httpResponse.statusCode)")
        }
      } catch {
        print("Error fetching data: \(error)")
      }

      let (data, _) = try await URLSession.shared.data(for: request)

      let decodedResponse = try JSONDecoder().decode(TimeResults.self, from: data)
      await MainActor.run {
        self.timeZone = decodedResponse.timeZone
      }
    } catch {
      print("error there")
      print(error)
    }
  }

  func fetchDayOfWeek() async throws {
    do {
      let urlString = "https://timeapi.io/api/Time/current/coordinate?latitude=\(latitude)&longitude=\(longitude)"
      guard let url = URL(string: urlString) else {
        print("Error here")
        return
      }
      var request = URLRequest(url: url)
      request.httpMethod = "GET"

      do {
        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse else {
          print("Error here too")
          return
        }

        if (200..<300).contains(httpResponse.statusCode) {
          let decodedResponse = try JSONDecoder().decode(TimeResults.self, from: data)

          await MainActor.run {
            self.dayOfWeek = decodedResponse.dayOfWeek
          }
        } else {
          print("HTTP status code: \(httpResponse.statusCode)")
        }
      } catch {
        print("Error fetching data: \(error)")
      }

      let (data, _) = try await URLSession.shared.data(for: request)

      let decodedResponse = try JSONDecoder().decode(TimeResults.self, from: data)
      await MainActor.run {
        self.dayOfWeek = decodedResponse.dayOfWeek
      }
    } catch {
      print("error there")
      print(error)
    }
  }

  func fetchHour() async throws {
    do {
      let urlString = "https://timeapi.io/api/Time/current/coordinate?latitude=\(latitude)&longitude=\(longitude)"
      guard let url = URL(string: urlString) else {
        print("Error here")
        return
      }
      var request = URLRequest(url: url)
      request.httpMethod = "GET"

      do {
        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse else {
          print("Error here too")
          return
        }

        if (200..<300).contains(httpResponse.statusCode) {
          let decodedResponse = try JSONDecoder().decode(TimeResults.self, from: data)

          await MainActor.run {
            self.hour = decodedResponse.hour
          }
        } else {
          print("HTTP status code: \(httpResponse.statusCode)")
        }
      } catch {
        print("Error fetching data: \(error)")
      }

      let (data, _) = try await URLSession.shared.data(for: request)

      let decodedResponse = try JSONDecoder().decode(TimeResults.self, from: data)
      await MainActor.run {
        self.hour = decodedResponse.hour
      }
    } catch {
      print("error there")
      print(error)
    }
  }
}
