# app/models/admin_session_form.rb
class AdminSessionForm
  include ActiveModel::Model

  attr_accessor :email, :password

  validates :email, presence: true
  validates :password, presence: true
end
