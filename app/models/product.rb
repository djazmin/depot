class Product < ActiveRecord::Base
  validates :title, :description, :image, :presence => true
  validates :price, :numericality => {:greater_than_or_equal_to => 0.10}
  validates :title, :uniqueness => true
  validates :image, :format => {:with => /\.(gif|jpg|png)$/i,multiline: true, :message => 'el formato no es aceptado'}
end
