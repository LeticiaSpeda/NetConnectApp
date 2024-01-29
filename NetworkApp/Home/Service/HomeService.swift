import Foundation

final class HomeService {
    
    func getPersonList(completion: @escaping (Result<PersonList, Error>)-> Void) {
        guard let url = URL(string: "https://run.mocky.io/v3/65af81de-e83e-4cce-b751-f239388fdff5") else {
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
                let personList: PersonList = try JSONDecoder().decode(PersonList.self, from: data)
                print("Success in \(#function)")
                completion(.success(personList))
            } catch  {
                print("Error decoding JSON in \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
