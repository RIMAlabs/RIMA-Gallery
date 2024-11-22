//
//  ContentView.swift
//  RIMA Gallery
//
//  Created by Rafael Magana  on 19/11/24.
//

import SwiftUI

struct ContentView: View {
    // Estado para rastrear el número de columnas
    @State private var numberOfColumns: Int = 3
    @GestureState private var pinchScale: CGFloat = 1.0
    @State private var baseColumns: Int = 4 // Para recordar las columnas antes del gesto
    @State private var isPressed: Bool = true
    @State var imageSelected: String? = nil
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            ScrollView {
                MeshGallery(columns: $numberOfColumns, areFilled: $isPressed, imageSelected: $imageSelected)
                // Aplicar el gesto de pellizco
                .gesture(
                    MagnificationGesture()
                        .updating($pinchScale) { currentState, pinchScale, _ in
                            pinchScale = currentState
                        }
                        .onChanged { value in
                            // Calcular las columnas dinámicamente durante el gesto
                            let newColumns = Int((CGFloat(baseColumns) / value).rounded())
                            numberOfColumns = min(max(newColumns, 1), 10) // Asegurar límites
                        }
                        .onEnded { _ in
                            // Guardar el estado actual como base para el siguiente gesto
                            baseColumns = numberOfColumns
                        }
                )
                .animation(.easeInOut, value: numberOfColumns) // Aplicar animación al número de columnas
            }
            // Botón en la esquina superior izquierda
            Button(action: { isPressed.toggle() }) {
                Image(systemName: isPressed ? "arrow.up.right.and.arrow.down.left" : "arrow.down.left.and.arrow.up.right")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.accentColor)
            }
            .frame(width: 60, height: 60) // Tamaño del botón
            .background(Color.secondary)
            .clipShape(Circle()) // Forma circular
            .shadow(radius: 4) // Sombra para darle un efecto
            .padding() // Espaciado desde los bordes // Llenar toda la pantalla
            
            if imageSelected != nil {
                ImageView(image: $imageSelected)
            }
        }
    }
}


#Preview {
    ContentView()
}
