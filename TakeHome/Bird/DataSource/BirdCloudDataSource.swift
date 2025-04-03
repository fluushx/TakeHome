//
//  BirdCloudDataSource.swift
//  TakeHome
//
//  Created by Felipe I Zapata R on 03-04-25.
//  Copyright (c) 2025 Falabella FIF. All rights reserved.
//
import Apollo
import UIKit

// MARK: - FetchErrorEnum

enum FetchError: Error {
    case noData
}

// MARK: - BirdCloudDataSource
final class BirdCloudDataSource: BirdCloudDataSourceProtocol {
    var client: ApolloClient!

    func fetchBirdData(completion: @escaping (Result<[BirdModel], Error>) -> Void) {
        client = createClient(
            accessToken: "cXdP3HwiAio1trBSPdWA",
            url: URL(string: "https://takehome.graphql.copilot.money")!
        )
        
        client.fetch(query: GraphQL.BirdsQuery()) { result in
            switch result {
            case .success(let graphQLResult):
                guard let birdsResponse = graphQLResult.data?.birds else {
                    completion(.failure(FetchError.noData))
                    return
                }
                
                let birds: [BirdModel] = birdsResponse.map { bird in
                    BirdModel(
                        id: bird.id,
                        thumbURL: URL(
                            string: bird.thumb_url
                        ),
                        imageURL: URL(
                            string: bird.image_url
                        ),
                        latinName: bird.latin_name,
                        englishName: bird.english_name,
                        notes: bird.notes.map {
                            Note(
                                id: $0.id
                            )
                        }
                    )
                }
                completion(.success(birds))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    func fetchBirdDataAsync() async throws -> [BirdModel] {
        return try await withCheckedThrowingContinuation { continuation in
            self.fetchBirdData { result in
                continuation.resume(with: result)
            }
        }
    }
}
