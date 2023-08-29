class DebtManager < ApplicationRecord
  belongs_to :challenger, class_name: 'User', foreign_key: 'challenger_id'
  belongs_to :challengee, class_name: 'User', foreign_key: 'challengee_id'

end
