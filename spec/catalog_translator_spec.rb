# frozen_string_literal: true

require 'rails_helper'
require './lib/catalog_translator'

RSpec.describe CatalogTranslator do # rubocop:todo Metrics/BlockLength
  # rubocop:todo Metrics/BlockLength
  it 'is able to translate raw loader hash inputs into data ready for DB import', pending: true do
    translator = CatalogTranslator.new

    input_pilot_1 = { 'name' => 'Gozanti-class Cruiser', # rubocop:todo Naming/VariableNumber
                      'xws' => 'gozanticlasscruiser',
                      'ffg' => 81,
                      'faction' => 'First Order',
                      'icon' =>
                        'https://squadbuilder.fantasyflightgames.com/ship_types/I_Gozanti.png',
                      'size' => 'Huge',
                      'dial' =>
                        %w[0BR 0OR 0NR 1BW 1NW 1FB 2BR 2NR 2FB 3FB 4FR],
                      'dialCodes' => ['GOZ-FO'],
                      'stats' =>
                        [{ 'arc' => 'Front Arc', 'type' => 'attack', 'value' => 3 },
                         # rubocop:todo Layout/LineLength
                         { 'type' => 'agility', 'value' => 0 }, { 'type' => 'hull', 'value' => 11 }, { 'type' => 'shields', 'value' => 5, 'recovers' => 1 }, { 'type' => 'energy', 'value' => 3, 'recovers' => 1 }],
                      # rubocop:enable Layout/LineLength
                      'actions' =>
                        [{ 'difficulty' => 'White', 'type' => 'Focus' }, { 'difficulty' => 'White', 'type' => 'Lock' },
                         # rubocop:todo Layout/LineLength
                         { 'difficulty' => 'White', 'type' => 'Coordinate' }, { 'difficulty' => 'White', 'type' => 'Reinforce' }, { 'difficulty' => 'White', 'type' => 'Jam' }],
                      # rubocop:enable Layout/LineLength
                      'pilots' =>
                        [{ 'ffg' => 712, 'name' => 'First Order Sympathizers', 'initiative' => 7, 'cost' => 67,
                           # rubocop:todo Layout/LineLength
                           'limited' => 0, 'artwork' => 'https://squadbuilder.fantasyflightgames.com/card_art/99965cf5c4a2611773c6e7f4ecb6608f.jpg', 'shipAbility' => { 'name' => 'Docking Clamps', 'text' => 'You can dock up to 4 small ships.' }, 'text' => "The First Order's swift rise to power rests upon ruthless innovation. However, sympathizers often repurpose Imperial designs, like the venerable Gozanti-class cruiser, in surveillance and patrol operations.", 'hyperspace' => false, 'engagement' => 1, 'xws' => 'firstordersympathizers', 'slots' => %w[Command Hardpoint Crew Crew Gunner Team Cargo Cargo] }] }
    # rubocop:enable Layout/LineLength

    input_pilot_2 = { 'name' => 'TIE/ba Interceptor', # rubocop:todo Naming/VariableNumber
                      'xws' => 'tiebainterceptor',
                      'ffg' => 70,
                      'size' => 'Small',
                      'dial' =>
                        %w[1TB 1BB 1NB 1YB 2LR 2TW 2BB 2FB 2NB 2YW 2PR 3TW 3BW
                           3FB 3NW 3YW 4FB 5FW 5KR],
                      'dialCodes' => ['VT'],
                      'faction' => 'First Order',
                      'stats' =>
                        [{ 'arc' => 'Front Arc', 'type' => 'attack', 'value' => 3 },
                         # rubocop:todo Layout/LineLength
                         { 'type' => 'agility', 'value' => 3 }, { 'type' => 'hull', 'value' => 2 }, { 'type' => 'shields', 'value' => 2 }],
                      # rubocop:enable Layout/LineLength
                      'actions' =>
                        [{ 'difficulty' => 'White', 'type' => 'Focus' },
                         # rubocop:todo Layout/LineLength
                         { 'difficulty' => 'White', 'type' => 'Evade' }, { 'difficulty' => 'White', 'type' => 'Lock' }, { 'difficulty' => 'White', 'type' => 'Barrel Roll' }, { 'difficulty' => 'White', 'type' => 'Boost' }],
                      # rubocop:enable Layout/LineLength
                      'icon' =>
                        'https://squadbuilder.fantasyflightgames.com/ship_types/I_Vonregs-First-Order-TIE-Interceptor.png',
                      'pilots' =>
                        [
                          { 'name' => 'Major Vonreg', 'caption' => 'Red Baron', 'initiative' => 6, 'limited' => 1,
                            # rubocop:todo Layout/LineLength
                            'cost' => 54, 'xws' => 'majorvonreg', 'ability' => 'During the System Phase, you may choose 1 enemy ship in your [Bullseye Arc]. That ship gains 1 deplete or strain token of your choice.', 'shipAbility' => { 'name' => 'Fine-Tuned Thrusters', 'text' => 'After you fully execute a maneuver, if you are not depleted or strained, you may gain 1 deplete or strain token to perform a [Lock] or [Barrel Roll] action.' }, 'slots' => %w[Talent Tech Missile Modification], 'hyperspace' => true, 'ffg' => 624, 'artwork' => 'https://squadbuilder.fantasyflightgames.com/card_art/4d8fdab1a5317159fcd56f722b6d73e5.jpg', 'image' => 'https://sb-cdn.fantasyflightgames.com/card_images/en/e95d46ad3a22ad0790cfd18a7e10cf81.png', 'keywords' => ['TIE'] },
                          # rubocop:enable Layout/LineLength
                          { 'name' => '"Holo"', 'caption' => 'Trick of the Light', 'initiative' => 5, 'limited' => 1,
                            # rubocop:todo Layout/LineLength
                            'cost' => 53, 'xws' => 'holo', 'ability' => 'At the start of the Engagement Phase, you must transfer 1 of your tokens to another friendly ship at range 0-2.', 'shipAbility' => { 'name' => 'Fine-Tuned Thrusters', 'text' => 'After you fully execute a maneuver, if you are not depleted or strained, you may gain 1 deplete or strain token to perform a [Lock] or [Barrel Roll] action.' }, 'slots' => %w[Talent Tech Missile Modification], 'hyperspace' => true, 'ffg' => 625, 'artwork' => 'https://squadbuilder.fantasyflightgames.com/card_art/61d81abede1ce312b0de7d16623c2e60.jpg', 'image' => 'https://sb-cdn.fantasyflightgames.com/card_images/en/ee53482be8e59ff44f272e76c4e8123d.png', 'keywords' => ['TIE'] },
                          # rubocop:enable Layout/LineLength
                          { 'name' => '"Ember"', 'caption' => 'Dying Flame', 'initiative' => 4, 'limited' => 1,
                            # rubocop:todo Layout/LineLength
                            'cost' => 45, 'xws' => 'ember', 'ability' => 'While you perform an attack, if there is a damaged ship friendly to the defender at range 0-1 of the defender, the defender cannot spend focus or calculate tokens.', 'shipAbility' => { 'name' => 'Fine-Tuned Thrusters', 'text' => 'After you fully execute a maneuver, if you are not depleted or strained, you may gain 1 deplete or strain token to perform a [Lock] or [Barrel Roll] action.' }, 'slots' => %w[Talent Tech Missile Modification], 'hyperspace' => true, 'ffg' => 626, 'artwork' => 'https://squadbuilder.fantasyflightgames.com/card_art/47fd0abc0fa4cea1508a800e75d18ebe.jpg', 'image' => 'https://sb-cdn.fantasyflightgames.com/card_images/en/4de956edddeacb92ef3e4f94e0a63db3.png', 'keywords' => ['TIE'] },
                          # rubocop:enable Layout/LineLength
                          { 'name' => 'First Order Provocateur', 'initiative' => 3, 'limited' => 0, 'cost' => 41,
                            # rubocop:todo Layout/LineLength
                            'xws' => 'firstorderprovocateur', 'text' => "Major Vonreg's vision guided the enhancement of proven designs while engineering this one-of-a-kind precise and lethal craft from Sienar-Jaemus Fleet Systems.", 'shipAbility' => { 'name' => 'Fine-Tuned Thrusters', 'text' => 'After you fully execute a maneuver, if you are not depleted or strained, you may gain 1 deplete or strain token to perform a [Lock] or [Barrel Roll] action.' }, 'slots' => %w[Talent Tech Missile Modification], 'hyperspace' => false, 'ffg' => 627, 'artwork' => 'https://squadbuilder.fantasyflightgames.com/card_art/947aa948233f6a5fe5833dcf45cf8f01.jpg', 'image' => 'https://sb-cdn.fantasyflightgames.com/card_images/en/c834c2c4722b60e67292130d40c7ec19.png', 'keywords' => ['TIE'] }
                          # rubocop:enable Layout/LineLength
                        ] }

    translator.input_pilots = [input_pilot_1, input_pilot_2]

    translator.translate_pilots

    expect(translator.ships.length).to be 2
    expect(translator.pilots.length).to be 5
  end
  # rubocop:enable Metrics/BlockLength
end