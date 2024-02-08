import UIKit

final class CustomTableViewCell: UITableViewCell, ViewCode {
    static let identifier = String(describing: CustomTableViewCell.self)
    
    // MARK -  Properties
    lazy var screen: CustomTableViewCellScreen = {
        let view = CustomTableViewCellScreen()
        view.enableViewCode()
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
    
    
    func setpHomeCell(data: People) {
        screen.nameLabel.text = "Nome: \(data.name)"
        screen.surnameLabel.text = "UserName: \(data.username)"
        screen.phoneLabel.text = "Telefone: \(data.phone)"
    }
    
    // MARK - Helpers
    func setupHierarchy() {
        addSubview(screen)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            screen.topAnchor.constraint(equalTo: contentView.topAnchor),
            screen.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            screen.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            screen.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    func setupStyle() {
        selectionStyle = .none
    }
}
