//
//  CustomTableViewCell.swift
//  ImageSearch
//
//  Created by Михаил Фокин on 25.08.2021.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
	
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
	}
}
