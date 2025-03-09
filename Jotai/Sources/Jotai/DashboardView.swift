// Views/DashboardView.swift
import SwiftUI

struct DashboardView: View {
    @ObservedObject var viewModel = MonitorViewModel()
    @State private var showingAddMonitor = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.monitors) { monitor in
                    NavigationLink(destination: MonitorDetailView(monitor: monitor)) {
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(monitor.name)
                                    .font(.headline)
                                Text(monitor.url.absoluteString)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                            StatusIndicator(status: monitor.status, responseTime: monitor.responseTime)
                        }
                        .padding(.vertical, 8)
                    }
                }
            }
            .navigationTitle("Jotai Dashboard")
            .navigationBarItems(trailing:
                Button(action: {
                    showingAddMonitor.toggle()
                }) {
                    Image(systemName: "plus")
                }
            )
            .sheet(isPresented: $showingAddMonitor) {
                AddMonitorView(viewModel: viewModel)
            }
        }
    }
}
