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
    var body: some View {
        // Configuración de columnas según el número dinámico
        let columns = Array(repeating: GridItem(.flexible(), spacing: 2), count: columns)
        LazyVGrid(columns: columns, spacing: 2) {
            ForEach(items, id: \.self) { item in
                ZStack {
                    ImagePreview(image: item, filled: $areFilled, imageSelected: $imageSelected)
                }
            }
        }
    }
}

#Preview {
    @Previewable @State var columns: Int = 3
    @Previewable @State var areFilled: Bool = true
    @Previewable @State var imageSelected: String? = nil
    MeshGallery(columns: $columns, areFilled: $areFilled, imageSelected: $imageSelected)
}
