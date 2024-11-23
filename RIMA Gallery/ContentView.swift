//
//  ContentView.swift
//  RIMA Gallery
//
//  Created by Rafael Magana  on 19/11/24.
//

import SwiftUI

struct ContentView: View {
    @State private var numberOfColumns: Int = 3
    @GestureState private var pinchScale: CGFloat = 1.0
    @State private var baseColumns: Int = 4
    @State private var isPressed: Bool = true
    @State var imageSelected: String? = nil

    // Espacio de nombres para `MatchedGeometryEffect`
    @Namespace private var namespace

    var body: some View {
        ZStack(alignment: .topLeading) {
            // Fondo para mantener el espacio de coordenadas
            Color.clear.edgesIgnoringSafeArea(.all)

            // Colocamos el ScrollView dentro del ZStack para compartir espacio de coordenadas
            ScrollView {
                MeshGallery(columns: $numberOfColumns, areFilled: $isPressed, imageSelected: $imageSelected, namespace: namespace)
                    .gesture(
                        MagnificationGesture()
                            .updating($pinchScale) { currentState, pinchScale, _ in
                                pinchScale = currentState
                            }
                            .onChanged { value in
                                let newColumns = Int((CGFloat(baseColumns) / value).rounded())
                                numberOfColumns = min(max(newColumns, 1), 10)
                            }
                            .onEnded { _ in
                                baseColumns = numberOfColumns
                            }
                    )
                    .animation(.easeInOut, value: numberOfColumns)
            }

            // Botón de cambio de modo
            Button(action: { isPressed.toggle() }) {
                Image(systemName: isPressed ? "arrow.up.right.and.arrow.down.left" : "arrow.down.left.and.arrow.up.right")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.accentColor)
            }
            .frame(width: 60, height: 60)
            .background(Color.secondary)
            .clipShape(Circle())
            .shadow(radius: 4)
            .padding()

            // ImageView encima de la cuadrícula
            if let imageSelected = imageSelected {
                ImageView(image: $imageSelected, namespace: namespace)
                    .zIndex(1) // Asegura que esté encima
                    .animation(.easeInOut, value: imageSelected)
            }
        }
    }
}

#Preview {
    ContentView()
}
