//
//  SongsViewController.swift
//  music_demo
//
//  Created by Talha Ahmed on 05/08/2019.
//  Copyright © 2019 talha. All rights reserved.
//

import UIKit
import AVFoundation


protocol SongDetailsProtocol {
    func setSongDetails(song_title:String,song_image:String,song_url:String)
}

var songs:[SongModel] = []
//var audioPlayer = AVAudioPlayer()
var audioPlayer: AVPlayer?
var currentSongIndex = 0
var playerItem:AVPlayerItem?

var delegate:SongDetailsProtocol!

func playingSoundWith(fileName: String) {
    
    
    let url = fileName//"https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3"
    playerItem = AVPlayerItem( url:NSURL( string:url )! as URL )
    audioPlayer = AVPlayer(playerItem:playerItem)
    audioPlayer!.rate = 1.0;
    
    audioPlayer!.play()
//    do {
//        audioPlayer = try AVAudioPlayer(contentsOf: Bundle.main.url(forResource: fileName, withExtension: "mp3")!)
//        audioPlayer.prepareToPlay()
//        audioPlayer.play()
//
//    } catch {
//        print(error)
//    }
}

class SongsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var miniPlayerView: UIView!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getAllSongs()
        //playingSoundWith(fileName: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3")
        //getSongs()
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = songs[indexPath.row].get_song_title()
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(songs[indexPath.row])
        playingSoundWith(fileName: songs[indexPath.row].get_song_url())
        currentSongIndex = indexPath.row
        miniPlayerView.isHidden = false
        delegate.setSongDetails(song_title: songs[indexPath.row].get_song_title(), song_image: songs[indexPath.row].get_song_image(), song_url: songs[indexPath.row].get_song_url())
    }

    
    func getSongs(){
        
        let folderUrl = URL(fileURLWithPath: Bundle.main.resourcePath!)
        
        do{
            let songPath = try FileManager.default.contentsOfDirectory(at: folderUrl, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
            
            for song in songPath{
                
                var songName = song.absoluteString
                
                if(songName.contains(".mp3")){
                    
                    let findString = songName.components(separatedBy: "/")
                    songName = findString[findString.count-1]
                    songName = songName.replacingOccurrences(of: "%20", with: " ")
                    songName = songName.replacingOccurrences(of: ".mp3", with: "")
                    
                    //songs.append(songName)
                    //print(songName)
                }
                
                tableView.reloadData()
            }
            
        }
        catch{
            
            
        }
    }
    
    
    func getAllSongs(){
        
        
        
        
        let songObj1 = SongModel()
        songObj1.setData(song_title: "Doorie", song_image:"https://purpledimes.com/Diftech/webservices/songs/Doorie.jpg" , song_url: "https://purpledimes.com/Diftech/webservices/songs/Doorie.mp3")
       
    
        songs.append(songObj1)
        
        let songObj2 = SongModel()
        songObj2.setData(song_title: "Skrux_-_You___Me", song_image:"https://purpledimes.com/Diftech/webservices/songs/skrux.jpg" , song_url: "https://purpledimes.com/Diftech/webservices/songs/Skrux_-_You___Me.mp3")
    
        songs.append(songObj2)
        
        
        tableView.reloadData()
        
    }
    
}
