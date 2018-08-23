//
//  SettingsSoundIOSaveUseCase.swift
//  Telephone
//
//  Copyright © 2008-2016 Alexey Kuznetsov
//  Copyright © 2016-2018 64 Characters
//
//  Telephone is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  Telephone is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//

import Domain

public final class SettingsSoundIOSaveUseCase {
    private let soundIO: SystemDefaultingSoundIO
    private let settings: KeyValueSettings

    public init(soundIO: SystemDefaultingSoundIO, settings: KeyValueSettings) {
        self.soundIO = soundIO
        self.settings = settings
    }
}

extension SettingsSoundIOSaveUseCase: UseCase {
    public func execute() {
        settings[SettingsKeys.soundInput] = soundIO.input.name
        settings[SettingsKeys.soundOutput] = soundIO.output.name
        settings[SettingsKeys.ringtoneOutput] = soundIO.ringtoneOutput.name
    }
}

private extension SystemDefaultingSoundIO.Item {
    var name: String? {
        switch self {
        case .systemDefault:
            return nil
        case .device(name: let name):
            return name
        }
    }
}
