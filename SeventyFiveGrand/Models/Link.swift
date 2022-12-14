//
//  Links.swift
//  SeventyFiveGrand
//
//  Created by Jerome Paulos on 12/14/22.
//

import Foundation
import SwiftUI

struct Link: Hashable, Decodable, Identifiable {
    var id: Int
    var name: String
    var category: String
    private var iosIcon: String
    private var url: String

    var icon: Image { Image(systemName: iosIcon) }
    
    var urlObject: URL {
        var fullUrl = url

        if url.starts(with: "/") {
            fullUrl = "https://75grand.vercel.app" + url
        }

        if let urlObject = URL(string: fullUrl) {
            return urlObject
        } else {
            return URL(string: "https://75grand.vercel.app/404")!
        }
    }
}
