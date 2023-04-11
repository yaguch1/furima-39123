FactoryBot.define do
  factory :user do
    transient do
      person { Gimei.name }
    end

    nickname              { Faker::Name.initials(number: 2) }
    email                 { Faker::Internet.free_email }
    password              { '1a' + Faker::Internet.password(min_length: 6) }
    password_confirmation { password }
    kanji_sei             { person.first.kanji }
    kanji_mei             { person.last.kanji }
    kana_sei              { person.first.katakana }
    kana_mei              { person.last.katakana }
    date_of_birth         { Faker::Date.backward }
  end
end
