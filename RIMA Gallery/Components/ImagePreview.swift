//
//  ImagePreview.swift
//  RIMA Gallery
//
//  Created by Rafael Magana  on 20/11/24.
//

import SwiftUI

struct ImagePreview: View {
    let image: String
    @Binding var filled: Bool
    @Binding var imageSelected: String?
    var namespace: Namespace.ID // Espacio de nombres para la animación

    var body: some View {
        ZStack {
            GeometryReader { geometry in
                Image(image)
                    .resizable()
                    .aspectRatio(contentMode: filled ? .fill : .fit)
                    .frame(width: geometry.size.width, height: geometry.size.width)
                    .clipped()
                    .animation(.easeInOut(duration: 0.2), value: filled) // Animación suave
                    .matchedGeometryEffect(id: image, in: namespace) // Vincula la geometría
                    .onTapGesture {
                        imageSelected = image
                    }
            }
            .aspectRatio(1, contentMode: .fit)
        }
    }
}

#Preview {
    @Previewable @State var fit: Bool = true
    @Previewable @State var imageSelected: String? = nil
    @Previewable @Namespace var namespace
    VStack {
        ImagePreview(image: "Image1", filled: $fit, imageSelected: $imageSelected, namespace: namespace)
        Button("Toggle") {
            fit.toggle()
        }
        .padding()
    }
}
