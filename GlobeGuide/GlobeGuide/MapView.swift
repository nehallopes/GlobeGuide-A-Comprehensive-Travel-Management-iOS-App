//
//  MapView.swift
//  GlobeGuide
//
//  Created by CDMStudent on 6/8/24.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    @Binding var region: MKCoordinateRegion
    @Binding var places: [MKMapItem]
    @Binding var selectedPlace: MKMapItem?
    @Binding var route: MKRoute?
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView
        
        init(parent: MapView) {
            self.parent = parent
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            let identifier = "Placemark"
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            
            if annotationView == nil {
                annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView?.canShowCallout = true
                annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            } else {
                annotationView?.annotation = annotation
            }
            
            return annotationView
        }
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            if let routePolyline = overlay as? MKPolyline {
                let renderer = MKPolylineRenderer(polyline: routePolyline)
                renderer.strokeColor = .blue
                renderer.lineWidth = 5
                return renderer
            }
            return MKOverlayRenderer()
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        if !uiView.region.center.latitude.isEqual(to: region.center.latitude) && !uiView.region.center.longitude.isEqual(to: region.center.longitude) {
            uiView.setRegion(region, animated: true)
        }
        
        uiView.removeAnnotations(uiView.annotations)
        for place in places {
            let annotation = MKPointAnnotation()
            annotation.coordinate = place.placemark.coordinate
            annotation.title = place.name
            uiView.addAnnotation(annotation)
        }
        
        if let route = route {
            uiView.removeOverlays(uiView.overlays)
            uiView.addOverlay(route.polyline)
        } else {
            uiView.removeOverlays(uiView.overlays)
        }
    }
}
