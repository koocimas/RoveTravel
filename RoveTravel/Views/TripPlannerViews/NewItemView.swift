//
//  NewItemView.swift
//  Rove
//

import SwiftUI
import PhotosUI

struct NewItemView: View {
  @Environment(\.presentationMode) var presentationMode
  @ObservedObject var tripPlannerManager: TripPlannerManager
  @State private var name = ""
  @State private var notes = ""
  @State private var selectedPhotos: [PhotosPickerItem] = []
  @State private var userPhotos: [UIImage] = []
  var destination: Destination
  var body: some View {
    NavigationStack {
      Form {
        Section(header: Text("Item Name")) {
          TextField("Item Name", text: $name)
            .fontWeight(.light)
            .listRowBackground(Color.light)
        }
        Section(header: Text("Item Notes")) {
          TextField("Item Notes", text: $notes, axis: .vertical)
            .lineLimit(Constants.General.notesLineLimit...)
            .fontWeight(.light)
            .listRowBackground(Color.light)
        }
        ForEach(userPhotos, id: \.cgImage) { image in
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: .infinity, height: .infinity)
                        .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
        }
        .listRowSeparator(.hidden)
        .listRowBackground(Color.light)
        PhotosPicker(selection: $selectedPhotos,
                     matching: .images) {
          Text("Select Photos \(Image(systemName: "photo.on.rectangle"))")
            .fontWeight(.light)
            .foregroundStyle(.accent)
            .opacity(0.8)
        }
                     .listRowSeparator(.hidden)
                     .listRowBackground(Color.light)
                             .onChange(of: selectedPhotos) { selectedPhotos in
                                 userPhotos = []
                                 for item in selectedPhotos {
                                     item.loadTransferable(type: Data.self) { result in
                                         switch result {
                                         case .success(let imageData):
                                             if let imageData {
                                                 self.userPhotos.append(UIImage(data: imageData)!)
                                             } else {
                                                 print("No supported content type found.")
                                             }
                                         case .failure(let error):
                                             print(error)
                                         }
                                     }
                                 }
                             }
      }
      .toolbar {
        ToolbarItem(placement: .navigationBarLeading) {
          Button(action: {
            Task {
              tripPlannerManager.addingItem = false
              self.presentationMode.wrappedValue.dismiss()
            }
          }, label: {
            Text("Cancel")
              .foregroundStyle(.accent)
              .fontWeight(.light)
          })
        }
        ToolbarItem(placement: .principal) {
          Text("Add New Item")
            .font(.title3)
            .fontWeight(.light)
            .foregroundStyle(.accent)
        }
        ToolbarItem(placement: .navigationBarTrailing) {
          Button(action: {
            tripPlannerManager.addNewItem(name: name, notes: notes, destinationID: destination.city)
            tripPlannerManager.addingItem = false
            self.presentationMode.wrappedValue.dismiss()
          }, label: {
            Text("Add")
              .fontWeight(.light)
          })
          .disabled(name.isEmpty)
        }
      }
      .navigationBarTitleDisplayMode(.inline)
      .scrollContentBackground(.hidden)
      .background(.dark)
    }
  }
}

struct NewItemView_Previews: PreviewProvider {
  static var previews: some View {
    NewItemView(tripPlannerManager: TripPlannerManager(), destination: Destination.previewDestination[0])
  }
}
