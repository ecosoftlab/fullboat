class Play < ActiveRecord::Base

  belongs_to :playlist
  
end

class PromoPlay < Play
  belongs_to :promo, :foreign_key => :parent_id
end

class PsaPlay < Play
  belongs_to :psa, :foreign_key => :parent_id
end

class UnderwritingContractPlay < Play
  belongs_to :underwriting_contract, :foreign_key => :parent_id
end