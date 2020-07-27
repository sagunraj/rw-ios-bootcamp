//
//  NetworkingHandler.swift
//  jQuiz
//
//  Created by Jay Strawn on 7/17/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import Foundation

class Networking {
    
    static let sharedInstance = Networking()
    
    func getRandomCategory(completion: @escaping (Int?, String) -> Void) {
        guard let url = URL(string: "http://www.jservice.io/api/random") else { return }
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: url) { (data, response, error) in
            guard let response = response as? HTTPURLResponse,
                (200..<300).contains(response.statusCode) else {
                    completion(nil, error?.localizedDescription ?? "")
                    return
            }
            guard let data = data else {
                completion(nil, "No data fetched.")
                return
            }
            let decoder = JSONDecoder()
            do {
                let decodedData = try decoder.decode([Clue].self, from: data)
                completion(decodedData[0].categoryId, "")
            } catch(let error) {
                completion(nil, error.localizedDescription)
                print("Unable to parse data: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
    
    func getAllCluesInCategory(with categoryId: Int,
                               completion: @escaping ([Clue]?, String) -> Void) {
        guard let url = URL(string: "http://www.jservice.io/api/clues/?category=\(categoryId)") else { return }
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: url) { (data, response, error) in
        guard let response = response as? HTTPURLResponse,
            (200..<300).contains(response.statusCode) else {
                completion(nil, error?.localizedDescription ?? "")
                return
            }
        guard let data = data else {
            completion(nil, "No data fetched.")
            return
        }
            let decoder = JSONDecoder()
            do {
                let decodedData = try decoder.decode([Clue].self, from: data)
                completion(decodedData, "")
            } catch(let error) {
                completion(nil, error.localizedDescription)
                print("Unable to parse data: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
    
}
