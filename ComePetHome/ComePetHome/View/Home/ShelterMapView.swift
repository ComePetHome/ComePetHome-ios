import SwiftUI
import MapKit
import CoreLocation

struct Place : Identifiable {
    var id: UUID = UUID()
    var name: String
    var location: CLLocationCoordinate2D
}

struct ShelterMapView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.88371, longitude: 127.73947),
        span: MKCoordinateSpan(latitudeDelta: 0.002, longitudeDelta: 0.002)
    )
    @State private var places = [
        Place(
            name: "장소 1",
            location: CLLocationCoordinate2D(latitude: 37.88371, longitude: 127.73947)
        )
    ]
    
    var body: some View {
        Map(coordinateRegion: $region, annotationItems: places) { item in
            MapAnnotation(coordinate: item.location, anchorPoint: CGPoint(x: 0.5, y: 1)) {
                VStack {
                    Text(item.name)
                        .padding([.leading,.trailing], 7)
                        .padding([.top, .bottom], 8)
                        .background(Color("MainColor"))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    Image("MapMaker")
                }
            }
        }.onAppear{
            places.removeAll()
            convertAddressToCoordinates(address: "서울 노원구 수락산로 258") { coordinate in
                if let coordinate = coordinate {
                    region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude), span: MKCoordinateSpan(latitudeDelta: 0.002, longitudeDelta: 0.002))
                                        
                    places.append(Place(name: "노원 댕댕 하우스", location: CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)))
                } else {
                    print("좌표를 찾을 수 없습니다.")
                }
            }
        }
    }
    func convertAddressToCoordinates(address: String, completion: @escaping (CLLocationCoordinate2D?) -> Void) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { placemarks, error in
            if let error = error {
                print("Geocoding error: \(error.localizedDescription)")
                completion(nil)
            }
            
            if let placemark = placemarks?.first {
                completion(placemark.location?.coordinate)
            }
        }
    }
}

#Preview {
    ShelterMapView()
}
