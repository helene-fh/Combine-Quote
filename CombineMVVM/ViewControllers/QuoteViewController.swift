//
//  ViewController.swift
//  CombineMVVM
//
//  Created by Helené Fogde Hejda on 2023-02-01.
//

import UIKit
import Combine

class QuoteViewController: UIViewController {
    
    var viewModel = QuoteViewModel()
    var quoteView = QuoteView()
    private let input : PassthroughSubject<QuoteViewModel.Input, Never> = .init()
    private var cancellable = Set<AnyCancellable>()
    
    init(viewModel: QuoteViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    func refreshQuote(){
        input.send(.refreshButtonDidTap)
    }
    
    @objc
    func favouriteQuote(){
        input.send(.favouriteButtonDidTap)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpConstraints()
        quoteView.refreshButton.addTarget(self, action: #selector(refreshQuote), for: .touchUpInside)
        quoteView.favouriteButton.addTarget(self, action: #selector(favouriteQuote), for: .touchUpInside)
        bind()
    }
    
    func setUpConstraints(){
        view.addSubview(quoteView)
        quoteView.pinView(to: view)
    }
    
    private func bind(){
        let output = viewModel.transform(input: input.eraseToAnyPublisher())
        // When the vm spits out output, we need to handle it
        output
            .receive(on: DispatchQueue.main)
            .sink { [weak self] event in
            switch event {
           
            case .fetchQuoteDidSucceed(let quote):
                self?.quoteView.quoteLabel.text = quote.content
           
            case .fetchQuoteDidFail(let error):
                self?.quoteView.quoteLabel.text = error.localizedDescription
           
            case .toggleRefreshButton(let isEnabled, let color):
                self?.quoteView.refreshButton.isEnabled = isEnabled
                self?.quoteView.refreshButton.backgroundColor = color
          
            case .toggleFavouriteButton(let isEnabled, let color):
                self?.quoteView.favouriteButton.isEnabled = isEnabled
                self?.quoteView.favouriteButton.backgroundColor = color
          
            case .saveFavouriteQuote(quote: let quote):
                print(" Output in Q.VC --> \(quote)")
            }
        }.store(in: &cancellable)
    }
}








