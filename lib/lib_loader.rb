class LibLoader

  def load_ships
    ships = load_from_input_file
    mapped_ships = ships.map do |ship|
      {
        name: ship['name'],
        attack: ship['attack'],
        agility: ship['agility'],
        hull: ship['hull'],
      }
    end
    Ship.insert_all(mapped_ships)
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
    klazz.insert_all(entities.map { |f| { name: f } })
  end

  def build_lib_file_path(file_name)
    Rails.root.join('db', 'library', "#{file_name}.json")
  end

  def refresh_all
    delete_all
    load_all
  end

  def delete_all
    [Faction, Action, Ship].each do |klazz|
      klazz.delete_all
    end
  end

  def load_all
    load_factions
    load_actions
    load_ships
  end

  def load_from_input_file
    text = File.read('ships.json')
    ships = JSON.parse(text).values[0].values
  end

end