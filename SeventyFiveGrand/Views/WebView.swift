//
//  WebView.swift
//  SeventyFiveGrand
//
//  Created by Jerome Paulos on 12/15/22.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    var url: URL

    func makeUIView(context: Context) -> WKWebView {
        WKWebView(frame: .zero)
    }
    
    func updateUIView(_ view: WKWebView, context: UIViewRepresentableContext<WebView>) {
        let request = URLRequest(url: url)
        view.load(request)
    }
}
