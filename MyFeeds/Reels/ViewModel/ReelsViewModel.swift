//
//  ReelsViewModel.swift
//  MyFeeds
//
//  Created by Ayush Garg on 03/09/23.
//

import Foundation

protocol ReelsBusinessLogic: AnyObject {
    func performRefresh()
}

final class ReelsViewModel: ReelsBusinessLogic {

    private var networkService: ReelsNetworkProtocol
    weak var controller: ReelsDisplayLogic?

    init() {
        self.networkService = ReelsNetworkService()
    }


    func performRefresh() {
        networkService.getReels {[weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                guard case .success(let response) = result else { return }
                let mediaUrls = self.getUrls(from: response.data)
                self.controller?.displayRefresh(with: .init(urls: mediaUrls))
            }
        }
    }

    private func getUrls(from data: [String]) -> [URL] {
        data.map({ URL(string: $0) }).compactMap({$0})
    }
}
