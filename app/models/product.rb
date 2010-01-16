class Product < ActiveRecord::Base
  validates_presence_of :title, :descript, :img_url
  validates_numericality_of :price
  validates_uniqueness_of :title
  validates_length_of :title,
                      :minimum => 10,
                      :message => 'This title is less than 10 characters long.'
  validates_format_of :img_url,
                      :with    => %r{\.(gif|jpg|png)$}i,
                      :message => 'must be a URL for a gif, jpeg or png'
  
  
  validate :price_must_be_at_least_a_penny
  
  protected
  def price_must_be_at_least_a_penny
    errors.add(:price, 'should be at least 0.01') if price.nil? ||
      price < 0.01
  end
  
  def self.find_products_for_sale
    find(:all, :order => "title")
  end
  
end
