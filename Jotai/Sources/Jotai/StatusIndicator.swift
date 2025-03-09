// Views/Components/StatusIndicator.swift
import SwiftUI

struct StatusIndicator: View {
    let status: MonitorStatus
    let responseTime: Double?
    
    var body: some View {
        Group {
            switch status {
            case .online:
                if let responseTime = responseTime {
                    Text("\(Int(responseTime)) ms")
                        .foregroundColor(.green)
                } else {
                    Text("Online")
                        .foregroundColor(.green)
                }
            case .offline:
                Text("Offline")
                    .foregroundColor(.red)
            case .unknown:
                Text("Unknown")
                    .foregroundColor(.gray)
            }
        }
        .font(.subheadline)
    }
}
