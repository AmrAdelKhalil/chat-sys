class Hash
  # Convert hash from structure {k => v, k1 => v} to {v=>[k, k1]}
  def safe_invert
    self.each_with_object({}){|(k,v),o|(o[v]||=[])<<k}
  end
end