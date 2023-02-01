//
//  FavouritesViewController.swift
//  CombineMVVM
//
//  Created by Helené Fogde Hejda on 2023-02-01.
//

import UIKit
import Combine

class FavouritesViewController: UIViewController {
    
    var viewModel = QuoteViewModel()
    var favouriteView = FavouriteView()
    private let input : PassthroughSubject<QuoteViewModel.Input, Never> = .init()
    private var cancellable = Set<AnyCancellable>()
    
    init(viewModel: QuoteViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpConstraints()
        bind()
    }
    
    func setUpConstraints(){
        view.addSubview(favouriteView)
        favouriteView.pinView(to: view)
    }
    
    private func bind(){
        viewModel.$saveQuote
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] value in
                self?.favouriteView.quoteLabel.text = value
            }).store(in: &cancellable)
    }
}
