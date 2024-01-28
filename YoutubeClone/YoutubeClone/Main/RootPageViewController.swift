//
//  RootPageViewController.swift
//  YoutubeClone
//
//  Created by Germain Seijas on 28/01/24.
//

import UIKit
protocol RootPageProtocol:AnyObject {
    func currentPage(_ index: Int)
}

class RootPageViewController: UIPageViewController {

    var subViewController = [UIViewController]()
    var currentIndex : Int = 0
    weak var delegateRoot: RootPageProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        dataSource = self
        setupViewController()
    }
    private func setupViewController() {
        subViewController = [
            HomeViewController(),
            VideosViewController(),
            PlaylistViewController(),
            ChannelsViewController(),
            AboutViewController()
        ]
        _ = subViewController.enumerated().map({$0.element.view.tag = $0.offset})
        setViewControllerFromIndex(index: 0, direction: .forward)
    }
    func setViewControllerFromIndex(index:Int, direction: NavigationDirection, animated: Bool = true){
        setViewControllers([subViewController[index]], direction: direction, animated: animated)
    }
}

extension RootPageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let index: Int = subViewController.firstIndex(of: viewController) ?? 0
        if index <= 0 {
            return nil
        }
        return subViewController[index-1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let index: Int = subViewController.firstIndex(of: viewController) ?? 0
        if index >= subViewController.count - 1 {
            return nil
        }
        return subViewController[index+1]
    }
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return subViewController.count
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        print("finish ", finished)
        if let index = pageViewController.viewControllers?.first?.view.tag {
            currentIndex = index
            delegateRoot?.currentPage(index)
        }
    }
}
