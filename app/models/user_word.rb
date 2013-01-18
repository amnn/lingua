class UserWord < ActiveRecord::Base
  attr_accessible :correct, :lang_id, :last_updated, :progress, :user_id, :word_id, :wrong

  belongs_to :lang, class_name: 'Language'
  belongs_to :user
  belongs_to :word
  
end
