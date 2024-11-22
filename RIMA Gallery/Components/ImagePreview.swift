//
//  ImagePreview.swift
//  RIMA Gallery
//
//  Created by Rafael Magana  on 20/11/24.
//

import SwiftUI

struct ImagePreview: View {
    @State var image: String?
    @State var isSelected: Bool = false
    @Binding var filled: Bool
    @Binding var imageSelected: String?
    

    var body: some View {
        if let image = image {
            ZStack {
                GeometryReader { geometry in
                    Image(image)
                        .resizable()
                        .aspectRatio(contentMode: filled ? .fill : .fit)
                        .frame(width: geometry.size.width, height: geometry.size.width)
                        .clipped()
                        .animation(.easeInOut(duration: 0.2), value: filled) // Animación suave
                        .onTapGesture {
                            imageSelected = image
                        }
                }
                .aspectRatio(1, contentMode: .fit)
            }
        }
    }
}

#Preview {
    @Previewable @State var fit: Bool = true
    @Previewable @State var imageSelected: String? = nil
    VStack {
        ImagePreview(image: "Image1", filled: $fit, imageSelected: $imageSelected)
        Button("Toggle") {
            fit.toggle()
        }
        .padding()
    }
}
