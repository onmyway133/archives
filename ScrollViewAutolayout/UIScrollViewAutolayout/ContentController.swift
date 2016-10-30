import UIKit

class ContentController: UIViewController {
  
  var image: UIImage!
  let imageView = UIImageView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    imageView.contentMode = .scaleAspectFit
    view.addSubview(imageView)
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    imageView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    imageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    
    imageView.image = image
  }
}
