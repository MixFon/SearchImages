//
//  Image.swift
//  ImageSearch
//
//  Created by Михаил Фокин on 25.08.2021.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct Welcome: Decodable {
	let page: Int
	let perPage: Int?
	var photos: [Photo]
	let totalResults: Int?
	let nextPage: String?

	enum CodingKeys: String, CodingKey {
		case page
		case perPage = "per_page"
		case photos
		case totalResults = "total_results"
		case nextPage = "next_page"
	}
}

// MARK: - Photo
struct Photo: Decodable {
	let id, width, height: Int
	let url: String
	let photographer: String
	let photographerURL: String?
	let photographerID: Int?
	let avgColor: String?
	let src: Src
	let liked: Bool

	enum CodingKeys: String, CodingKey {
		case id, width, height, url, photographer
		case photographerURL = "photographer_url"
		case photographerID = "photographer_id"
		case avgColor = "avg_color"
		case src, liked
	}
}

// MARK: - Src
struct Src: Decodable {
	let original, large2X, large, medium: String
	let small, portrait, landscape, tiny: String

	enum CodingKeys: String, CodingKey {
		case original
		case large2X = "large2x"
		case large, medium, small, portrait, landscape, tiny
	}
}
