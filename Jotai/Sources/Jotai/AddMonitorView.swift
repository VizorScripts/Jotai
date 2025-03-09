// Views/AddMonitorView.swift
import SwiftUI

struct AddMonitorView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: MonitorViewModel
    
    @State private var name: String = ""
    @State private var urlString: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Monitor Details")) {
                    TextField("Name", text: $name)
                    TextField("URL", text: $urlString)
                        .keyboardType(.URL)
                        .autocapitalization(.none)
                }
            }
            .navigationTitle("Add Monitor")
            .navigationBarItems(leading: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            }, trailing: Button("Save") {
                viewModel.addMonitor(name: name, urlString: urlString)
                presentationMode.wrappedValue.dismiss()
            }
            .disabled(name.isEmpty || urlString.isEmpty))
        }
    }
}
