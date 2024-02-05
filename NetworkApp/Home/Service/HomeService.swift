import Foundation

final class HomeService {
    
    func getPersonList(completion: @escaping (Result<[People], Error>)-> Void) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                if let error = error {
                    print("Error in \(#function): \(error.localizedDescription)")
                    completion(.failure(error))
                } else {
                    completion(.failure(NSError(domain: "No data received", code: 0, userInfo: nil)))
                }
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
                print("Invalid response in \(#function): Status Code \(statusCode)")
                completion(.failure(NSError(domain: "Invalid response", code: statusCode, userInfo: nil)))
                return
            }
            
            do {
                if let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                    let peopleList = jsonArray.map { dict -> People in
                        let name = dict["name"] as? String ?? ""
                        let username = dict["username"] as? String ?? ""
                        let phone = dict["phone"] as? String ?? ""
                        return People(name: name, userName: username, phone: phone)
                    }
                    
                    print("Success in \(#function)")
                    completion(.success(peopleList))
                } else {
                    completion(.failure(NSError(domain: "Invalid JSON format", code: 0, userInfo: nil)))
                }
            } catch {
                print("Error decoding JSON in \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
