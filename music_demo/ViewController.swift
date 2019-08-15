//
//  ViewController.swift
//  music_demo
//
//  Created by talha on 03/08/2019.
//  Copyright © 2019 talha. All rights reserved.
//

import UIKit
import CoreMedia

class ViewController: UIViewController {


    @IBOutlet weak var songImage: UIImageView!
    @IBOutlet weak var song_title: UILabel!
    
    @IBOutlet weak var slider: UISlider!
    
    
    var timer = Timer()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Name:\(songs)")

        
    }
    override func viewDidAppear(_ animated: Bool) {
        
        
        slider.minimumValue = 0
        
        
        let duration : CMTime = (playerItem?.asset.duration)!
        let seconds : Float64 = CMTimeGetSeconds(duration)
        
        slider.maximumValue = Float(seconds)
        slider.isContinuous = true
        
        if(songs.count>0){
            self.song_title.text = songs[currentSongIndex].get_song_title()
            self.songImage.sd_setImage(with: URL(string: songs[currentSongIndex].get_song_image()))
        }
        
       
        
        // start the timer
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(update_slider), userInfo: nil, repeats: true)
    }
    

    @IBAction func play_btn(_ sender: UIButton) {
        audioPlayer?.play()
        
    }
    @IBAction func pause_btn(_ sender: UIButton) {
        audioPlayer?.pause()
    }
    
    @IBAction func next_btn(_ sender: UIButton) {
        
        if(currentSongIndex+1 == songs.count){
            playingSoundWith(fileName: songs[0].get_song_url())
            self.song_title.text = songs[0].get_song_title()
            self.songImage.sd_setImage(with: URL(string: songs[0].get_song_image()))
            currentSongIndex = 0
        }
        else{
            playingSoundWith(fileName: songs[currentSongIndex+1].get_song_url())
            self.song_title.text = songs[currentSongIndex+1].get_song_title()
            self.songImage.sd_setImage(with: URL(string: songs[currentSongIndex+1].get_song_image()))
            currentSongIndex = currentSongIndex+1
        }
        
        
    }
    
    @IBAction func prev_btn(_ sender: UIButton) {
        
        if(currentSongIndex == 0){
            playingSoundWith(fileName: songs[songs.count-1].get_song_url())
            self.song_title.text = songs[songs.count-1].get_song_title()
            self.songImage.sd_setImage(with: URL(string: songs[songs.count-1].get_song_image()))
            currentSongIndex = songs.count-1
        }
        else{
            playingSoundWith(fileName: songs[currentSongIndex-1].get_song_url())
            self.song_title.text = songs[currentSongIndex-1].get_song_title()
            self.songImage.sd_setImage(with: URL(string: songs[currentSongIndex-1].get_song_image()))
            currentSongIndex = currentSongIndex-1
        }
    }
    
    
    @IBAction func changeAudioTime(_ sender: Any) {
        
//        audioPlayer?.pause()
//        audioPlayer?.seek(to: TimeInterval(slider.value))
//        audioPlayer?.prepare
        
        let seconds : Int64 = Int64(slider.value)
        let targetTime:CMTime = CMTimeMake(value: seconds, timescale: 1)
        print("targetTime=\(targetTime)")
        audioPlayer?.seek(to: targetTime)
        
        if audioPlayer?.rate == 0
        {
            audioPlayer?.play()
        }
    }
    
   @objc func update_slider(){
    
    let duration : CMTime = (playerItem?.currentTime())!
    let seconds : Float64 = CMTimeGetSeconds(duration)
    
    slider.value = Float(seconds)
    }
    
    @IBAction func backBtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

