//
//  ApiViewModel.swift
//  BraidSolitaire
//
//  Created by Joanna Kühn on 13.11.24.
//

import Foundation
import Foundation
import Combine

class ApiViewModel: ObservableObject {
    
    @Published var images: [Hit] = []
    @Published var errorMessage: String? = nil
    @Published var randomImage: Hit? = nil
    
    private let repository: ApiRemoteRepository
    
    init(repository: ApiRemoteRepository = ApiRemoteRepository()) {
        self.repository = repository
        fetchImages()
    }
    
    func fetchImages() {
        Task {
            do {
                let fetchedImages = try await repository.fetchRandomImages()
                
                await MainActor.run {
                    self.images = fetchedImages
                    self.randomImage = images.randomElement()
                }
                
            } catch {
                await MainActor.run {
                    self.errorMessage = "Failed to load images: \(error.localizedDescription)"
                }
            }
        }
    }
}
