class IssueSummary < ActiveRecord::Base
  has_many :tickets
end
