//
//  PostController.swift
//  MyFavoriteApp
//
//  Created by Brady Bentley on 12/12/18.
//  Copyright © 2018 Brady. All rights reserved.
//

import Foundation

class PostController {
    
    static let baseUrl = URL(string: "https://favoriteapp-375c6.firebaseio.com/users")
    
    static func fetchPosts(completion: @escaping ([Post]) -> Void) {
        //1) construct URL
        guard let url = baseUrl else { completion([]) ; return }
        let fullUrl = url.appendingPathExtension("json")
        
        //2) Request
        var request = URLRequest(url: fullUrl)
        request.httpMethod = "GET"
        request.httpBody = nil
        print(request.url?.absoluteString ?? "No URL")
        
        //3) DataTask (.resume())
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("There was an error in \(#function) : \(error.localizedDescription)")
                completion([])
                return
            }
            print(response ?? "No response")
            guard let data = data else { return }
            do {
                let jsonDecoder = JSONDecoder()
                let postDictionary = try jsonDecoder.decode([String:Post].self, from: data)
                let post = postDictionary.compactMap{ ($0.value) }
                completion(post)
            } catch {
                print("There was an error in \(#function) : \(error.localizedDescription)")
            }
        }.resume()
    }
    
    static func postReason(favApp: String, name: String, completion: @escaping (Bool) -> ()) {
        guard let url = baseUrl?.appendingPathExtension("json") else { return }
        let post = Post(favApp: favApp, name: name)
        var request = URLRequest(url: url)
        do {
            let jsonEncoder = JSONEncoder()
            let data = try jsonEncoder.encode(post)
            request.httpMethod = "POST"
            request.httpBody = data
            
            URLSession.shared.dataTask(with: request) { (_, response, error) in
                if let error = error {
                    print("There was an error in \(#function) : \(error.localizedDescription)")
                    completion(false)
                    return
                }
                print(response ?? "No response")
                completion(true)
            }.resume()
            
        } catch {
            print("There was an error in \(#function) : \(error.localizedDescription)")
            completion(false)
            return
        }
    }
}
