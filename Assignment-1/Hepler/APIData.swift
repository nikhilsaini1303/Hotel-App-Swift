//
//  APICaller.swift
//  Hotel-App
//
//  Created by Nikhil Saini on 28/03/23.
//

import Foundation
    
struct Hotels : Codable {
    let q:String?
    let rid:String?
    let sr:[Hotel]
}
   
struct Hotel: Codable {
    let regionNames: Details?
}

struct Details: Codable {
    let fullName: String?
    let shortName: String?
    let displayName: String?
    let primaryDisplayName: String?
    let secondaryDisplayName: String?
    let lastSearchName: String?
}

