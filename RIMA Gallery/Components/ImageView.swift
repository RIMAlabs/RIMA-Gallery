//
//  ImageView.swift
//  RIMA Gallery
//
//  Created by Rafael Magana  on 20/11/24.
//

import SwiftUI

struct ImageView: View {
    @Binding var image: String?

    var body: some View {
        VStack {
            if let image {
                Image(image)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
        .onTapGesture {
            image = nil
        }
    }
}


#Preview {
    @Previewable @State var image: String? = "Image1"
    ImageView(image: $image)
}
