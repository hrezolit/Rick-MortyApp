//
//  RMSettingsView.swift
//  Rick&MortyApp
//
//  Created by Nikita on 5/2/23.
//

import SwiftUI

struct RMSettingsView: View {
    
    let viewModel: RMSettingsViewViewModel
    
    init(viewModel: RMSettingsViewViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
            List(viewModel.cellViewModels) { viewModel in
                Text(viewModel.title)
        }
    }
}

struct RMSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        RMSettingsView(
            viewModel: .init(
                cellViewModels: RMSettingsOption.allCases.compactMap({
                    RMSettingsCellViewModel(type: $0)
                })))
    }
}
