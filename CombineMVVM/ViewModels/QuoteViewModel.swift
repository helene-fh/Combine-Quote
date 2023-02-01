//
//  QuoteViewModel.swift
//  CombineMVVM
//
//  Created by Helené Fogde Hejda on 2023-02-01.
//

import Foundation
import Combine
import UIKit

class QuoteViewModel {
    // Capture input from viewcontroller, than make the API Call
    enum Input {
        case refreshButtonDidTap
        case favouriteButtonDidTap
    }
    
    enum Output {
        case fetchQuoteDidFail(error: Error)
        case fetchQuoteDidSucceed(quote: Quote)
        case toggleRefreshButton(isEnabled: Bool, color: UIColor)
        case toggleFavouriteButton(isEnabled: Bool, color: UIColor)
        case saveFavouriteQuote(quote: String)
    }
    
    private let quoteServiceType: QuoteServiceType
    @Published var saveQuote : String = "Save Your First Favourite Quote!"
    var quoteString : Quote?
    // Lightswitch, doesnt take an init value
    private let output: PassthroughSubject<Output, Never> = .init()
    private var cancellable = Set<AnyCancellable>()
    
    init(quoteServiceType: QuoteServiceType = QuoteService()) {
        self.quoteServiceType = quoteServiceType
    }
    
    // Transform input into an output
    func transform(input: AnyPublisher<Input, Never>) -> AnyPublisher<Output, Never>{
        // Here we find out what the input is
        input.sink { [weak self]event in
            switch event {
         
            case .refreshButtonDidTap:
                self?.handleGetRandomQuote()
        
            case .favouriteButtonDidTap:
                self?.handleFavouriteQuote()
            }
        }.store(in: &cancellable)
        return output.eraseToAnyPublisher()
    }
    
    
    private func handleGetRandomQuote(){
        output.send(.toggleFavouriteButton(isEnabled: true, color: .systemBlue))
        output.send(.toggleRefreshButton(isEnabled: false, color: .lightGray))
      
        quoteServiceType.getRandomQuote().sink { [weak self] completion in
            self?.output.send(.toggleRefreshButton(isEnabled: true, color: .systemBlue))
            
            if case .failure(let error) = completion {
                self?.output.send(.fetchQuoteDidFail(error: error))
            }
            
        } receiveValue: { [weak self] quote in
            self?.output.send(.fetchQuoteDidSucceed(quote: quote))
            print(" ReceviedValue in Q.VM ---> \(quote.content)")
            self?.quoteString = quote
        }.store(in: &cancellable)
    }
    
    private func handleFavouriteQuote(){
        saveQuote = quoteString!.content
        output.send(.toggleFavouriteButton(isEnabled: false, color: .lightGray))
        output.send(.saveFavouriteQuote(quote: saveQuote))
    }
}
