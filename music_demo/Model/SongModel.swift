//
//  SongModel.swift
//  music_demo
//
//  Created by Talha Ahmed on 05/08/2019.
//  Copyright © 2019 talha. All rights reserved.
//

import Foundation

class SongModel{
    
    private var song_title:String?
    private var song_image:String?
    private var song_url:String?
    
    
    func setData(song_title:String,song_image:String,song_url:String){
        
        self.song_title = song_title
        self.song_image = song_image
        self.song_url = song_url
        
        
    }
    
    func get_song_title() -> String{
        
        return song_title ?? "null"
    }
    func get_song_image() -> String{
        
        return song_image  ?? "null"
    }
    func get_song_url() -> String{
        
        return song_url  ?? "null"
    }
    
    
}
