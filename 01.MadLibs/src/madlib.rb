class String

  def libs
    self.scan(/(\(\([^)]+\)\))/).flatten
  end
  
  def lib_with replacements
    self.gsub( /\(\(([^)]+)\)\)/ ).each{ replacements.shift }
  end
  
  def madlib_it( output = $stdout, input = $stdin )
    mappings = []
    self.libs.each do | lib |
      output.puts "Please provide: "
      output.puts lib
      mappings.push input.gets.chomp
    end
    self.lib_with mappings
  end
  
end

