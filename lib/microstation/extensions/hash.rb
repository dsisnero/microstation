class Hash


  def map_v
    reduce({}) do |result, array|
      k,v = array
      new_val = yield v
      result.merge( k => new_val)
    end
  end

  def map_k
    reduce({}) do |result, array|
      k,v = array
      new_k = yield k
      result.merge(new_k => v)
    end
  end

  def map_kv
    reduce({}) do |result, array|
      new_k,new_v = yield array
      result.merge(new_k => new_v)
    end
  end

end
