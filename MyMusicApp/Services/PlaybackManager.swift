//
//  PlaybackManager.swift
//  MyMusicApp
//
//  Created by Andrey on 19.06.2023.
//

import Foundation
import UIKit
import AVFoundation

class PlaybackManager {
    
    static let shared  = PlaybackManager()
    
    private var track: SpotifySimplifiedTrack?
    private var tracks = [SpotifySimplifiedTrack]()
    
    var currentTrack: SpotifySimplifiedTrack? {
        if let track = track, tracks.isEmpty {
            return track
        } else if !tracks.isEmpty {
            return tracks.first
        }
        
        return nil
    }
    
    var player: AVPlayer?
    var playerViewController = PlayViewController()
    
    /// For single track
    func startPlayback(
        from viewController: UIViewController,
        track: SpotifySimplifiedTrack
    ) {
        playerViewController.modalPresentationStyle = .fullScreen
        
        guard let url = URL(string: track.preview_url ?? "") else {
            return
        }
        player = AVPlayer(url: url)
        player?.volume = 0.5
        
        // Calculate and set Track's duration
        let playerItem: AVPlayerItem = AVPlayerItem(url: url)
        let duration : CMTime = playerItem.asset.duration
        let seconds : Float64 = CMTimeGetSeconds(duration)
//        playerViewController.songEndLabel.text = self.stringFromTimeInterval(interval: seconds)
        
        // Set up slider maximum value
//        playerViewController.songTimeSlider.maximumValue = Float(seconds)
//        playerViewController.songTimeSlider.isContinuous = true
        
        // Calculate and set current time
        let currentDuration : CMTime = playerItem.currentTime()
        let currentSeconds : Float64 = CMTimeGetSeconds(currentDuration)
//        playerViewController.songStartLabel.text = self.stringFromTimeInterval(interval: currentSeconds)
           
        // Add observer for update slider in realtime
        player!.addPeriodicTimeObserver(
            forInterval: CMTimeMakeWithSeconds(1, preferredTimescale: 1),
            queue: DispatchQueue.main
        ) { (CMTime) -> Void in
            if self.player!.currentItem?.status == .readyToPlay {
                let time : Float64 = CMTimeGetSeconds(self.player!.currentTime());
//                self.playerViewController.songTimeSlider.value = Float ( time );
//                self.playerViewController.songStartLabel.text = self.stringFromTimeInterval(interval: time)
            }
        }
        
        self.track = track
        self.tracks = []

        viewController.present(playerViewController, animated: true) { [weak self] in
            self?.player?.play()
        }
    }
    
    /// For playlist
    func startPlayback(
        from viewController: UIViewController,
        tracks: [SpotifySimplifiedTrack]
    ) {
        self.tracks = tracks
        self.track = nil
        playerViewController.modalPresentationStyle = .fullScreen
        viewController.present(playerViewController, animated: true)
    }
    
    func playPausePlayback() {
        if let player = player {
            if player.timeControlStatus == .playing {
                player.pause()
            } else if player.timeControlStatus == .paused {
                player.play()
            }
        }
    }
    
    func forwardPlayback() {
        if let player = player {
            if tracks.isEmpty {
                player.pause()
            } else {
                // Next track in playlist
            }
        }
    }
    
    func backwardPlayback() {
        if let player = player {
            if tracks.isEmpty {
                player.pause()
                player.seek(to: .zero)
                player.play()
            } else {
                // Pervious track in playlist
            }
        }
    }
    
    func seekTrack(to time: Int64) {
        let seconds : Int64 = time
        let targetTime:CMTime = CMTimeMake(value: seconds, timescale: 1)
        player!.seek(to: targetTime)
        if player!.rate == 0 {
            player?.play()
        }
    }
}

//MARK: - Helper functions
extension PlaybackManager {
    func stringFromTimeInterval(interval: TimeInterval) -> String {
        let interval = Int(interval)
        let seconds = interval % 60
        let minutes = (interval / 60) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

//extension PlaybackManager: PlayerDataSource {
//    var songName: String? {
//        return currentTrack?.name
//    }
//
//    var subtitle: String? {
//        return currentTrack?.artists.first?.name
//    }
//
//    var imageURL: URL? {
//        return URL(string: currentTrack?.album?.first?.url ?? "")
//    }
//}
