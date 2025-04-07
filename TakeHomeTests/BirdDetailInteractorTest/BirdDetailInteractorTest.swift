//
//  BirdDetailInteractorTest.swift
//  TakeHomeTests
//
//  Created by Felipe I Zapata R on 07-04-25.
//
import XCTest
@testable import TakeHome

struct GraphQLBirdNote: Decodable {
    let id: String
    let comment: String
    let timestamp: Int
}

struct GraphQLBirdDetailResponse: Decodable {
    let data: BirdDetailDataContainer
}

struct BirdDetailDataContainer: Decodable {
    let bird: GraphQLBirdDetail
}

struct GraphQLBirdDetail: Decodable {
    let id: String
    let notes: [GraphQLBirdNote]
}


final class BirdDetailCloudDataSourceMock: BirdDetailCloudDataSourceProtocol {
    func fetchBirdNotes(id: String, completion: @escaping (Result<[Notes], Error>) -> Void) {
        // Look for the "BirdResponse200.json" file in the test bundle.
        guard let url = Bundle(for: BirdDetailCloudDataSourceMock.self)
            .url(forResource: "BirdResponse200", withExtension: "json") else {
            completion(.failure(NSError(domain: "Test", code: 1, userInfo: [NSLocalizedDescriptionKey: "JSON file not found"])))
            return
        }
        do {
            let data = try Data(contentsOf: url)
            let decodedResponse = try JSONDecoder().decode(GraphQLBirdDetailResponse.self, from: data)
            // Map the response to our Notes model
            let notes = decodedResponse.data.bird.notes.map { note in
                Notes(
                    id: note.id,
                    comment: note.comment,
                    timestamp: note.timestamp
                )
            }
            completion(.success(notes))
        } catch {
            completion(.failure(error))
        }
    }
}


final class BirdDetailInteractorTests: XCTestCase {
    
    func testFetchBirdNotes_updatesLocalDataSourceAndRemovesTypename() {
        // Given: Create an initial selectedBird without notes and configure the local data source and cloud mock.
        let initialBird = BirdDisplayModel(
            id: "1-nothoprocta-perdicaria",
            thumbURL: URL(string: "https://example.com/thumb.jpg"),
            imageURL: URL(string: "https://example.com/image.jpg"),
            latinName: "Nothoprocta perdicaria",
            englishName: "Chileans Tinamou",
            notes: [],
            image: UIImage(),
            isImageLoaded: true
        )
        let localDataSource = BirdDetailLocalDataSource(selectedBird: initialBird)
        let cloudDataSourceMock = BirdDetailCloudDataSourceMock()
        let interactor = BirdDetailInteractor(localDataSource: localDataSource,
                                              cloudDataSource: cloudDataSourceMock)
        
        let expectation = self.expectation(description: "fetchBirdNotes")
        
        // When: Call the interactor method to fetch and update the bird notes.
        interactor.fetchBirdNotes(id: "1-nothoprocta-perdicaria") { result in
            // Then: Validate that the data is correctly updated.
            switch result {
            case .success(let detailDisplayModel):
                // According to the JSON, 8 notes are expected.
                XCTAssertEqual(detailDisplayModel.count, 8, "The number of notes should be 8")
                
                // Validate some properties of the first note.
                if let firstNote = detailDisplayModel.first {
                    XCTAssertEqual(firstNote.id, "1", "The ID of the first note should be '1'")
                    XCTAssertEqual(firstNote.comment, "Lolololl", "The comment of the first note should be 'Lolololl'")
                    XCTAssertEqual(firstNote.timestamp, 1, "The timestamp of the first note should be 1")
                }
                
                // Update the selectedBird with the new notes and validate.
                let updatedBird = localDataSource.updateBirdNotes(birdNotes: detailDisplayModel)
                XCTAssertEqual(updatedBird.notes?.count, 8, "The selectedBird should have 8 updated notes")
                
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Error fetching notes: \(error)")
            }
        }
        waitForExpectations(timeout: 10.0, handler: nil)
    }
}
