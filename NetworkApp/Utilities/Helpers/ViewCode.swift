protocol ViewCode {
    func commonInit()
    func setupHierarchy()
    func setupConstraints()
    func setupStyle()
}

extension ViewCode {
    func commonInit() {
        setupHierarchy()
        setupConstraints()
        setupStyle()
    }
    
    func setupStyle() {}
}
