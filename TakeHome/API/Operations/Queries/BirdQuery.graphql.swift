// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

extension GraphQL {
  class BirdQuery: GraphQLQuery {
    static let operationName: String = "bird"
    static let operationDocument: ApolloAPI.OperationDocument = .init(
      definition: .init(
        #"query bird($id: ID!) { bird(id: $id) { __typename id notes { __typename id comment timestamp } } }"#
      ))

    public var id: ID

    public init(id: ID) {
      self.id = id
    }

    public var __variables: Variables? { ["id": id] }

    struct Data: GraphQL.SelectionSet {
      let __data: DataDict
      init(_dataDict: DataDict) { __data = _dataDict }

      static var __parentType: any ApolloAPI.ParentType { GraphQL.Objects.Query }
      static var __selections: [ApolloAPI.Selection] { [
        .field("bird", Bird?.self, arguments: ["id": .variable("id")]),
      ] }

      var bird: Bird? { __data["bird"] }

      /// Bird
      ///
      /// Parent Type: `Bird`
      struct Bird: GraphQL.SelectionSet {
        let __data: DataDict
        init(_dataDict: DataDict) { __data = _dataDict }

        static var __parentType: any ApolloAPI.ParentType { GraphQL.Objects.Bird }
        static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("id", GraphQL.ID.self),
          .field("notes", [Note].self),
        ] }

        var id: GraphQL.ID { __data["id"] }
        var notes: [Note] { __data["notes"] }

        /// Bird.Note
        ///
        /// Parent Type: `Note`
        struct Note: GraphQL.SelectionSet {
          let __data: DataDict
          init(_dataDict: DataDict) { __data = _dataDict }

          static var __parentType: any ApolloAPI.ParentType { GraphQL.Objects.Note }
          static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("id", GraphQL.ID.self),
            .field("comment", String.self),
            .field("timestamp", Int.self),
          ] }

          var id: GraphQL.ID { __data["id"] }
          var comment: String { __data["comment"] }
          var timestamp: Int { __data["timestamp"] }
        }
      }
    }
  }

}