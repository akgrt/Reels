//
//  ReelCollectionViewCell.swift
//  MyFeeds
//
//  Created by Ayush Garg on 03/09/23.
//

import UIKit

class ReelCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var playerView: UIView!
    private var videoPlayer: VideoPlayerView?
    static let identifier = "ReelCollectionViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        videoPlayer?.frame = frame
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        stopPlayer()
    }

    func startPlayer(with url: URL) {
        let player = VideoPlayerView()
        videoPlayer = player
        playerView.addSubview(player)
        player.setupPlayer(with: url)
    }

    func startPlayer() {
        videoPlayer?.startPlayer()
    }

    func stopPlayer() {
        videoPlayer?.stopPlayer()
    }
}
