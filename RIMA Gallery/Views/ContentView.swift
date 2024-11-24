//
//  ContentView.swift
//  RIMA Gallery
//
//  Created by Rafael Magana  on 19/11/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = GalleryViewModel()
    @GestureState private var pinchScale: CGFloat = 1.0
    @Namespace private var namespace

    var body: some View {
        ZStack(alignment: .topLeading) {
            Color.clear.edgesIgnoringSafeArea(.all)

            ScrollView {
                MeshGallery(
                    columns: $viewModel.numberOfColumns,
                    areFilled: $viewModel.isFilled,
                    imageSelected: $viewModel.selectedImage,
                    namespace: namespace
                )
                .gesture(
                    MagnificationGesture()
                        .updating($pinchScale) { currentState, pinchScale, _ in
                            pinchScale = currentState
                        }
                        .onChanged { value in
                            viewModel.updateColumns(scale: value, baseColumns: viewModel.numberOfColumns)
                        }
                )
            }

            Button(action: { viewModel.toggleGridMode() }) {
                Image(systemName: viewModel.isFilled ? "arrow.up.right.and.arrow.down.left" : "arrow.down.left.and.arrow.up.right")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
            }
            .frame(width: 60, height: 60)
            .background(Color.secondary)
            .clipShape(Circle())
            .padding()

            if viewModel.selectedImage != nil {
                ImageView(image: $viewModel.selectedImage, namespace: namespace)
                    .zIndex(1)
            }
        }
    }
}

#Preview {
    ContentView()
}
