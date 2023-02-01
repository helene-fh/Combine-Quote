//
//  QuoteView.swift
//  CombineMVVM
//
//  Created by Helené Fogde Hejda on 2023-02-01.
//

import UIKit

class QuoteView: UIView {

    var quoteLabel : UILabel = {
       var label = UILabel()
        label.textAlignment = .center
        label.tintColor = .black
        label.font = label.font.withSize(20)
        label.text = "Get A Quote!"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var refreshButton : UIButton = {
        var button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitle("Refresh", for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var favouriteButton : UIButton = {
        var button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitle("Save As Favourite", for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
        addSubview(refreshButton)
        addSubview(favouriteButton)
        
        NSLayoutConstraint.activate([
        
            quoteLabel.topAnchor.constraint(equalTo: topAnchor, constant: 200),
            quoteLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            quoteLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            quoteLabel.heightAnchor.constraint(equalToConstant: 150),
            quoteLabel.bottomAnchor.constraint(equalTo: refreshButton.topAnchor, constant: -20),
            
            refreshButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            refreshButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            refreshButton.heightAnchor.constraint(equalToConstant: 50),
            refreshButton.bottomAnchor.constraint(equalTo: favouriteButton.topAnchor, constant: -20),
            
            favouriteButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            favouriteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            favouriteButton.heightAnchor.constraint(equalToConstant: 50)
            
        ])
    }
}
