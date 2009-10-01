class Status < ActiveRecord::Base
  has_many :offers
  has_many :demands
end

module Status::Offer
  NEW = 5
  SELECTED = 4
  REJECTED = 6
  LEVEL_1 = 1
  LEVEL_2 = 2
  LEVEL_3 = 3
end


module Status::Demand
  NEW = 7
  ACTIVE = 8
  CLOSED = 9
  FINALIZED = 10  
end


module Status::Company
  VALPENDING = 11
  VALIDATED = 12
end

module Status::User
  VALPENDING = 13
  VALIDATED = 14
end

module Status::EmailRequest
  PENDING = 15
  STEP_1 = 17
  DONE = 16
end




