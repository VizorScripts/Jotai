// Views/MonitorDetailView.swift
import SwiftUI

struct MonitorDetailView: View {
    let monitor: Monitor
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(monitor.name)
                .font(.largeTitle)
                .bold()
            Text("URL: \(monitor.url.absoluteString)")
                .font(.body)
            HStack {
                Text("Status: ")
                    .font(.headline)
                StatusIndicator(status: monitor.status, responseTime: monitor.responseTime)
            }
            if let responseTime = monitor.responseTime, monitor.status == .online {
                Text("Response Time: \(Int(responseTime)) ms")
                    .font(.body)
            }
            Spacer()
        }
        .padding()
        .navigationTitle("Monitor Details")
    }
}
