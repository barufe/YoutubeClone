//
//  PlaylistModel.swift
//  YoutubeClone
//
//  Created by Germain Seijas on 28/01/24.
//

import Foundation

struct PlaylistModel:Decodable {
    let kind : String
    let etag : String
    let nextPageToken : String
    let pageInfo : PageInfo
    let items : [Items]
    
    struct PageInfo : Decodable {
        let totalResults : Int
        let resultsPerPage : Int
    }
    
    struct Items : Decodable {
        let kind : String
        let etag : String
        let id : String
        let snippet : Snippet
        let contentDetails : ContentDetails
        
        struct Snippet : Decodable {
            let publishedAt : String
            let channelId : String
            let title : String
            let description : String
            let thumbnails : Thumbnails
            let channelTitle : String
            let localized : Localized
            
            struct Thumbnails : Decodable {
                let medium : Medium
                
                struct Medium : Decodable {
                    let url: String
                    let width : String
                    let height :String
                }
            }
            struct Localized : Codable {
                let title : String
                let description : String
            }
        }
        
        struct ContentDetails : Decodable {
            let itemCount : Int
        }
    }
}
