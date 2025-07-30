FactoryBot.define do
  factory :profile do
    name { "Matz" }
    url { "https://l1nq.com/iRBvc" }
    username { "matz" }
    followers_count { "10k" }
    following_count { "0" }
    stars_count { "18" }
    contributions_count { "972" }
    image_url { "https://avatars.githubusercontent.com/u/30733?v=4" }
    organization { "Ruby Association,NaCl" }
    location { "Matsue, Japan" }

    trait :profile_2 do
      name { "Matz 2" }
    end
  end
end
