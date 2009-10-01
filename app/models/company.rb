#  create_table "companies", :force => true do |t|
#    t.string   "name"
#    t.integer  "status_id"
#    t.string   "name_in_demand"
#    t.datetime "created_at"
#    t.datetime "updated_at"
#  end

class Company < ActiveRecord::Base
  has_many :users
  belongs_to :status

  validates_presence_of     :name

  def initialize(*params)
    super(*params)
    self.status_id = Status::Company::VALPENDING
    self.name_in_demand ||= ''
  end

  HUMANIZED_ATTRIBUTES = {
    :name => "Firma Adı",
    :status_id => "Durum",
    :name_in_demand => "İhalede görülecek firma adı"
  }

  def self.human_attribute_name(attr)
    HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  end

end
