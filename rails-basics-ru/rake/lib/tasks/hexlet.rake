require 'csv'

namespace :hexlet do
  desc "Import users from csv"
  task :import_users, [:path] => :environment do |t, args|
    data = CSV.read(args[:path], headers: true)
    users = data.map do |row|
      first_name = row.field('first_name')
      last_name = row.field('last_name')
      email = row.field('email')
      birthday = Date.strptime(row.field('birthday'), '%m/%d/%Y')

      user = User.create(first_name:, last_name:, birthday:, email:)
    end

    pp "Created #{users.filter(&:persisted?).size} out of #{users.size} users."
  end
end
