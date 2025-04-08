//
//  BirdAddNoteInteractorTest.swift
//  TakeHomeTests
//
//  Created by Felipe I Zapata R on 07-04-25.
//

import XCTest
@testable import TakeHome

struct AddNoteResponse: Decodable {
    let data: AddNoteResult
}

struct AddNoteResult: Decodable {
    let addNote: Bool
}

// MARK: - Cloud Data Source Mock
final class AddNoteBirdCloudDataSourceMock: AddNoteBirdCloudDataSourceProtocol {
    func callAddNoteBird(birdId: String, comment: String, timestamp: Int, completion: @escaping (Result<Bool, Error>) -> Void) {
        // Look for the "addNoteResponse.json" file in the test bundle.
        guard let url = Bundle(for: AddNoteBirdCloudDataSourceMock.self)
                .url(forResource: "BirdNoteResponse", withExtension: "json") else {
            completion(.failure(NSError(domain: "Test", code: 1, userInfo: [NSLocalizedDescriptionKey: "JSON file not found"])))
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            // Decode the JSON response
            let decodedResponse = try JSONDecoder().decode(AddNoteResponse.self, from: data)
            // Return the boolean value from the response.
            completion(.success(decodedResponse.data.addNote))
        } catch {
            completion(.failure(error))
        }
    }
    
    func callAddNoteBirdAsync(birdId: String, comment: String, timestamp: Int) async throws -> Bool {
        return try await withCheckedThrowingContinuation { continuation in
            self.callAddNoteBird(birdId: birdId, comment: comment, timestamp: timestamp) { result in
                continuation.resume(with: result)
            }
        }
    }
}

// MARK: - Interactor Tests for Add Note
final class AddNoteBirdInteractorTests: XCTestCase {
    
    // Test the asynchronous add note call.
    func testCallAddNoteBirdAsync_returnsSuccess() async throws {
        // Given: Create a test local data source with a known display model and a cloud data source mock.
        let testModel = AddNoteBirdDisplayModel(
            birdId: "test-bird-id",
            birdImage: UIImage(),
            addNoteTitle: "Test Note Title"
        )
        let localDataSource = AddNoteBirdLocalDataSource(addNoteDataModel: testModel)
        let cloudDataSourceMock = AddNoteBirdCloudDataSourceMock()
        
        let interactor = AddNoteBirdInteractor(
            localDataSource: localDataSource,
            cloudDataSource: cloudDataSourceMock
        )
        
        // When: Call the async add note method on the interactor.
        let result = try await interactor.callAddNoteBirdAsync(
            birdId: localDataSource.getBirdId(),
            comment: "Test comment"
        )
        
        // Then: Assert that the result is true.
        XCTAssertTrue(result, "The add note call should return true based on the JSON response")
    }
    
    // Test the local data source getters via the interactor.
    func testLocalDataSourceGetters() {
        // Given: Create a test model with known values.
        let testImage = UIImage()
        let testTitle = "Test Note Title"
        let testModel = AddNoteBirdDisplayModel(
            birdId: "test-bird-id",
            birdImage: testImage,
            addNoteTitle: testTitle
        )
        let localDataSource = AddNoteBirdLocalDataSource(addNoteDataModel: testModel)
        let cloudDataSourceMock = AddNoteBirdCloudDataSourceMock() // Not used in this test.
        let interactor = AddNoteBirdInteractor(
            localDataSource: localDataSource,
            cloudDataSource: cloudDataSourceMock
        )
        
        // When: Retrieve values using the interactor.
        let birdId = interactor.getBirdId()
        let birdImage = interactor.getBirdImage()
        let noteTitle = interactor.addNoteTitle()
        
        // Then: Verify that the retrieved values match the test model.
        XCTAssertEqual(birdId, "test-bird-id", "The bird ID should match the test model")
        XCTAssertEqual(birdImage, testImage, "The bird image should match the test model")
        XCTAssertEqual(noteTitle, testTitle, "The note title should match the test model")
    }
}
