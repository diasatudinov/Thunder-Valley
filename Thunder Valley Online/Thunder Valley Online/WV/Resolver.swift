//
//  Resolver.swift
//  Thunder Valley Online
//
//  Created by Dias Atudinov on 20.11.2024.
//

import Foundation

class MontrealResolver: NSObject, URLSessionTaskDelegate {
    func resolveIt(from originalURL: URL, completion: @escaping (URL?) -> Void) {
        let session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
        let task = session.dataTask(with: originalURL) { _, response, _ in
            if let httpResponse = response as? HTTPURLResponse, let finalURL = httpResponse.url {
                completion(finalURL)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, willPerformHTTPRedirection response: HTTPURLResponse, newRequest request: URLRequest, completionHandler: @escaping (URLRequest?) -> Void) {
       
        completionHandler(request)
    }
    
    
    static func checking() async -> Bool {
        let urlString = MontrealLinks.montrealData
        
        if let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
           let url = URL(string: encodedString) {
            
            let handler = MontrealResolver()
            
            return await withCheckedContinuation { continuation in
                handler.resolveIt(from: url) { finalURL in
                    DispatchQueue.main.async {
                        if let finalURL {
                            continuation.resume(returning: finalURL.host?.contains("google") ?? true)
                        } else {
                            continuation.resume(returning: false)
                        }
                    }
                }
            }
            
        } else {
            return false
        }
    }
    
}
