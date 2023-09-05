//
//  JsonLoader.swift
//  MyFeeds
//
//  Created by Ayush Garg on 03/09/23.
//

import Foundation

final class JsonLoader {
    func loadDataFromJson<T: Decodable>(for file: String, type: T.Type, completion: (Result<T, Error>) -> Void) {
        guard let url = Bundle.main.url(forResource: file, withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let response = try? JSONDecoder().decode(T.self, from: data) else {
            completion(.failure(FeedsError.invalidRequest))
            return
        }
        completion(.success(response))
    }
}
