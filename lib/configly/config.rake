require "digest"
require "erb"
require "securerandom"

namespace :config do

  desc "create configuration file"
  task :create do

    erb = File.join( File.dirname(__FILE__), "../erb/config.yml.erb" )
    dst = File.join( Dir.pwd, ".config.yml" )

    if File.exists?(dst)

      puts "Error: file exists, aborting..."
      exit

    end

    apikey    = Digest::SHA256.hexdigest(SecureRandom.hex(30))
    enckey    = Digest::SHA256.hexdigest(SecureRandom.hex(30))
    enciv     = Digest::SHA256.hexdigest(SecureRandom.hex(30))

    app       = ERB.new(File.read(erb))
    contents  = app.result(binding)

    f = File.open( dst, "w" )
    f.write(contents)
    f.close

    puts ".config.yml created"

  end

end

