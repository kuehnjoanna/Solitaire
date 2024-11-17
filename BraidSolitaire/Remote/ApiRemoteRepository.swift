//
//  ApiRemoteRepository.swift
//  BraidSolitaire
//
//  Created by Joanna Kühn on 13.11.24.
//

import Foundation
class ApiRemoteRepository: ApiRepository{

    
    private let apiKey = "44482891-25a4348e5d04e7daf44644db6"
    
    private var baseURL: String {
        return "https://pixabay.com/api/"
    }
    
    func fetchRandomImages() async throws -> [Hit] {
        
        
        let urlString = "\(baseURL)?key=\(apiKey)&q=green+leaves&image_type=illustration&orientation=horizontal&safesearch=true&per_page=10"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        
        let pixabayResponse = try JSONDecoder().decode(Hits.self, from: data)
        
        
        return pixabayResponse.hits
    }
}
