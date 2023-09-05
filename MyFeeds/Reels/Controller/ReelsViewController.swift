//
//  ViewController.swift
//  MyFeeds
//
//  Created by Ayush Garg on 03/09/23.
//

import UIKit

protocol ReelsDisplayLogic: AnyObject {
    func displayRefresh(with data: Reels.Refresh.Response)
}

class ReelsViewController: UIViewController {

    @IBOutlet weak var reelsCollectionView: UICollectionView!
    private var viewModel: ReelsBusinessLogic?
    private var reels: [URL] = []
    private var currentPage = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        setupCollectionView()
    }
}

// MARK: - Private Methods
extension ReelsViewController {
    private func setupViewModel() {
        let reelsViewModel = ReelsViewModel()
        reelsViewModel.controller = self
        viewModel = reelsViewModel
        viewModel?.performRefresh()
    }

    private func setupCollectionView() {
        reelsCollectionView.dataSource = self
        reelsCollectionView.delegate = self
        let nib = UINib(nibName: ReelCollectionViewCell.identifier, bundle: nil)
        reelsCollectionView.register(nib, forCellWithReuseIdentifier: ReelCollectionViewCell.identifier)
    }
}

// MARK: - ReelsDisplayLogic
extension ReelsViewController: ReelsDisplayLogic {
    func displayRefresh(with data: Reels.Refresh.Response) {
        reels = data.urls
        reelsCollectionView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource
extension ReelsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reels.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReelCollectionViewCell.identifier, for: indexPath) as? ReelCollectionViewCell else { return UICollectionViewCell() }
        cell.startPlayer(with: reels[indexPath.row])
        cell.startPlayer()
        return cell
    }
}

extension ReelsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        (cell as? ReelCollectionViewCell)?.stopPlayer()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ReelsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }
}

// MARK: - UIScrollViewDelegate
extension ReelsViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // Calculate the current page (cell) based on the content offset
//        let page = Int(scrollView.contentOffset.y / scrollView.bounds.height)
//        if page != currentPage {
//            currentPage = page
//            if let cell = reelsCollectionView.cellForItem(at: IndexPath(item: currentPage, section: 0)) as? ReelCollectionViewCell {
//                cell.startPlayer()
//            }
//        }
    }
}
