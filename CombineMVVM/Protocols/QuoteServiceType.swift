//
//  QuoteServiceType.swift
//  CombineMVVM
//
//  Created by Helené Fogde Hejda on 2023-02-01.
//

import Foundation
import Combine

protocol QuoteServiceType {
    func getRandomQuote() -> AnyPublisher<Quote, Error>
}
