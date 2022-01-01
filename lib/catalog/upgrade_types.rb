# frozen_string_literal: true

module Catalog
  class UpgradeTypes
    # rubocop:disable Metrics/MethodLength:
    def self.all_upgrade_types
      [
        { name: 'Astromech' },
        { name: 'Cannon' },
        { name: 'Cargo' },
        { name: 'Command' },
        { name: 'Configuration' },
        { name: 'Crew' },
        { name: 'Force' },
        { name: 'Gunner' },
        { name: 'Hardpoint' },
        { name: 'Illicit' },
        { name: 'Missile' },
        { name: 'Payload' },
        { name: 'Modification' },
        { name: 'Turret' },
        { name: 'Sensor' },
        { name: 'Tactical Relay' },
        { name: 'Talent' },
        { name: 'Turret' },
        { name: 'Team' },
        { name: 'Tech' },
        { name: 'Title' },
        { name: 'Torpedo' },
        { name: 'Turret' }
      ]
    end
    # rubocop:enable Metrics/MethodLength:
  end
end
