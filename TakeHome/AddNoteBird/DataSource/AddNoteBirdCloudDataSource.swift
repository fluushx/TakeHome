//
//  AddNoteBirdCloudDataSource.swift
//  TakeHome
//
//  Created by Felipe I Zapata R on 04-04-25.
//  Copyright (c) 2025 Falabella FIF. All rights reserved.
//
import Apollo
import UIKit

// MARK: - AddNoteBirdCloudDataSource
final class AddNoteBirdCloudDataSource: AddNoteBirdCloudDataSourceProtocol {
    var client: ApolloClient!

    func callAddNoteBird(birdId: String, comment: String, timestamp: Int,completion: @escaping (Result<Bool, Error>) -> Void) {
        client = createClient(
            accessToken: "cXdP3HwiAio1trBSPdWA",
            url: URL(string: "https://takehome.graphql.copilot.money")!
        )
        
        client.perform(
            mutation: GraphQL.AddNoteMutation(
                birdId: birdId,
                comment: comment,
                timestamp: timestamp
            )
        ) { result in
            switch result {
            case .success(let graphQLResult):
                guard let dataResponse = graphQLResult.data else {
                    completion(.success(false))
                    return
                }
                completion(.success(true))

            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    func callAddNoteBirdAsync(birdId: String, comment: String, timestamp: Int) async throws -> Bool {
        return try await withCheckedThrowingContinuation { continuation in
            self.callAddNoteBird(birdId: birdId, comment: comment, timestamp: timestamp, completion: { result in
                continuation.resume(with: result)
            })
        }
    }
}
