ActionController::Routing::Routes.draw do |map|

  map.connect 'create_url', :controller => "public", :action=>"create_url"
  map.connect 'recent', :controller => "public", :action=>"recent"
  map.connect 'popular', :controller => "public", :action=>"popular"
  map.root :controller => "public"
  map.connect ':code', :controller => "public", :action=>"redirect_url"
  
end
