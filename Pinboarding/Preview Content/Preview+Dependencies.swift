import SwiftUI

extension View {

    func withPreviewDependencies() -> some View {
        self
            .environmentObject(previewAppEnvironment.viewModelFactory)
            .environmentObject(previewAppEnvironment.searchStore)
            .environment(
                \.managedObjectContext,
                 previewAppEnvironment.persistenceService.container.viewContext
            )
    }
}
