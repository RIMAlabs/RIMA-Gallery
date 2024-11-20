//
//  ContentView.swift
//  RIMA Gallery
//
//  Created by Rafael Magana  on 19/11/24.
//

import SwiftUI

struct ContentView: View {
    let items = Array(1...53).map { "\($0)" }
    
    // Estado para rastrear el número de columnas
    @State private var numberOfColumns: Int = 4
    @GestureState private var pinchScale: CGFloat = 1.0
    @State private var baseColumns: Int = 4 // Para recordar las columnas antes del gesto
    
    var body: some View {
        // Configuración de columnas según el número dinámico
        let columns = Array(repeating: GridItem(.flexible(), spacing: 1), count: numberOfColumns)
        
        ScrollView {
            LazyVGrid(columns: columns, spacing: 1) {
                ForEach(items, id: \.self) { item in
                    ZStack {
                        Image("Image\(item)")
                            .resizable()
                            .aspectRatio(1, contentMode: .fill)
//                        Text("Item \(item)")
//                            .frame(minWidth: 0, maxWidth: .infinity)
//                            .font(.headline)
//                            .foregroundColor(.white)
//                            .background(Color.black.opacity(0.5))
                    }
                }
            }
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
    }
}


#Preview {
    ContentView()
}
