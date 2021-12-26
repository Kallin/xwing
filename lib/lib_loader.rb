# frozen_string_literal: true

class LibLoader
  def load_ships
    input_ships = load_from_input_file
    mapped_ships = extract_relevant_attributes(input_ships)
    Ship.create!(mapped_ships)

    add_factions_and_actions(input_ships)
  end

  def add_factions_and_actions(input_ships)
    Ship.find_each do |ship|
      input_ship = input_ships.find { |the_ship| the_ship['name'] == ship.name }
      input_ship['actions'].each { |input_action| ship.actions << (Action.find_by name: input_action) }
      input_ship['factions'].each { |input_faction| ship.factions << (Faction.find_by name: input_faction) }
    end
  end

  def extract_relevant_attributes(input_ships)
    input_ships.map do |ship|
      {
        name: ship['name'],
        attack: ship['attack'],
        agility: ship['agility'],
        hull: ship['hull']
      }
    end
  end

  def load_factions
    path = build_lib_file_path('factions')
    insert_all_entities(path, Faction)
  end

  def load_actions
    path = build_lib_file_path('actions')
    insert_all_entities(path, Action)
  end

  def insert_all_entities(path, klazz)
    entities = JSON.parse(File.read(path))
    entities.map { |f| { name: f } }
    klazz.create!(entities.map { |f| { name: f } })
  end

  def build_lib_file_path(file_name)
    Rails.root.join('db', 'library', "#{file_name}.json")
  end

  def refresh_all
    delete_all
    load_all
  end

  def delete_all
    [Faction, Action, Ship].each(&:delete_all)
  end

  def load_all
    load_factions
    load_actions
    load_ships
  end

  def load_from_input_file
    text = File.read('ships.json')
    JSON.parse(text).values[0].values
  end
end
