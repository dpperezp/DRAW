class Category < ActiveRecord::Base
  has_many :products
  
      #calbacks
  
  validates :name, presence: true
  before_validation do
    puts "Antes de la validacion"
  end
  
  after_validation do
    puts "Después de la validacion"
  end
  
  before_save do
    puts "Antes de guardar"
  end
  
  after_save do
    puts "Después de guardar"
  end
  
  after_initialize do
    if self.description.nil?
      self.description = 'No hay descripción disponible'
    end
  end

end
