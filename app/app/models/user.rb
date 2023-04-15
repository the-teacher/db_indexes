# rails g model user login:string name:string email:string region:string
# rake db:migrate
class User < ApplicationRecord
  validates :login,
    presence: true,
    uniqueness: true,
    length: { minimum: 5 }

  validates :name,
    presence: true,
    length: { minimum: 5 }

  validates :email,
    presence: true,
    uniqueness: true
end
