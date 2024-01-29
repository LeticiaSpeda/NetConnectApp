import UIKit

final class HomeViewModel {
    var service =  HomeService()
    
    func fetchRequest() { // metodo para disparar reqscao
        service.getPersonList { result in
            switch result {
            case .success(let success):
                print(success)
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
