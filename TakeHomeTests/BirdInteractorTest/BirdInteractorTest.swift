//
//  BirdInteractorTest.swift
//  TakeHomeTests
//
//  Created by Felipe I Zapata R on 07-04-25.
//

import XCTest
@testable import TakeHome

struct GraphQLBirdsResponse: Decodable {
    let data: DataContainer
}

struct DataContainer: Decodable {
    let birds: [GraphQLBird]
}

struct GraphQLBird: Decodable {
    let id: String
    let thumb_url: String
    let image_url: String
    let latin_name: String
    let english_name: String
    let notes: [GraphQLNote]
}

struct GraphQLNote: Decodable {
    let id: String
    let comment: String
    let timestamp: Int
}


final class BirdCloudDataSourceMock: BirdCloudDataSourceProtocol {
    var shouldReturnError = false

    func fetchBirdData(completion: @escaping (Result<[BirdDisplayModel], Error>) -> Void) {
        if shouldReturnError {
            completion(.failure(NSError(domain: "Test", code: 1, userInfo: nil)))
        } else {
            guard let url = Bundle(for: BirdCloudDataSourceMock.self).url(forResource: "BirdsResponse200", withExtension: "json") else {
                completion(.failure(NSError(domain: "Test", code: 2, userInfo: [NSLocalizedDescriptionKey: "JSON file not found"])))
                return
            }
            do {
                let data = try Data(contentsOf: url)
                let decodedResponse = try JSONDecoder().decode(GraphQLBirdsResponse.self, from: data)
                let birds = decodedResponse.data.birds.map { bird in
                    BirdDisplayModel(
                        id: bird.id,
                        thumbURL: URL(string: bird.thumb_url),
                        imageURL: URL(string: bird.image_url),
                        latinName: bird.latin_name,
                        englishName: bird.english_name,
                        notes: bird.notes.map { note in
                            Notes(id: note.id, comment: note.comment, timestamp: note.timestamp)
                        },
                        image: UIImage()
                    )
                }
                completion(.success(birds))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func downloadImage(for url: URL, completion: @escaping (UIImage?) -> Void) {
        let dummyImage = UIImage()
        completion(dummyImage)
    }
}


// Mock de la capa local para almacenar la data
final class BirdLocalDataSourceMock: BirdLocalDataSourceProtocol {
    private var storedBirds: [BirdDisplayModel] = []
    
    func setBirdData(_ birds: [BirdDisplayModel]) {
        storedBirds = birds
    }
    
    func getBirdData() -> [BirdDisplayModel] {
        return storedBirds
    }
}

final class BirdInteractorTests: XCTestCase {
    
    func testFetchBirdDataWithImages_UsingLocalJSON() {
        // Given: We configure the mocks and the interactor with the controlled data.
        let cloudDataSourceMock = BirdCloudDataSourceMock()
        let localDataSourceMock = BirdLocalDataSourceMock()
        let interactor = BirdInteractor(localDataSource: localDataSourceMock,
                                        cloudDataSource: cloudDataSourceMock)
        let expectation = self.expectation(description: "FetchBirdDataWithImages")
        
        // When: We execute the interactor method to get the birds data and update the localDataSource.
        interactor.fetchBirdDataWithImages(onBatch: { batch in
            // Opcional: Aquí podrías verificar el contenido parcial de cada batch si es necesario.
        }) { birds in
            // Then: We validate that the final answer is not empty,
            XCTAssertFalse(birds.isEmpty, "La respuesta debe contener birds")
            XCTAssertEqual(localDataSourceMock.getBirdData().count, birds.count,
                           "El localDataSource debe haber almacenado la misma cantidad de birds")
            for bird in birds {
                XCTAssertTrue(bird.isImageLoaded, "Cada bird debe tener la imagen cargada")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10.0, handler: nil)
    }

    func testFetchBirdDataWithImages_updatesRealLocalDataSource() {
        // Given: We inject the cloud layer mock and the actual BirdLocalDataSource.
        let cloudDataSourceMock = BirdCloudDataSourceMock()
        let localDataSource = BirdLocalDataSource()  // Implementación real
        let interactor = BirdInteractor(localDataSource: localDataSource,
                                        cloudDataSource: cloudDataSourceMock)
        let expectation = self.expectation(description: "fetchBirdDataWithImages")
        var batchCallCount = 0
        // When:
        interactor.fetchBirdDataWithImages(onBatch: { batch in
            // Here we partially validate each batch received.
            batchCallCount += 1
            XCTAssertFalse(batch.isEmpty, "El batch no debe estar vacío")
            for bird in batch {
                // We validate that, in each batch, the image has been processed.
                XCTAssertTrue(bird.isImageLoaded, "Cada bird en el batch debe tener la imagen cargada")
            }
        }) { birds in
            // Then:
            XCTAssertFalse(birds.isEmpty, "La respuesta debe contener birds")
            XCTAssertEqual(localDataSource.getBirdData().count, birds.count,
                           "El localDataSource debe contener la misma cantidad de birds")
            
         
            for bird in birds {
                XCTAssertTrue(bird.isImageLoaded, "Cada bird debe tener la imagen cargada")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10.0, handler: nil)
    }
    func testSetBirdData_storesAndReturnsSameData() {
            // Given: We create a real instance of BirdLocalDataSource.
            let localDataSource = BirdLocalDataSource()
            
            // Define Dummy Models
            let bird1 = BirdDisplayModel(
                id: "1-nothoprocta-perdicaria",
                thumbURL: URL(string: "https://storage.googleapis.com/copilot-take-home/18082018074355perdiz_chilena_pedro_valencia_web.200x0.jpg"),
                imageURL: URL(string: "https://storage.googleapis.com/copilot-take-home/18082018074355perdiz_chilena_pedro_valencia_web.jpg"),
                latinName: "Nothoprocta perdicaria",
                englishName: "Chileans Tinamou",
                notes: [
                    Notes(id: "1", comment: "first", timestamp: 1),
                    Notes(id: "16", comment: "New comment", timestamp: 16)
                ],
                image: UIImage(),
                isImageLoaded: true
            )
            
            let bird2 = BirdDisplayModel(
                id: "10-spheniscus-magellanicus",
                thumbURL: URL(string: "https://storage.googleapis.com/copilot-take-home/28082018011241pinguino_de_magallanes_paula_de_marco_web.200x0.jpg"),
                imageURL: URL(string: "https://storage.googleapis.com/copilot-take-home/28082018011241pinguino_de_magallanes_paula_de_marco_web.jpg"),
                latinName: "Spheniscus magellanicus",
                englishName: "Magellanic Penguin",
                notes: [],
                image: UIImage(),
                isImageLoaded: false
            )
            
            let birdsToSet = [bird1, bird2]
            
            // When: The data is stored using setBirdData.
            localDataSource.setBirdData(birdsToSet)
            let storedBirds = localDataSource.getBirdData()
            
            // Then: Validate that the returned data is the same as the one entered.
            XCTAssertEqual(storedBirds.count, birdsToSet.count, "El número de birds almacenados debe coincidir con el número ingresado.")
            
            // We validate each key property (you can extend these validations according to your needs).
            for (index, bird) in storedBirds.enumerated() {
                XCTAssertEqual(bird.id, birdsToSet[index].id, "El ID debe coincidir.")
                XCTAssertEqual(bird.latinName, birdsToSet[index].latinName, "El nombre latino debe coincidir.")
                XCTAssertEqual(bird.englishName, birdsToSet[index].englishName, "El nombre en inglés debe coincidir.")
                XCTAssertEqual(bird.notes?.count, birdsToSet[index].notes?.count, "La cantidad de notas debe coincidir.")
            }
        }
}
