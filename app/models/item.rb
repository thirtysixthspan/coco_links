class Item < ActiveRecord::Base

 has_many :accesses

SIXTYTWO = ('0'..'9').to_a + ('a'..'z').to_a + ('A'..'Z').to_a

def generate_code
  i = self.id
  s = ''
  while i > 0
    s << SIXTYTWO[i.modulo(62)]
    i /= 62
  end
  s.reverse
end

def code_url(root)
  "#{root}#{self.code}"
end

def readable
  if self.title && self.title != ''
    self.title
  else
    self.code
  end
end

end
