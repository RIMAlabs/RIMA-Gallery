//
//  GalleryViewModel.swift
//  RIMA Gallery
//
//  Created by Rafael Magana  on 23/11/24.
//

import SwiftUI

class GalleryViewModel: ObservableObject {
    @Published var items: [GalleryItem] = (1...53).map { GalleryItem(imageName: "Image\($0)") }
    @Published var numberOfColumns: Int = 3
    @Published var isFilled: Bool = true
    @Published var selectedImage: String? = nil

    func toggleGridMode() {
        isFilled.toggle()
    }

    func updateColumns(scale: CGFloat, baseColumns: Int) {
        let newColumns = Int((CGFloat(baseColumns) / scale).rounded())
        numberOfColumns = min(max(newColumns, 1), 10)
    }
}
