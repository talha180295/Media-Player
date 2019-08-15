//
//  MiniPlayer.swift
//  music_demo
//
//  Created by Talha Ahmed on 05/08/2019.
//  Copyright © 2019 talha. All rights reserved.
//

import UIKit
import SDWebImage


class MiniPlayer: UIViewController,SongDetailsProtocol {
   
    

    @IBOutlet weak var song_title: UILabel!
    
    @IBOutlet weak var song_image: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       delegate = self
        
        //let tap = UITapGestureRecognizer(target: self, action: "hanldeTap")
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        song_image.addGestureRecognizer(tap)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        
        print("max_player")
        let vc =  self.storyboard?
            .instantiateViewController(withIdentifier: "ViewController")
        self.present(vc!, animated: true, completion: nil)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if(songs.count>0){
            song_title.text = songs[currentSongIndex].get_song_title()
            self.song_image.sd_setImage(with: URL(string: songs[currentSongIndex].get_song_image()))
        }
    }
    
    func setSongDetails(song_title: String, song_image: String, song_url: String) {
        self.song_title.text = song_title
        self.song_image.sd_setImage(with: URL(string: song_image))

       
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
            self.song_image.sd_setImage(with: URL(string: songs[0].get_song_image()))
            currentSongIndex = 0
        }
        else{
            playingSoundWith(fileName: songs[currentSongIndex+1].get_song_url())
            
            self.song_title.text = songs[currentSongIndex+1].get_song_title()
            self.song_image.sd_setImage(with: URL(string: songs[currentSongIndex+1].get_song_image()))
            currentSongIndex = currentSongIndex+1
        }
        
        
    }
    
    @IBAction func prev_btn(_ sender: UIButton) {
        
        if(currentSongIndex == 0){
            playingSoundWith(fileName: songs[songs.count-1].get_song_url())
            
            self.song_title.text = songs[songs.count-1].get_song_title()
            self.song_image.sd_setImage(with: URL(string: songs[songs.count-1].get_song_image()))
            currentSongIndex = songs.count-1
        }
        else{
            playingSoundWith(fileName: songs[currentSongIndex-1].get_song_url())
            
            self.song_title.text = songs[currentSongIndex-1].get_song_title()
            self.song_image.sd_setImage(with: URL(string: songs[currentSongIndex-1].get_song_image()))
            currentSongIndex = currentSongIndex-1
        }
    }
    

}
