//
//  ViewController.swift
//  ImageSearch
//
//  Created by Михаил Фокин on 25.08.2021.
// 563492ad6f91700001000001b6b9ccd7fc82477eb0ab76bdf93aeeab

import UIKit

class ViewController: UIViewController {
	
	@IBOutlet weak var tabelView: UITableView!
	@IBOutlet weak var searchTextField: UITextField!
	
	private var key: String = "563492ad6f91700001000001b6b9ccd7fc82477eb0ab76bdf93aeeab"
	private var baseURL: String = "https://api.pexels.com/v1"
	private var welcom: Welcome?
	private var identifierCell = "my_cell"
	
	override func viewDidLoad() {
		super.viewDidLoad()
		let nib = UINib(nibName: "CustomTableViewCell", bundle: nil)
		self.tabelView.register(nib, forCellReuseIdentifier: self.identifierCell)
	}
	
	@IBAction func searchButton(_ sender: UIButton) {
		guard let text = self.searchTextField.text else { return }
		if text.isEmpty { return }
		self.welcom = nil
		getDataImages(url: "\(self.baseURL)/search?query=\(text)")
	}
	
	private func getDataImages(url: String) {
		guard let url = URL(string: url) else { return }
		var request = URLRequest(url: url)
		request.httpMethod = "GET"
		request.setValue(self.key, forHTTPHeaderField: "Authorization")
		let session = URLSession.shared
		session.dataTask(with: request) { (data, response, error) in
			guard let response = response as? HTTPURLResponse else { return }
			if response.statusCode != 200 {
				DispatchQueue.main.async {
					self.showAlert(title: "Error", message: "status code: \(response.statusCode)")
				}
				return
			}
			guard let data = data else { return }
			let decoder = JSONDecoder()
			do {
				var welcom = try decoder.decode(Welcome.self, from: data)
				if self.welcom == nil {
					self.welcom = welcom
				} else {
					welcom.photos = self.welcom!.photos + welcom.photos
					self.welcom = welcom
				}
				DispatchQueue.main.async {
					self.tabelView.reloadData()
				}
			} catch {
				print("\(error)")
			}
		}.resume()
	}
	
	/// Вызов сообщения об ошибке.
	private func showAlert(title: String, message: String) {
		let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
		self.present(alert,animated: true,completion: nil)
	}

}

// MARK: Delegate

extension ViewController: UITableViewDataSource, UITableViewDelegate {
	
	// Возвращет количество строк Rows секции.
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		guard let photos = welcom?.photos else { return 0 }
		return photos.count
	}
	
	// Создаем ячейку и заполняем ее.
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let photo = self.welcom?.photos[indexPath.row] else { return UITableViewCell() }
		guard let cell = self.tabelView.dequeueReusableCell(withIdentifier: self.identifierCell, for: indexPath) as? CustomTableViewCell else { return UITableViewCell() }
		cell.setDataPhoto(photo: photo)
		return cell
	}
	
	// При нажатии на ячейку переходим на новое окно.
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		guard let welcom = self.welcom else { return }
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		guard let showImageVC = storyboard.instantiateViewController(withIdentifier: "ShowImageID") as? ShowImageVC  else { return }
		showImageVC.photo = welcom.photos[indexPath.row]
		show(showImageVC, sender: nil)
	}
	
	func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		guard let welcom = self.welcom else { return }
		if indexPath.row == welcom.photos.count - 1 {
			//print(indexPath.row, welcom.photos.count - 1)
			guard let nextPage = welcom.nextPage else { return }
			getDataImages(url: nextPage)
		}
	}
}
