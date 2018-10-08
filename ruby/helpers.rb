require 'json'

class CopyPaste
  class << self
    def copy(str)
      IO.popen(copy_location, 'w') { |f| f << str }
      nil
    end

    def paste
      `#{paste_location}`
    end

    private

      def copy_location
        case RUBY_PLATFORM
        when /linux/
          'xclip -selection c'
        when /darwin/
          'pbcopy'
        end
      end

      def paste_location
        case RUBY_PLATFORM
        when /linux/
          'xclip -selection c -o'
        when /darwin/
          'pbpaste'
        end
      end
  end
end

def json_pp(object, out=$stdout)
  result = case object
  when String
    JSON.pretty_generate(JSON.parse(object))
  when Array, Hash
    JSON.pretty_generate(object)
  else
    object.inspect
  end

  out.puts result
rescue JSON::ParserError => e
  out.puts e.message
end

def subl(path)
  `subl #{Array(path).compact.join(':')}`
end

def sbl(instance, meth)
  location = instance.method(meth).source_location
  return unless location

  subl location
end

def go(instance, meth)
  path = instance.method(meth).source_location.to_a.first
  return unless path

  gem_name = (path.split('/') - ENV['GEM_HOME'].split('/')).first(2)
  gem_path = Pathname(ENV['GEM_HOME']).join(*gem_name)

  subl gem_path
  sbl instance, meth
end

def cpy(string)
  CopyPaste.copy(string)
end

def pst
  CopyPaste.paste
end
