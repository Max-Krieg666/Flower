class User < ActiveRecord::Base
  ROLES = %w(Пользователь Модератор Администратор).freeze
  has_secure_password
  before_validation :set_default_role
  validates :password, length: { minimum: 6 }, if: "password.present?"
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  validates :role, presence: true, inclusion: { in: 0...ROLES.size }
  has_one :order, dependent: :nullify

  def moderator?
    role == 1 || admin?
  end

  def admin?
    role == 2
  end

  def user?
    role == 0
  end

  def set_default_role
    role ||= 0
  end

  def role_view
    ROLES[role]
  end
end