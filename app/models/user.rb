class User < ActiveRecord::Base

  validates :first_name, :last_name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: /\A^(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})\z/ }
  validates :phone_number, presence: true, numericality: { only_integer: true }, format: { with: /\A\d{10}\z/, message: 'has the wrong format' }
  validates :password_hash, presence: true
  # validates :avatar, format: { with: /([^\s]+(\.(?i)(jpg|png|gif|bmp))$)/ }


end
