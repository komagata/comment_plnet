class Comment < ActiveRecord::Base
  validates_presence_of :url, :name, :body
end
