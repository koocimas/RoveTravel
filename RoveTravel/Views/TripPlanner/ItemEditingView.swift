//
//  ItemEditingView.swift
//  Rove
//

import SwiftUI
import PhotosUI

struct ItemEditingView: View {
  @Environment(\.presentationMode) var presentationMode
  var tripPlannerManager: TripPlannerManager
  @State private var selectedPhotos: [PhotosPickerItem] = []
  @State var userPhotos: [UIImage] = []
  @Binding var item: Item
  var body: some View {
    NavigationStack {
      Form {
        Section(header: Text("Item Name")) {
          TextField("Item Name", text: $item.name)
            .foregroundStyle(.accent)
            .fontWeight(.light)
            .listRowBackground(Color.light)
        }
        Section(header: Text("Item Notes")) {
          TextField("Item Notes", text: $item.notes, axis: .vertical)
            .lineLimit(Constants.General.notesLineLimit...)
            .foregroundStyle(.accent)
            .fontWeight(.light)
            .listRowBackground(Color.light)
        }
        ForEach(item.photos.compactMap { $0 }, id: \.self) { photoData in
          Image(uiImage: UIImage(data: photoData)!)
            .resizable()
            .scaledToFit()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
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
                             .onChange(of: selectedPhotos) { _, selectedPhotos in
                               item.photos = []
                                 for item in selectedPhotos {
                                     item.loadTransferable(type: Data.self) { result in
                                         switch result {
                                         case .success(let imageData):
                                             if let imageData {
                                               self.item.photos.append(imageData)
                                             } else {
                                                 print("No supported content type found.")
                                             }
                                         case .failure(let error):
                                             print(error)
                                         }
                                     }
                                 }
      }
        Section {
          Toggle("Completed", isOn: $item.completed)
            .foregroundStyle(.accent)
            .fontWeight(.light)
            .listRowBackground(Color.light)
        }
      }
      .toolbar {
        ToolbarItem(placement: .navigationBarLeading) {
          Button(action: {
            tripPlannerManager.removeItem(item: item)
            self.presentationMode.wrappedValue.dismiss()

          }, label: {
            Text("Delete")
              .fontWeight(.light)
              .foregroundStyle(.accent)
          })
        }
        ToolbarItem(placement: .principal) {
          Text("Edit Item")
            .font(.title3)
            .fontWeight(.light)
            .foregroundStyle(.accent)
        }
        ToolbarItem(placement: .navigationBarTrailing) {
          Button(action: {
            self.presentationMode.wrappedValue.dismiss()
          }, label: {
            Text("Done")
              .fontWeight(.light)
              .foregroundStyle(.accent)
          })
        }
      }
      .navigationBarTitleDisplayMode(.inline)
      .scrollContentBackground(.hidden)
      .background(.dark)
    }
  }
}

struct ItemEditingView_Previews: PreviewProvider {
  static var previews: some View {
    @State var item = Item.example()
    ItemEditingView(tripPlannerManager: TripPlannerManager(), item: $item)
  }
}
