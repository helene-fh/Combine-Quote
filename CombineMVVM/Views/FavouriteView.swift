//
//  FavouriteView.swift
//  CombineMVVM
//
//  Created by Helené Fogde Hejda on 2023-02-01.
//

import Foundation
import UIKit

class FavouriteView: UIView {
    
    var quoteLabel : UILabel = {
        var label = UILabel()
        label.textAlignment = .center
        label.tintColor = .black
        label.font = label.font.withSize(20)
        label.text = "Save Your First Favourite Quote!"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpConstraints(){
        addSubview(quoteLabel)
        
        NSLayoutConstraint.activate([
            
            quoteLabel.topAnchor.constraint(equalTo: topAnchor, constant: 200),
            quoteLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            quoteLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            quoteLabel.heightAnchor.constraint(equalToConstant: 150),
        ])
    }
}
