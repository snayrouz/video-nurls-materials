/// Copyright (c) 2022 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import SwiftUI
import Foundation
import Security

let url = URL(string: "https://api.raywenderlich.com/api/domains")!
let session = URLSession.shared.dataTask(with: url) { data, _, _ in
    guard let data = data,
          let domain = try? JSONDecoder().decode(Domains.self, from: data).data.first
    else {
        print("Reques failed")
        return
    }
    Task {
        await MainActor.run {
            print(domain)
            print(Thread.isMainThread)
        }
    }
}
session.resume()

/*
 Actors are reference types that represent a shared mutable state.
 Actors prevent concurrent access to their state so only one method can access the state at one time
 */


//func fetchDomains() async throws -> [Domain] {
//    let url = URL(string: "https://api.raywenderlich.com/api/domains")!
//    let (data, _) = try await URLSession.shared.data(from: url)
//
//    return try JSONDecoder().decode(Domains.self, from: data).data
//}
//
//func findTitle(url: URL) async throws -> String? {
//    for try await line in url.lines {
//        if line.contains("<title>") {
//            return line.trimmingCharacters(in: .whitespaces)
//        }
//    }
//    return nil
//}
//
//Task {
//    if let title = try await findTitle(url: URL(string: "https://raywenderlich.com")!) {
//        print(title)
//    }
//}
//
//extension Domains {
//    static var domains: [Domain] {
//        get async throws {
//            try await fetchDomains()
//        }
//    }
//}
//
//Task {
//    dump(try await Domains.domains)
//}
//
//extension Domains {
//    enum Error: Swift.Error { case outOfRange }
//
//    static subscript(_ index: Int) -> String {
//        get async throws {
//            let domains = try await Self.domains
//
//            guard domains.indices.contains(index) else {
//                throw Error.outOfRange
//            }
//            return domains[index].attributes.name
//        }
//    }
//}
//
//Task {
//    dump(try await Domains[4])
//}
//Task {
//    do {
//        let domains = try await fetchDomains()
//
//        for(index, domain) in domains.enumerated() {
//            let attr = domain.attributes
//            print("\(index + 1) \(attr.name): \(attr.description) - \(attr.level)")
//        }
//    } catch {
//        print(error)
//    }
//}
