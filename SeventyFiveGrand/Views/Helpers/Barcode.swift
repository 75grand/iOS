//
//  Barcode.swift
//  SeventyFiveGrand
//
//  Created by Jerome Paulos on 12/15/22.
//

import SwiftUI

struct Barcode: View {
    @State var value: String;
    
    func generateBarcode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)

        if let filter = CIFilter(name: "CICode128BarcodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)

            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }

        return nil
    }

    var body: some View {
        Group {
            if let barcode = generateBarcode(from: value) {
                Image(uiImage: barcode)
            } else {
                Text("Error rendering barcode")
            }
        }
    }
}

struct Barcode_Previews: PreviewProvider {
    static var previews: some View {
        Barcode(value: "Barcode Value")
    }
}
