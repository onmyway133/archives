//
//  ViewController.swift
//  Cine
//
//  Created by Khoa Pham on 09/27/2015.
//  Copyright (c) 2015 Khoa Pham. All rights reserved.
//

import UIKit
import Cine
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var totalTimeLabel: UILabel!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!

    var player: Player!
    var layer: AVPlayerLayer!

    override func viewDidLoad() {
        super.viewDidLoad()

        layer = AVPlayerLayer()
        layer.videoGravity = AVLayerVideoGravityResizeAspectFill
        view.layer.insertSublayer(layer, atIndex: 0)

        player = Player(option: Option.defaultOption(), layer: layer)
        player.addDelegate(self)

        if let url = NSURL(string: "https://clips.vorwaerts-gmbh.de/VfE_html5.mp4") {
            player.play(url)
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layer.frame = view.bounds
    }
}

extension ViewController : PlayerDelegate {
    func playerDidChangeCurrentItem(player: Player) {
        log()
    }

    func player(player: Player, didChangeStatus status: Status) {
        log()
    }

    func player(player: Player, didChangeLoadState state: LoadState) {
        if state == .PlaythroughOK {
            indicatorView.stopAnimating()
        } else {
            indicatorView.startAnimating()
        }
    }

    func player(player: Player, didChangePlaybackState state: PlaybackState) {
        playButton.selected = !player.isPlaying
    }

    func playerDidLoadDuration(player: Player) {
        slider.maximumValue = Float(player.duration)
        totalTimeLabel.text = format(player.duration)
    }

    func playerDidTick(player: Player) {
        slider.value = Float(player.currentPlaybackTime)
        timeLabel.text = format(player.currentPlaybackTime)
    }

    func player(player: Player, didFinishWithResult: Result) {
        log()
    }

    func playerDidBeginSeeking(player: Player) {
        log()
    }

    func playerDidEndSeeking(player: Player) {
        player.resume()
    }
}

extension ViewController {
    @IBAction func playButtonTouched(sender: UIButton) {
        if player.isPlaying {
            player.pause()
        } else {
            player.resume()
        }
    }

    @IBAction func sliderTouchDown(sender: UISlider) {
        
    }

    @IBAction func sliderTouchUpOutside(sender: UISlider) {

    }

    @IBAction func sliderTouchUpInside(sender: UISlider) {

    }

    @IBAction func sliderValueChanged(sender: UISlider) {
        player.currentPlaybackTime = NSTimeInterval(sender.value)
    }
}

extension ViewController {
    func log(function: String = __FUNCTION__) {
        print("\(function)")
    }

    func format(timeInterval: NSTimeInterval) -> String {
        let interval = Int(timeInterval)
        let seconds = interval % 60
        let minutes = (interval / 60) % 60
        let hours = (interval / 3600)

        if hours > 0 {
            return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        } else {
            return String(format: "%02d:%02d", minutes, seconds)
        }


    }
}

