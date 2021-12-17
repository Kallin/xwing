class LibLoader

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
    [Faction, Action].each do |klazz|
      klazz.delete_all
    end
  end

  def load_all
    load_factions
    load_actions
  end

end