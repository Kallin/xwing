# frozen_string_literal: true

FactoryBot.define do
  factory :quick_build do
    pilot { nil }
    threat_level { 1 }
    upgrades { nil }
  end
end
