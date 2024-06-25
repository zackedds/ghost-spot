import SwiftUI

struct GraffitiDetailView: View {
    @ObservedObject var item: Item

    var body: some View {
        Form {
            Section(header: Text("Details")) {
                Text("Name: \(item.name ?? "Unknown")")
                Text("Description: \(item.descript ?? "No Description Available")")
                
                // Display the image if it exists
                if let imageData = item.imageData, let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                        .frame(maxHeight: 300) // You can adjust the frame as needed
                } else {
                    Text("No image available")
                }

                // Display the timestamp
                if let timestamp = item.timestamp {
                    Text("Timestamp: \(timestamp, formatter: itemFormatter)")
                }
            }
        }
        .navigationTitle("Graffiti Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .long
    formatter.timeStyle = .medium
    return formatter
}()
