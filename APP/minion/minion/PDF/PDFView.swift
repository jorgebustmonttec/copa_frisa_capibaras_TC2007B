//
//  PDFView.swift
//  minion
//
//  Created by Jorge Bustamante on 14/06/24.
//

import SwiftUI
import PDFKit

struct PDFView: View {
    var body: some View {
        PDFKitView(url: Bundle.main.url(forResource: "Reglamento", withExtension: "pdf")!)
            .navigationTitle("PDF Document")
            .navigationBarTitleDisplayMode(.inline)
    }
}

struct PDFKitView: UIViewRepresentable {
    let url: URL
    
    func makeUIView(context: Context) -> PDFKit.PDFView {
        let pdfView = PDFKit.PDFView()
        pdfView.document = PDFDocument(url: url)
        pdfView.autoScales = true
        return pdfView
    }
    
    func updateUIView(_ uiView: PDFKit.PDFView, context: Context) {
        // Update the view if needed
    }
}

struct PDFView_Previews: PreviewProvider {
    static var previews: some View {
        PDFView()
    }
}
