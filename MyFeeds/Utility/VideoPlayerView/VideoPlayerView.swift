//
//  VideoPlayerView.swift
//  MyFeeds
//
//  Created by Ayush Garg on 03/09/23.
//

import UIKit
import AVFoundation

final class VideoPlayerView: UIView {
    enum PlayerStatus {
        case play
        case pause
    }

    var mediaUrl: URL?
    var videoPlayer: AVPlayer?
    var videoPlayerLayer: AVPlayerLayer?
    var playerStatus: PlayerStatus = .pause

    override func layoutSubviews() {
        super.layoutSubviews()
        videoPlayerLayer?.frame = frame
    }

    func stopPlayer() {
        videoPlayer?.pause()
        playerStatus = .pause
    }

    func startPlayer() {
        guard let player = videoPlayer, playerStatus == .pause else { return }
        player.play()
        playerStatus = .play
    }

    func removePlayer() {
        videoPlayerLayer?.removeFromSuperlayer()
    }

    func setupPlayer(with url: URL) {
//        let url = URL(string: "https://storage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4")!
        self.translatesAutoresizingMaskIntoConstraints = false
        try? AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [])
        if self.videoPlayerLayer != nil {
            self.videoPlayerLayer?.removeFromSuperlayer()
            self.videoPlayerLayer = nil
        }
        let asset = AVURLAsset(url: url, options: nil)
        let playerItem = AVPlayerItem(asset: asset)
        let player = AVPlayer(playerItem: playerItem)
        videoPlayer = player
        let playerLayer = AVPlayerLayer(player: player)
        videoPlayerLayer = playerLayer
        player.volume = 1
        playerLayer.videoGravity = .resizeAspectFill
        layer.addSublayer(playerLayer)
    }
}
