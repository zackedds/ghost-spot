import SwiftUI
import MapKit

struct MapView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        entity: Item.entity(),
        sortDescriptors: []
    ) var items: FetchedResults<Item>

    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 40.10753805474947, longitude: -88.2272294236202),
        span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
    )

    var body: some View {
        Map(coordinateRegion: $region, annotationItems: items) { item in
            MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: item.latitude, longitude: item.longitude)) {
                NavigationLink(destination: GraffitiDetailView(item: item)) {
                    Image(systemName: "mappin.circle.fill")
                        .font(.title)
                        .foregroundColor(.red)
                }
            }
        }
        .ignoresSafeArea(edges: .top)
        .navigationTitle("Graffiti Map")
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
