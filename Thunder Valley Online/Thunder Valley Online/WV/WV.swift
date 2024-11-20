import Foundation
import SwiftUI
import WebKit


struct WV: UIViewRepresentable {
    let url: URL
    var allowsBackForwardNavigationGestures: Bool = true

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.allowsBackForwardNavigationGestures = allowsBackForwardNavigationGestures
        webView.uiDelegate = context.coordinator
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        uiView.load(request)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, WKUIDelegate {
        var parent: WV

        init(_ parent: WV) {
            self.parent = parent
        }
        
        func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
            if navigationAction.targetFrame == nil {
                webView.load(navigationAction.request)
            }
            return nil
        }
    }
}

struct WVWrap: View {
    @State private var nAllow = true
    var urlString = ""

    var body: some View {
        if let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
           let url = URL(string: encodedString) {
            WV(url: url)
                .onDisappear {
                    nAllow = true
                }
        }
    }
}

