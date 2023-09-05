//
//  ReelsNetworkService.swift
//  MyFeeds
//
//  Created by Ayush Garg on 03/09/23.
//

import Foundation

protocol ReelsNetworkProtocol: AnyObject {
    func getReels(completion: (Result<ReelsData, Error>) -> Void)
}

final class ReelsNetworkService: ReelsNetworkProtocol {
    func getReels(completion: (Result<ReelsData, Error>) -> Void) {
        let loader = JsonLoader()
        loader.loadDataFromJson(for: "ReelsJson", type: ReelsData.self) { result in
            switch result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
}
