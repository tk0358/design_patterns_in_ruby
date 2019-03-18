def camel_case(string)
  tokens = string.split('.')
  tokens.map!{|t| t.capitalize}
  tokens.join('Dot')
end

def authorizer_for(message)
  to_host = message.to.host || 'default'
  authorizer_class = camel_case(to_host) + "Authorizer"
  authorizer_class = self.class.const_get(authorizer_class)
  authorizer_class.new
end

def worm_case(string)
  tokens = string.split('.')
  tokens.map! {|t| t.downcase}
  tokens.join('_dot_')
end

def authorized?(message)
  authorizer = authorizer_for(message)
  user_method = worm_case(message.from) + '_authorized?'
  if authorizer.respond_do?(user_method)
    return authorizer.send(user_method, message)
  end
  authorizer.authorized?(message)
end