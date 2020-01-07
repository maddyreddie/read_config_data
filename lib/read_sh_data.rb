#
# Author::      Madhusudhan Reddy Marri.
# Copyright::   Copyright (c) 20019
# License::     MIT
# URL::         https://github.com/maddyreddie/read_config_data.git

class ReadShData

    Version = '0.0.1'
  
    attr_accessor :sh_file, :data
    
    def initialize(sh_file=nil, separator='=', comments=['#', ';'])
      @sh_file = sh_file
      @data = data
     
  
      if(self.sh_file)
        self.validate_sh()
        self.import_sh()
      end
    end
  
    # Validate the config file, and contents
    def validate_sh()
      unless File.readable?(self.sh_file)
        raise Errno::EACCES, "#{self.sh_file} is not readable"
      end 
      # FIX ME: need to validate contents/structure?
    end
  
    # Import data from the config to our config object.
    def import_sh()
      data = ''
      open(self.sh_file) { |f| f.each_with_index do |line, i|
        
        data = data + ' ' + line
        # force_encoding not available in all versions of ruby
        begin
          if i.eql? 0 and line.include?("\xef\xbb\xbf".force_encoding("UTF-8"))
            line.delete!("\xef\xbb\xbf".force_encoding("UTF-8"))
          end
        rescue NoMethodError
        end
       
      end }
      self.data = data
    end
  
    def get_data
      self.data
    end

    def get_file_name
      self.sh_file.split('/').last
    end

    def get_file_path
      self.sh_file
    end
   
  end
  
