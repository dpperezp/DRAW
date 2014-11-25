class Product < ActiveRecord::Base
  belongs_to :category
  has_many :line_items
  
  before_destroy :referencia_lineitem?
  
  private
    def referencia_lineitem?
      if line_items.empty?
        return true
      else
        errors.add(:base, 'Esta en lineas')
        return false
      end
    end
end
