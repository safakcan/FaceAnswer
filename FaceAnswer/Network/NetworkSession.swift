//
//  NetworkSession.swift
//  OmdbMovieApp
//
//  Created by Şafak Can Baş on 26.07.2021.
//

import Foundation
import FirebaseFirestore
class NetworkSession {
    typealias QueryResult = ([QuizModel]?, String) -> Void
    typealias DatabaseResult = ([QueryDocumentSnapshot]?,String) -> Void
    var searchResult : [QuizModel] = []
    var errorMessage = ""
    let database = Firestore.firestore()
    
    func fetchMovieList(difficulty: String, category: String, completion: @escaping QueryResult) {
        URLSession.shared.dataTask(with: URL(string: "https://www.opentdb.com/api.php?amount=10&type=multiple\(difficulty)\(category)")!,  completionHandler: {data, response, error in
            self.searchResult.removeAll()
            guard let data = data, error == nil else {return}
            
            var result: QuizModelRespose?
            do {
                result = try JSONDecoder().decode(QuizModelRespose.self, from: data)
            } catch {
                self.errorMessage = error.localizedDescription
            }
            
            if let result = result {
                self.searchResult = result.results
            }
            DispatchQueue.main.async {
                completion(self.searchResult,self.errorMessage )
            }
            
        }).resume()
    }
    
    func writeDataToDB(username: String, score: Int) {
        let collection = database.collection("HighScore")
        collection.addDocument(data: ["name": username,"score": String(score)])
    }
    
    func readDataFromDB(completionHandler: @escaping DatabaseResult) {
        let collection = database.collection("HighScore")
        collection.getDocuments(completion: { snap,error in
            guard let data = snap?.documents else {self.errorMessage = error.debugDescription; return}
            DispatchQueue.main.async {
                completionHandler(data,self.errorMessage)
            }
        })
    }
}
