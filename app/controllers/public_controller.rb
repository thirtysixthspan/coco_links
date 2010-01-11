class PublicController < ApplicationController

def recent 
  @recent_items = Item.find(:all, :limit=>10)
end

def popular
  accesses = Access.find(:all, :limit=>1000, :order=> 'created_at DESC')
  counts = Hash.new()
  accesses.each do |access|
    counts[access.item_id] = 0 unless counts.include?(access.item_id)
    counts[access.item_id] += 1
  end
  @popular_items = counts.sort {|a,b| b[1]<=>a[1]}
  
end


def index
end

def create_url
  redirect_to :action=>:index and return unless params['url']
  url = params['url']  

  @item = Item.new()
  @item.url = url
  if params['title'] && params['title'] != ''
    @item.title = params['title']
  else
    @item.title = get_title(url)    
  end
  redirect_to :action=>:index and return unless @item.save
  @item.code = @item.generate_code() 
  redirect_to :action=>:index and return unless @item.save
end

def redirect_url
  redirect_to :action=>:index and return unless params['code']
  code = params['code']  

  @item = Item.find(:first, :conditions => ['code = ?',code])
  redirect_to :action=>:index and return unless @item
  
  @access = Access.new()
  @access.item_id = @item.id
  @access.ip = request.remote_ip
  @access.referrer = request.referrer
  redirect_to :action=>:index and return unless @access.save()
  
  redirect_to @item.url, :status=>302 
  
end

private

def get_title(url, is_redirect=false)
    uri = URI.parse(url)
    http = Net::HTTP::new(uri.host, uri.port)
    http.use_ssl = true if uri.scheme.downcase == "https"
    response = http.request_head((uri.path.blank? ? "/" : uri.path))
    if response.is_a? Net::HTTPSuccess
      case response['Content-Type']
      when /text\/html/i
        response, body = http.get((uri.path.empty? ? '/' : uri.path))
        return $1 if body =~ /<title>(.*?)<\/title>/im
      else
        return "#{url.to_s.split("/").last} [#{response['Content-Type']}]"
      end
    elsif response.is_a? Net::HTTPRedirection
      return get_title(response['Location'], true) if (response['Location'] and !is_redirect)
    else
      return ""
    end
    return ""
  end

end
