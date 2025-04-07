//
//  BirdDetailCloudDataSource.swift
//  TakeHome
//
//  Created by Felipe I Zapata R on 03-04-25.
//

import Foundation
import Apollo

// MARK: - BirdDetailCloudDataSource
final class BirdDetailCloudDataSource: BirdDetailCloudDataSourceProtocol {
    var client: ApolloClient!

    func fetchBirdNotes(id: String, completion: @escaping (Result<[Notes], Error>) -> Void) {
        client = createClient(
            accessToken: "cXdP3HwiAio1trBSPdWA",
            url: URL(string: "https://takehome.graphql.copilot.money")!
        )
        
        client.fetch(query: GraphQL.BirdQuery(id: id)) { result in
            switch result {
            case .success(let graphQLResult):
                guard let birdNoteResponse = graphQLResult.data?.bird?.notes else {
                    completion(.failure(FetchError.noData))
                    return
                }
                let birds: [Notes] = birdNoteResponse.map { note in
                    Notes(
                        id: note.id,
                        comment: note.comment,
                        timestamp: note.timestamp
                    )
                }
                completion(.success(birds))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
