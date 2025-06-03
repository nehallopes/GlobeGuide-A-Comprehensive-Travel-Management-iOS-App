//
//  DirectionsView.swift
//  GlobeGuide
//
//  Created by CDMStudent on 6/8/24.
//

import SwiftUI
import MapKit

struct DirectionsView: View {
    let route: MKRoute

    var body: some View {
        VStack {
            Text("Directions to \(route.name)")
                .font(.headline)
                .padding()

            Divider()

            List(route.steps, id: \.self) { step in
                VStack(alignment: .leading) {
                    Text(step.instructions)
                    if step.distance > 0 {
                        Text(String(format: "%.2f meters", step.distance))
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
            }

            Spacer()

            Button(action: {
                UIApplication.shared.windows.first?.rootViewController?.presentedViewController?.dismiss(animated: true, completion: nil)
            }) {
                Text("Close")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding()
        }
        .padding()
    }
}
