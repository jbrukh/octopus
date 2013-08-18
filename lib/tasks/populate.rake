namespace :populate do
  desc "Populate the db with some fake data"
  task :participants => :environment do
    user = User.find_by_email('jonnii@octopusmetrics.com')

    (0...5000).each do |p|
      Participant.create!({
        :first_name => Forgery(:name).first_name,
        :last_name  => Forgery(:name).last_name,
        :gender     => 'm',
        :email      => Forgery(:email).address,
        :birthday   => rand(Date.civil(1970, 1, 1)..Date.civil(1990, 12, 31)),
        :user       => user
      })
    end
  end
end