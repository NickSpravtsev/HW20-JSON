import Foundation

func getData(request: String, completion: @escaping (Data) -> Void) {
    let urlRequest = URL(string: request)
    guard let url = urlRequest else { return }

    URLSession.shared.dataTask(with: url) { (data, response, error) in
        if let error = error {
            print("Error: \(error))")
        } else if let response = response as? HTTPURLResponse, response.statusCode == 200 {
            guard let data = data else { return }
            completion(data)
        } else {
            if let response = response {
                print("Wrong response: \(response)")
            }
        }
    }.resume()
}

func decodeJSONIntoCards(data: Data) -> Cards? {
    let decoder = JSONDecoder()

    do {
        let decodedData = try decoder.decode(Cards.self, from: data)
        return decodedData
    } catch {
        print("Failed to decode JSON!")
        return nil
    }
}

func printCardInfo(from cards: Cards?, for cardName: String) {
    guard let cards = cards else {
        print("С набором карт что-то не так! Там нет карт!")
        return
    }

    let cardIndex = cards.cards.firstIndex { card in
        card.name == cardName
    }

    guard let index = cardIndex else {
        print("Не нашлось карты с именем \(cardName)!")
        return
    }

    let card = cards.cards[index]
    let name = card.name ?? "Имя карты не задано"
    let manaCost = card.manaCost ?? "Мановая стоимость не задана"
    let type = card.type ?? "Тип карты не задан"
    let setName = card.setName ?? "Название сета не задано"
    let power = card.power ?? "Сила карты не задана"

    let info = """
    Имя карты: \(name)
    Тип: \(type)
    Мановая стоимость: \(manaCost)
    Название сета: \(setName)
    Сила карты: \(power)
    ----------
    """
    print(info)
}

let requestForOpt = "https://api.magicthegathering.io/v1/cards?name=Opt"
let requestForBlackLotus = "https://api.magicthegathering.io/v1/cards?name=Black_Lotus"

getData(request: requestForOpt) { data in
    let cards = decodeJSONIntoCards(data: data)
    printCardInfo(from: cards, for: "Opt")
}

getData(request: requestForBlackLotus) { data in
    let cards = decodeJSONIntoCards(data: data)
    printCardInfo(from: cards, for: "Black Lotus")
}
