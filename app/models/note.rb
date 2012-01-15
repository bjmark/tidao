require 'yaml'

class Note 
  def initialize(user)
    @user = user
  end

  def index_file
    "#{@user.root}/index.yaml"
  end

  def index
    f = index_file
    if File.exist?(f)
      y = YAML.load_file(f)
    else
      y = {}
    end

    return y
  end

  def create(name,content)
    _index = index
    new_id = (_index.keys.sort.last || 0) + 1
    _index[new_id] = name
    File.open(index_file,'w') {|f| YAML.dump(_index,f)}

    f = "#{@user.root}/#{new_id}"
    File.open(f,'w') do |h|
      h.puts content
    end

    return new_id
  end

  def [](id)
    f = "#{@user.root}/#{id}"
    content = File.read(f) 
    name = index[id.to_i]
    return [name,content]
  end
end
