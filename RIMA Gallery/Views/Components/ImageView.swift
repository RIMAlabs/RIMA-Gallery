//
//  ImageView.swift
//  RIMA Gallery
//
//  Created by Rafael Magana  on 20/11/24.
//

import SwiftUI

struct ImageView: View {
    @Binding var image: String?
    var namespace: Namespace.ID

    @State private var scale: CGFloat = 1.0
    @State private var lastScale: CGFloat = 1.0
    @State private var offset: CGSize = .zero
    @State private var lastOffset: CGSize = .zero

    var body: some View {
        if let image = image {
            ZStack {
                Color(.black).ignoresSafeArea()
                Image(image)
                    .resizable()
                    .aspectRatio(contentMode: .fit) // Modificación aquí
                    .matchedGeometryEffect(id: image, in: namespace)
                    .scaleEffect(scale)
                    .offset(offset)
                    .gesture(
                        SimultaneousGesture(
                            // Gesto de arrastre para mover la imagen
                            DragGesture()
                                .onChanged { value in
                                    let translation = value.translation
                                    var newOffset = CGSize(
                                        width: lastOffset.width + translation.width,
                                        height: lastOffset.height + translation.height
                                    )

                                    // Limitar el desplazamiento cuando se hace zoom
                                    if scale > 1.0 {
                                        let screenSize = UIScreen.main.bounds.size
                                        let maxOffsetX = (screenSize.width * (scale - 1)) / 2
                                        let maxOffsetY = (screenSize.height * (scale - 1)) / 2

                                        newOffset.width = min(max(newOffset.width, -maxOffsetX), maxOffsetX)
                                        newOffset.height = min(max(newOffset.height, -maxOffsetY), maxOffsetY)
                                    } else {
                                        // Si el zoom es 1.0, permitir arrastre vertical para cerrar
                                        newOffset.width = 0
                                        if translation.height > 100 {
                                            withAnimation(.easeInOut) {
                                                self.image = nil
                                            }
                                        }
                                    }

                                    offset = newOffset
                                }
                                .onEnded { _ in
                                    lastOffset = offset
                                },

                            // Gesto de zoom
                            MagnificationGesture()
                                .onChanged { value in
                                    scale = lastScale * value
                                }
                                .onEnded { _ in
                                    withAnimation {
                                        // Limita la escala entre 1.0 y 5.0
                                        scale = max(1.0, min(scale, 5.0))
                                    }
                                    lastScale = scale
                                }
                        )
                    )
                    .onTapGesture(count: 2) {
                        withAnimation {
                            if scale > 1.0 {
                                // Restablecer zoom y desplazamiento
                                scale = 1.0
                                lastScale = 1.0
                                offset = .zero
                                lastOffset = .zero
                            } else {
                                // Hacer zoom al doble
                                scale = 2.0
                                lastScale = 2.0
                            }
                        }
                    }
            }
            .transition(.opacity)
        }
    }
}

#Preview {
    @Previewable @State var image: String? = "Image1"
    @Previewable @Namespace var namespace
    ImageView(image: $image, namespace: namespace)
}
