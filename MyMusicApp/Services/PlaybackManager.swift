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
    
    func startPlayback(
        from viewController: UIViewController,
        track: SpotifySimplifiedTrack
    ) {
        guard let url = URL(string: track.preview_url ?? "") else {
            return
        }
        player = AVPlayer(url: url)
        
        let playerItem: AVPlayerItem = AVPlayerItem(url: url)
        let duration : CMTime = playerItem.asset.duration
        let seconds : Float64 = CMTimeGetSeconds(duration)
        
        player?.volume = 0.5
        
        self.track = track
        self.tracks = []
        
        let vc = PlayViewController()
        vc.modalPresentationStyle = .fullScreen
        viewController.present(vc, animated: true) { [weak self] in
            self?.player?.play()
        }
    }
    
    func startPlayback(
        from viewController: UIViewController,
        tracks: [SpotifySimplifiedTrack]
    ) {
        self.tracks = tracks
        self.track = nil
        let vc = PlayViewController()
        vc.modalPresentationStyle = .fullScreen
        viewController.present(vc, animated: true)
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
    
    func stringFromTimeInterval(interval: TimeInterval) -> String {
        let interval = Int(interval)
        let seconds = interval % 60
        let minutes = (interval / 60) % 60
        let hours = (interval / 3600)
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
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
