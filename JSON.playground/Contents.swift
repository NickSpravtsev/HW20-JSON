import Foundation

func getData(request: String) {
    let urlRequest = URL(string: request)
    guard let url = urlRequest else { return }
    URLSession.shared.dataTask(with: url) { data, response, error in
        if let error = error {
            print("Error: \(error))")
        } else if let response = response as? HTTPURLResponse, response.statusCode == 200 {
            guard let data = data else { return }
            print("Response status code: \(response.statusCode)\n")

            let dataAsString = String(data: data, encoding: .utf8) ?? ""
            //print("Data: \(dataAsString)")

            decodeJSONData(data: Data(dataAsString.utf8))
        } else {
            if let response = response {
                print("Response: \(response)")
            }
        }
        print("--------------------")
    }.resume()
}

struct Cards: Codable {
    let cards: [Card]
}

struct Card: Codable {
    let name: String?
    let manaCost: String?
    let type: String?
    let setName: String?
    let power: String?
}

func decodeJSONData(data: Data) {
    let decoder = JSONDecoder()

    do {
        let decodedData = try decoder.decode(Cards.self, from: data)
        print(decodedData.cards[decodedData.cards.firstIndex(where: { Card in
            Card.name == "Opt"
        }) ?? 0])
    } catch {
        print("Failed to decode JSON!")
    }
}

let request = "https://api.magicthegathering.io/v1/cards?name=Opt"
getData(request: request)
