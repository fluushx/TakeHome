//
//  BirdCloudDataSource.swift
//  TakeHome
//
//  Created by Felipe I Zapata R on 03-04-25.
//
import Apollo
import UIKit

// MARK: - BirdCloudDataSource
final class BirdCloudDataSource: BirdCloudDataSourceProtocol {
    var client: ApolloClient!

    func fetchBirdData(completion: @escaping (Result<[BirdDisplayModel], Error>) -> Void) {
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
                let birds: [BirdDisplayModel] = birdsResponse.map { bird in
                    BirdDisplayModel(
                        id: bird.id,
                        thumbURL: URL(string: bird.thumb_url),
                        imageURL: URL(string: bird.image_url),
                        latinName: bird.latin_name,
                        englishName: bird.english_name,
                        notes: bird.notes.map {
                            Notes(
                                id: $0.id,
                                comment: $0.comment,
                                timestamp: $0.timestamp
                            )
                        },
                        image: UIImage()
                    )
                }
                completion(.success(birds))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func downloadImage(for url: URL, completion: @escaping (UIImage?) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            if let data = try? Data(contentsOf: url),
               let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    completion(image)
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }
}
