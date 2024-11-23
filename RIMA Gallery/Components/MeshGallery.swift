//
//  MeshGallery.swift
//  RIMA Gallery
//
//  Created by Rafael Magana  on 20/11/24.
//

import SwiftUI

struct MeshGallery: View {
    let items = Array(1...53).map { "Image\($0)" }
    @Binding var columns: Int
    @Binding var areFilled: Bool
    @Binding var imageSelected: String?
    var namespace: Namespace.ID // Espacio de nombres para animación

    var body: some View {
        let gridItems = Array(repeating: GridItem(.flexible(), spacing: 2), count: columns)
        LazyVGrid(columns: gridItems, spacing: 2) {
            ForEach(items, id: \.self) { item in
                ImagePreview(image: item, filled: $areFilled, imageSelected: $imageSelected, namespace: namespace)
            }
        }
    }
}

#Preview {
    @Previewable @State var columns: Int = 3
    @Previewable @State var areFilled: Bool = true
    @Previewable @State var imageSelected: String? = nil
    @Previewable @Namespace var namespace
    MeshGallery(columns: $columns, areFilled: $areFilled, imageSelected: $imageSelected, namespace: namespace)
}
