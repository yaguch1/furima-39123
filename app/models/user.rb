class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true
  validates :kanji_sei, presence: true
  validates :kanji_mei, presence: true
  validates :kana_sei, presence: true
  validates :kana_mei, presence: true
  validates :date_of_birth, presence: true
end
