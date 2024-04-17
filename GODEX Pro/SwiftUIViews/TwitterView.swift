//
//  SocialMediaView.swift
//  GODEX Pro
//
//  Created by Tyler Vergin on 6/4/23.
//

import SwiftUI
import WebKit


struct TwitterView: UIViewRepresentable {
    typealias UIViewType = WKWebView
    var urlToDisplay: URL = URL(string:"https://twitter.com/pokemongonews?lang=en")!
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.load(URLRequest(url: urlToDisplay))
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        
    }
    
    
    
    
}

struct SocialMediaView_Previews: PreviewProvider {
    static var previews: some View {
        TwitterView()
    }
}
