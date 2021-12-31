# frozen_string_literal: true

require 'rails_helper'
require './lib/catalog/translator'

RSpec.describe Catalog::Translator do
  let(:input_pilot1) do
    { 'name' => 'Gozanti-class Cruiser',
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
  end

  let(:input_pilot2) do
    { 'name' => 'BTL-A4 Y-wing',
      'xws' => 'btla4ywing',
      'ffg' => 12,
      'size' => 'Small',
      'dial' =>
        %w[1BB 1FB 1NB 2TW 2BW 2FB 2NW 2YW 3TR 3BW 3FW 3NW 3YR 4FR 4KR],
      'dialCodes' => ['YW'],
      'faction' => 'Rebel Alliance',
      'stats' =>
        [{ 'arc' => 'Front Arc', 'type' => 'attack', 'value' => 2 }, { 'type' => 'agility', 'value' => 1 },
         { 'type' => 'hull', 'value' => 6 }, { 'type' => 'shields', 'value' => 2 }],
      'actions' =>
        [{ 'difficulty' => 'White', 'type' => 'Focus' }, { 'difficulty' => 'White', 'type' => 'Lock' },
         { 'difficulty' => 'Red', 'type' => 'Barrel Roll' }, { 'difficulty' => 'Red', 'type' => 'Reload' }],
      'icon' => 'https://squadbuilder.fantasyflightgames.com/ship_types/I_Y-wing.png',
      'pilots' =>
        [
          { 'name' => '"Dutch" Vander', 'caption' => 'Gold Leader', 'initiative' => 4, 'limited' => 1, 'cost' => 40,
            'xws' => 'dutchvander', 'ability' => 'After you perform the [Lock] action, you may choose 1 friendly ship at range 1-3. That ship may acquire a lock on the object you locked, ignoring range restrictions.', 'image' => 'https://sb-cdn.fantasyflightgames.com/card_images/Card_Pilot_14.png', 'slots' => %w[Talent Turret Torpedo Astromech Device Modification Missile], 'artwork' => 'https://squadbuilder.fantasyflightgames.com/card_art/Card_art_XW_P_14.jpg', 'ffg' => 14, 'hyperspace' => true, 'keywords' => ['Y-wing'] }, { 'name' => 'Evaan Verlaine', 'caption' => 'Gold Three', 'initiative' => 3, 'limited' => 1, 'cost' => 34, 'xws' => 'evaanverlaine', 'ability' => 'At the start of the Engagement Phase, you may spend 1 focus token to choose a friendly ship at range 0-1. If you do, that ship rolls 1 additional defense die while defending until the end of the round.', 'image' => 'https://sb-cdn.fantasyflightgames.com/card_images/Card_Pilot_16.png', 'slots' => %w[Talent Turret Torpedo Astromech Device Modification Missile], 'artwork' => 'https://squadbuilder.fantasyflightgames.com/card_art/Card_art_XW_P_16.jpg', 'ffg' => 16, 'hyperspace' => true, 'keywords' => ['Y-wing'] }, { 'name' => 'Gold Squadron Veteran', 'initiative' => 3, 'limited' => 0, 'cost' => 31, 'xws' => 'goldsquadronveteran', 'text' => 'Commanded by Jon "Dutch" Vander, Gold Squadron played an instrumental role in the Battles of Scarif and Yavin.', 'image' => 'https://sb-cdn.fantasyflightgames.com/card_images/Card_Pilot_17.png', 'slots' => %w[Talent Turret Torpedo Astromech Device Modification Missile], 'alt' => [{ 'image' => 'https://images-cdn.fantasyflightgames.com/filer_public/6e/42/6e42ac70-c222-4ca5-ad3a-dc9350988933/op086-gold-squadron-veteran.png', 'source' => 'Gen Con Indy 2018' }], 'artwork' => 'https://squadbuilder.fantasyflightgames.com/card_art/Card_art_XW_P_17.jpg', 'ffg' => 17, 'hyperspace' => true, 'keywords' => ['Y-wing'] }, { 'name' => 'Gray Squadron Bomber', 'initiative' => 2, 'limited' => 0, 'cost' => 29, 'xws' => 'graysquadronbomber', 'text' => 'Long after the Y-wing was phased out by the Galactic Empire, its durability, dependability, and heavy armament help it remain a staple in the Rebel fleet.', 'image' => 'https://sb-cdn.fantasyflightgames.com/card_images/Card_Pilot_18.png', 'slots' => %w[Turret Torpedo Astromech Device Modification Missile], 'artwork' => 'https://squadbuilder.fantasyflightgames.com/card_art/Card_art_XW_P_18.jpg', 'ffg' => 18, 'hyperspace' => true, 'keywords' => ['Y-wing'] }, { 'name' => 'Horton Salm', 'caption' => 'Gray Leader', 'initiative' => 4, 'limited' => 1, 'cost' => 36, 'xws' => 'hortonsalm', 'ability' => 'While you perform an attack, you may reroll 1 attack die for each other friendly ship at range 0-1 of the defender.', 'image' => 'https://sb-cdn.fantasyflightgames.com/card_images/Card_Pilot_15.png', 'slots' => %w[Talent Turret Torpedo Astromech Device Modification Missile], 'artwork' => 'https://squadbuilder.fantasyflightgames.com/card_art/Card_art_XW_P_15.jpg', 'ffg' => 15, 'hyperspace' => true, 'keywords' => ['Y-wing'] }, { 'name' => 'Norra Wexley', 'caption' => 'Gold Nine', 'initiative' => 5, 'limited' => 1, 'cost' => 40, 'xws' => 'norrawexley-btla4ywing', 'ability' => 'While you defend, if there is an enemy ship at range 0-1, add 1 [Evade] result to your dice results.', 'image' => 'https://sb-cdn.fantasyflightgames.com/card_images/Card_Pilot_13.png', 'slots' => %w[Talent Turret Torpedo Astromech Device Modification Missile], 'artwork' => 'https://squadbuilder.fantasyflightgames.com/card_art/Card_art_XW_P_13.jpg', 'ffg' => 13, 'hyperspace' => true, 'keywords' => ['Y-wing'] }
        ] }
  end

  let(:input_pilot3) do
    { 'name' => 'BTL-A4 Y-wing',
      'xws' => 'btla4ywing',
      'ffg' => 12,
      'size' => 'Small',
      'dial' =>
        %w[1BB 1FB 1NB 2TW 2BW 2FB 2NW 2YW 3TR 3BW 3FW 3NW 3YR 4FR 4KR],
      'dialCodes' => ['YW'],
      'faction' => 'Scum and Villainy',
      'stats' =>
        [{ 'arc' => 'Front Arc', 'type' => 'attack', 'value' => 2 }, { 'type' => 'agility', 'value' => 1 },
         { 'type' => 'hull', 'value' => 6 }, { 'type' => 'shields', 'value' => 2 }],
      'actions' =>
        [{ 'difficulty' => 'White', 'type' => 'Focus' }, { 'difficulty' => 'White', 'type' => 'Lock' },
         { 'difficulty' => 'Red', 'type' => 'Barrel Roll' }, { 'difficulty' => 'Red', 'type' => 'Reload' }],
      'icon' => 'https://squadbuilder.fantasyflightgames.com/ship_types/I_Y-wing.png',
      'pilots' =>
        [
          { 'name' => 'Crymorah Goon', 'initiative' => 1, 'limited' => 0, 'cost' => 29, 'xws' => 'crymorahgoon',
            'text' => "Though far from nimble, the Y-wing's heavy hull, substantial shielding, and turret-mounted cannons make it an excellent patrol craft.", 'image' => 'https://sb-cdn.fantasyflightgames.com/card_images/Card_Pilot_168.png', 'slots' => %w[Turret Torpedo Astromech Device Illicit Modification Missile], 'artwork' => 'https://squadbuilder.fantasyflightgames.com/card_art/Card_art_XW_P_168.jpg', 'ffg' => 168, 'hyperspace' => false, 'keywords' => ['Y-wing'] }, { 'name' => 'Drea Renthal', 'caption' => 'Pirate Lord', 'initiative' => 4, 'limited' => 1, 'cost' => 46, 'xws' => 'drearenthal', 'ability' => 'While a friendly non-limited ship performs an attack, if the defender is in your firing arc, the attacker may reroll 1 attack die.', 'slots' => %w[Talent Turret Torpedo Astromech Device Illicit Modification Missile], 'image' => 'https://sb-cdn.fantasyflightgames.com/card_images/Card_Pilot_166.png', 'artwork' => 'https://squadbuilder.fantasyflightgames.com/card_art/Card_art_XW_P_166.jpg', 'ffg' => 166, 'hyperspace' => false, 'keywords' => ['Y-wing'] }, { 'name' => 'Hired Gun', 'initiative' => 2, 'limited' => 0, 'cost' => 31, 'xws' => 'hiredgun', 'text' => 'Just the mention of Imperial credits can bring a host of less-than-trustworthy individuals to your side.', 'image' => 'https://sb-cdn.fantasyflightgames.com/card_images/Card_Pilot_167.png', 'slots' => %w[Talent Turret Torpedo Astromech Device Illicit Modification Missile], 'artwork' => 'https://squadbuilder.fantasyflightgames.com/card_art/Card_art_XW_P_167.jpg', 'ffg' => 167, 'hyperspace' => false, 'keywords' => ['Y-wing'] }, { 'name' => 'Kavil', 'caption' => 'Callous Corsair', 'initiative' => 5, 'limited' => 1, 'cost' => 41, 'xws' => 'kavil', 'ability' => 'While you perform a non-[Front Arc] attack, roll 1 additional attack die.', 'image' => 'https://sb-cdn.fantasyflightgames.com/card_images/Card_Pilot_165.png', 'slots' => %w[Talent Turret Torpedo Astromech Device Illicit Modification Missile], 'artwork' => 'https://squadbuilder.fantasyflightgames.com/card_art/Card_art_XW_P_165.jpg', 'ffg' => 165, 'hyperspace' => false, 'keywords' => ['Y-wing'] }, { 'name' => 'Leema Kai', 'xws' => 'leemakai', 'initiative' => 5, 'limited' => 1, 'hyperspace' => false, 'keywords' => ['Y-wing'], 'cost' => 39, 'slots' => %w[Talent Tech Turret Torpedo Missile Astromech Device], 'ability' => "Before you engage, if you are not in any enemy ship's [Front Arc], you may acquire a lock on an enemy ship in your full front arc.", 'caption' => 'Opportunity Knocks', 'ffg' => 898, 'artwork' => 'https://squadbuilder.fantasyflightgames.com/card_art/4e6423bdaa2b09478f46f795c5328c17.jpg' }, { 'name' => 'Arliz Hadrassian', 'xws' => 'arlizhadrassian', 'initiative' => 4, 'limited' => 1, 'hyperspace' => false, 'keywords' => ['Y-wing'], 'cost' => 38, 'slots' => %w[Talent Tech Turret Torpedo Missile Astromech Device], 'ability' => 'While you perform a [Front Arc] attack, if you are damaged, you may change 1 of your [Focus] results to a [Critical Hit] result. While you defend, if you are damaged, before the Modify Defense Dice step, you must change 1 of your [Focus] results to a blank result.', 'caption' => 'Crimson Blade', 'ffg' => 899, 'artwork' => 'https://squadbuilder.fantasyflightgames.com/card_art/f00b0ed67b0de579c3bc4fdaceb3f3ab.jpg' }, { 'name' => 'Amaxine Warrior', 'xws' => 'amaxinewarrior', 'initiative' => 3, 'limited' => 0, 'text' => 'Decades after the Battle of Endor, former Imperials remain active in the New Republic. Many have joined paramilitary organizations, such as the Amaxine Warriors, that appropriate martial traditions and cultures to spread the hateful ideology of the First Order amongst those most vulnerable to it.', 'hyperspace' => true, 'cost' => 33, 'slots' => %w[Talent Tech Turret Torpedo Missile Astromech Device], 'keywords' => ['Y-wing'], 'ffg' => 901, 'artwork' => 'https://squadbuilder.fantasyflightgames.com/card_art/1a6296a88e63a0896952e7dd4178105b.jpg' }, { 'name' => 'Padric', 'xws' => 'padric', 'initiative' => 3, 'limited' => 1, 'caption' => 'Napkin Bomber', 'hyperspace' => false, 'cost' => 36, 'slots' => %w[Talent Tech Turret Torpedo Missile Astromech Device], 'ability' => 'After a friendly device that you have locked detonates, each enemy ship at range 0-1 of that device gains 1 strain token.', 'keywords' => ['Y-wing'], 'ffg' => 900, 'artwork' => 'https://squadbuilder.fantasyflightgames.com/card_art/7d5a18e41b8e3caf1d623cdf06acafc8.jpg' }, { 'name' => 'Jinata Security Officer', 'xws' => 'jinatasecurityofficer', 'initiative' => 2, 'limited' => 0, 'text' => "Headquartered on the former Imperial stronghold of Vardos, Jinata Security continues its reconstruction efforts on the devastated planet, even while collaborating with the First Order's rearmament program.", 'hyperspace' => true, 'cost' => 30, 'slots' => %w[Tech Turret Torpedo Missile Astromech Device], 'keywords' => ['Y-wing'], 'ffg' => 902, 'artwork' => 'https://squadbuilder.fantasyflightgames.com/card_art/d1b998eff3b93d5ed05870096aa27817.jpg' }
        ] }
  end

  # rubocop:enable Layout/LineLength

  let(:input_action1) do
    { 'name' => 'Boost', 'xws' => 'boost', 'ffg' => 1 }
  end
  let(:input_action2) do
    { 'name' => 'Focus', 'xws' => 'focus', 'ffg' => 2 }
  end
  let(:input_faction1) do
    { 'name' => 'Rebel Alliance',
      'xws' => 'rebelalliance',
      'ffg' => 1,
      'icon' => 'https://sb-cdn.fantasyflightgames.com/factions/Rebel.png' }
  end
  let(:input_faction2) do
    { 'name' => 'Galactic Empire',
      'xws' => 'galacticempire',
      'ffg' => 2,
      'icon' => 'https://sb-cdn.fantasyflightgames.com/factions/Imperial.png' }
  end

  let(:translator) { described_class.new }

  before do
    translator.input_pilots = [input_pilot1, input_pilot2, input_pilot3]
    translator.input_actions = [input_action1, input_action2]
    translator.input_factions = [input_faction1, input_faction2]
    translator.translate_all
  end

  it 'is able to de-dupe ships that have the same name' do
    expect(translator.ships.length).to be 2
  end

  it 'is able to translate raw loader hash inputs into data ready for DB import for pilots' do
    expect(translator.pilots.length).to be 16
  end

  it 'is able to translate raw loader hash inputs into data ready for DB import for factions' do
    expect(translator.factions.length).to be 2
  end

  it 'is able to translate raw loader hash inputs into data ready for DB import for actions' do
    expect(translator.actions.length).to be 2
  end

  it 'is able to add factions to previously found ships for multi-faction ships' do
    y_wing = translator.ships.find { |ship| ship[:name] == 'BTL-A4 Y-wing' }
    expect(y_wing[:factions].size).to be 2
  end
end
