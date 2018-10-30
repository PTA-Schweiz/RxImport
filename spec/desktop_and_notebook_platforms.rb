
class DesktopAndNotebookPlatforms < Rximport::Mapping::Base
  SUCCESSOR_NIL_VALUES = ['---', 'No replacement', nil, ' ']

  map_attribute 'B', :sort
  map_attribute 'C', :name
  # map_attribute 'D', :family
  map_attribute 'F', :claim

  map_array %w[G H I J K L M], :features
  map_hash %w[M N O P Q R S T U V W X Y Z AA], :technologies
end