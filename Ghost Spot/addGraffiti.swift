import SwiftUI
import CoreLocation

struct AddGraffiti: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss

    @StateObject private var locationManager = LocationManager()  // Using StateObject for location manager

    @State private var name = ""
    @State private var description = ""  // Changed variable name from `descript` to `description`
    @State private var image: UIImage?
    @State private var showingCamera = true  // To automatically show the camera

    var body: some View {
        NavigationView {
            Form {
                Section {
                    if let image = image {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                    }
                }
                
                Section {
                    TextField("Name of location", text: $name)
                }
                
                Section(header: Text("Describe what you see")) {
                    TextEditor(text: $description)
                }
                
                Section {
                    Button("Save") {
                        addItem()
                        dismiss()  // Dismiss the view after saving
                    }
                }
            }
            .navigationTitle("Add Graffiti")
            .sheet(isPresented: $showingCamera) {
                ImagePicker(image: $image)
            }
        }
        .onAppear {
            locationManager.checkIfLocationServicesIsEnabled()
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(context: moc)  // Create a new Item object
            
            newItem.id = UUID()
            newItem.name = name  // Set the name to the entered name
            newItem.descript = description  // Set the description to the entered text
            newItem.timestamp = Date()
            if let location = locationManager.lastKnownLocation {
                newItem.latitude = location.coordinate.latitude
                newItem.longitude = location.coordinate.longitude
            }

            // Convert UIImage to Data and store it
            if let imageData = image?.jpegData(compressionQuality: 1.0) {  // Adjust compression quality as needed
                newItem.imageData = imageData
            }
            
            do {
                try moc.save()  // Save the context
            } catch {
                // Handle the error appropriately in a production application
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct AddGraffiti_Previews: PreviewProvider {
    static var previews: some View {
        AddGraffiti()
    }
}
