//
//  ShowImageVC.swift
//  ImageSearch
//
//  Created by Михаил Фокин on 25.08.2021.
//

import UIKit

class ShowImageVC: UIViewController {
	
	@IBOutlet weak var indicator: UIActivityIndicatorView!
	var photo: Photo?
	@IBOutlet weak var imageViewTargetingConstraint: NSLayoutConstraint!
	
	@IBOutlet weak var scrollView: UIScrollView!
	@IBOutlet weak var image: UIImageView!
	
	@IBOutlet weak var lable: UILabel!
	
	override func viewDidLoad() {
        super.viewDidLoad()
		guard let photo = self.photo else { return }
		loadPhoto(url: photo.src.large)
		//self.lable.text = String(photo.id)
        // Do any additional setup after loading the view.
    }
	
	func updateMinZoomScaleForSize(_ size: CGSize) {
	  let widthScale = size.width / image.bounds.width
	  let heightScale = size.height / image.bounds.height
	  let minScale = min(widthScale, heightScale)
		
	  scrollView.minimumZoomScale = minScale
	  scrollView.zoomScale = minScale
	}
    
	/// Загрузка фото в фоновом режиме.
	private func loadPhoto(url: String) {
		self.indicator.isHidden = false
		self.indicator.startAnimating()
		guard let url = URL(string: url) else { return }
		let queue = DispatchQueue.global(qos: .utility)
		queue.async {
			if let data = try? Data(contentsOf: url) {
				DispatchQueue.main.async {
					self.indicator.stopAnimating()
					self.indicator.isHidden = true
					self.image.image = UIImage(data: data)
					let dataFormatter = DateFormatter()
					dataFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
					self.title = dataFormatter.string(from: Date())
				}
			}
		}
	}
}

extension ShowImageVC: UIScrollViewDelegate {
	
	func viewForZooming(in scrollView: UIScrollView) -> UIView? {
		return self.image
	}
	
	override func viewWillLayoutSubviews() {
		super.viewWillLayoutSubviews()
		updateMinZoomScaleForSize(view.bounds.size)
	}
	
}
