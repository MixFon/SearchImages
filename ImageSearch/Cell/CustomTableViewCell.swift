//
//  CustomTableViewCell.swift
//  ImageSearch
//
//  Created by Михаил Фокин on 25.08.2021.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
	
	@IBOutlet weak var indicator: UIActivityIndicatorView!
	@IBOutlet weak var photographer: UILabel!
	@IBOutlet weak var width: UILabel!
	@IBOutlet weak var height: UILabel!
	@IBOutlet weak var idPhoto: UILabel!
	@IBOutlet weak var imagePhoto: UIImageView!
	
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
	
	/// Заполнение ячейки.
	func setDataPhoto(photo: Photo) {
		self.photographer.text = photo.photographer
		self.width.text = "Widht \(photo.width)"
		self.height.text = "Height \(photo.height)"
		self.idPhoto.text = "ID photo \(photo.id)"
		self.loadPhoto(url: photo.src.small)
	}
	
	/// Загрузка фото в фоновом режиме.
	private func loadPhoto(url: String) {
		self.indicator.isHidden = false
		self.indicator.startAnimating()
		guard let url = URL(string: url) else { return }
		self.imagePhoto.image = nil
		let queue = DispatchQueue.global(qos: .utility)
		queue.async {
			if let data = try? Data(contentsOf: url) {
				DispatchQueue.main.async {
					self.indicator.stopAnimating()
					self.indicator.isHidden = true
					self.imagePhoto.image = UIImage(data: data)
				}
			}
			
		}
	}
    
}
