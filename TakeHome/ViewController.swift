import Apollo
import UIKit

class ViewController: UIViewController {
  var client: ApolloClient!

  override func viewDidLoad() {
    super.viewDidLoad()

    client = createClient(
      accessToken: "cXdP3HwiAio1trBSPdWA",
      url: URL(string: "https://takehome.graphql.copilot.money")!
    )
    client.fetch(query: GraphQL.BirdsQuery()) { result in
        do {
            let response = try result.get()
            print(response.data?.birds)
        } catch {
            print("Error al obtener los datos: \(error)")
        }
    }
  }
}
