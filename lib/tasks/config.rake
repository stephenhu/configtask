require "digest"
require "erb"
require "securerandom"

namespace :config do

  desc "create configuration file"
  task :create do

    if File.exists?("config/config.yml")

      puts "Error: file exists, aborting..."
      exit

    end

    apikey    = Digest::SHA256.hexdigest(SecureRandom.hex(30))
    enckey    = Digest::SHA256.hexdigest(SecureRandom.hex(30))
    enciv     = Digest::SHA256.hexdigest(SecureRandom.hex(30))

    app       = ERB.new(File.read("config/config.yml.erb"))
    contents  = app.result(binding)

    f = File.open( "config/config.yml", "w" )
    f.write(contents)
    f.close

    puts "config/config.yml created"

  end

end

