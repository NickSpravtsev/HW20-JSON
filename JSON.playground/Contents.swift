import Foundation

func getData(request: String) {
    let urlRequest = URL(string: request)
    guard let url = urlRequest else { return }
    URLSession.shared.dataTask(with: url) { data, response, error in
        if let error = error {
            print("Error: \(error))")
        } else if let response = response as? HTTPURLResponse, response.statusCode == 200 {
            guard let data = data else { return }
            let dataAsString = String(data: data, encoding: .utf8) ?? ""
            print("Response status code: \(response.statusCode)\n")
            print("Data: \(dataAsString)")
        } else {
            if let response = response {
                print("Response: \(response)")
            }
        }
        print("--------------------")
    }.resume()
}
