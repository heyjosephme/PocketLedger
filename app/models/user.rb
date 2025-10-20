class User < ApplicationRecord
  extend FriendlyId
  friendly_id :email, use: [ :slugged, :finders ]

  # Include default devise modules. Others available are:
  # :confirmable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :lockable

  has_many :expenses, dependent: :destroy

  # Regenerate slug if email changes
  def should_generate_new_friendly_id?
    email_changed? || slug.blank?
  end
end
