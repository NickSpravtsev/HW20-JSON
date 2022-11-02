import Foundation

public struct Cards: Codable {
    public let cards: [Card]
}

public struct Card: Codable {
    public let name: String?
    public let manaCost: String?
    public let type: String?
    public let setName: String?
    public let power: String?
}
