require 'yaml'

class YFile
  def initialize(file)
    @file = file
  end

  def load
    File.exist?(@file) ? YAML.load_file(@file) : {}
  end

  def save(hash)
    File.open(@file,'w') {|f| YAML.dump(hash,f)}
  end

  def del(id)
    h = load
    item = nil

    if h[id] 
      item = [id,h[id]]
      h.delete(id)
      save(h)
    end

    return item
  end

  def [](id)
    load()[id]
  end

  def add(id,name)
    h = load
    h[id] = name
    save(h)
  end

end

class Note 
  def initialize(user)
    @user = user
    @index = YFile.new("#{@user.root}/index.yaml")
    @rubbish = YFile.new("#{@user.root}/rubbish.yaml")
    @history = YFile.new("#{@user.root}/history.yaml")
  end

  def index
    @index.load
  end

  def create(name,content)
    his = @history.load
    new_id = (his.keys.sort.last || 0) + 1
    @history.add(new_id,name)
    @index.add(new_id,name)

    f = "#{@user.root}/#{new_id}"
    File.open(f,'w') do |h|
      h.puts content
    end

    return new_id
  end

  def [](id)
    f = "#{@user.root}/#{id}"
    index = @index.load
    if index[id] and File.exist?(f)
      content = File.read(f) 
      name = index[id]
      return [name,content]
    end

    return nil
  end

  def del(id)
    item = @index.del(id)
    @rubbish.add(item[0],item[1]) if item
  end

  def update(id,name,content)
    f = "#{@user.root}/#{id}"
    index = @index.load

    if index[id] and File.exist?(f)
      index[id] = name
      @index.save(index)

      File.open(f,'w') do |h|
        h.puts content
      end
      return true
    end

    return false
  end
end
