class LawPlugin < Caboose::CaboosePlugin

  def self.admin_nav(nav, user = nil, page = nil)
    return nav if user.nil? || !user.is_allowed('law', 'view')
    
    nav << {
      'id' => 'law',
      'href' => '/admin/laws', 
      'text' => 'License Law',
      'modal' => false
    }
    return nav
  end
  
end
