import UIKit

protocol HomeViewModelDelegate: AnyObject {
    func success()
    func error(message: String)
}

final class HomeViewModel {
    
    private let service =  HomeService()
    private var peopleList: [People] = []
    private weak var delegate: HomeViewModelDelegate?
    
    var numberOfRowsInSection: Int {
        return peopleList.count
    }
    
    func delegate(delegate: HomeViewModelDelegate) {
        self.delegate = delegate
    }
    
    func fetchRequest() { // metodo para disparar reqscao
        service.getPersonList { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let success):
                print(success)
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func loadCurrentPeople(indexPath: IndexPath) -> People {
        return peopleList[indexPath.row]
    }
}
