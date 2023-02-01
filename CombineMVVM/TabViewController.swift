//
//  TabViewController.swift
//  CombineMVVM
//
//  Created by Helené Fogde Hejda on 2023-02-01.
//

import UIKit

class TabViewController: UIViewController {
    
    let quoteViewModel = QuoteViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func createQuoteController() -> UINavigationController {
        let quote = QuoteViewController(viewModel: quoteViewModel)
        quote.title = title
        quote.tabBarItem = UITabBarItem(title: title, image: UIImage(systemName: "quote.bubble"), tag: 0)
        return UINavigationController(rootViewController: quote)
    }
    
    func createFavouritesController() -> UINavigationController {
        let favourites = FavouritesViewController(viewModel: quoteViewModel)
        favourites.title = title
        favourites.tabBarItem = UITabBarItem(title: title, image: UIImage(systemName: "heart"), tag: 0)
        return UINavigationController(rootViewController: favourites)
    }
    
    func createTabBar() -> UITabBarController {
        
        let tabBar = UITabBarController()
        
        UITabBar.appearance().tintColor = .black
        UITabBar.appearance().unselectedItemTintColor = .gray
        UITabBar.appearance().isTranslucent = true
        UITabBar.appearance().backgroundColor = .white
        
        tabBar.viewControllers = [createQuoteController(), createFavouritesController()]
        
        return tabBar
        
    }

}
