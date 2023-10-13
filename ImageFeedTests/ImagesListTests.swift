//
//  ImagesListTests.swift
//  ImageFeedTests
//
//  Created by Тимур Мурадов on 25.09.2023.
//

@testable import ImageFeed
import XCTest

final class ImagesListTests: XCTestCase {
    
    func testViewControllerCallsViewDidLoad() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ImagesListViewController") as! ImagesListViewController
        let presenter = ImagesListPresenterSpy()
        viewController.presenter = presenter
        presenter.view = viewController
        
        _ = viewController.view
        
        XCTAssertTrue(presenter.viewDidLoadCalled)
        
    }
    
    func testPresent(_ alert: UIAlertController) {
        let presenter = ImagesListPresenterSpy()
        XCTAssertTrue(presenter.presentCalled)
    }
    
}

final class ImagesListPresenterSpy: ImagesListPresenterProtocol {
    var presentCalled: Bool = false
    var viewDidLoadCalled: Bool = false
    var view: ImageFeed.ImagesListViewControllerProtocol?
    
    func viewDidLoad() {
        viewDidLoadCalled = true
        presentCalled = true
    }
    
}
