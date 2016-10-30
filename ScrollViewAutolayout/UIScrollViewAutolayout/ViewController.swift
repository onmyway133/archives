import UIKit

class ViewController: UIViewController {

  let scrollView = UIScrollView()
  let contentView = UIView()
  let pageControl = UIPageControl()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = UIColor(red: 31/255, green: 41/255, blue: 59/255, alpha: 1)
    setup()
  }
  
  func setup() {
    
    // ScrollView
    scrollView.isPagingEnabled = true
    scrollView.delegate = self
    
    view.addSubview(scrollView)
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    
    scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true

    // ContentView
    scrollView.addSubview(contentView)
    contentView.translatesAutoresizingMaskIntoConstraints = false
    contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
    contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    contentView.leftAnchor.constraint(equalTo: scrollView.leftAnchor).isActive = true
    contentView.rightAnchor.constraint(equalTo: scrollView.rightAnchor).isActive = true
    
    // Child controllers
    let controllers: [UIViewController] = Array(0..<4).map {
      let controller = ContentController()
      controller.image = UIImage(named: "image\($0 + 1)")
      
      return controller
    }
    
    controllers.enumerated().forEach { index, controller in
      addChildViewController(controller)
      contentView.addSubview(controller.view)
      controller.view.translatesAutoresizingMaskIntoConstraints = false
      controller.didMove(toParentViewController: self)
      
      controller.view.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
      controller.view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
      controller.view.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
      controller.view.heightAnchor.constraint(equalTo: scrollView.heightAnchor).isActive = true
      
      if index == 0 {
        controller.view.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
      } else {
        controller.view.leftAnchor.constraint(equalTo: controllers[index-1].view.rightAnchor).isActive = true
      }
      
      if index == controllers.count - 1 {
        controller.view.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
      }
    }
    
    // PageControl
    view.addSubview(pageControl)
    pageControl.translatesAutoresizingMaskIntoConstraints = false
    pageControl.numberOfPages = controllers.count
    pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
  }
}

extension ViewController: UIScrollViewDelegate {
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let index = Int(round(scrollView.contentOffset.x / scrollView.frame.size.width))
    pageControl.currentPage = index
  }
}

