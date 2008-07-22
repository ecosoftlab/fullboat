class LastFmScrobblingObserver < ActiveRecord::Observer
  require 'net/http'
  require 'digest'
  
  @@net = Net::HTTP.new("post.audioscrobbler.com", 80)
  @@config = {:username => 'wrct883', :password => 'tL.fmPwi=ref'} #TODO into settings
  @@token = ''
  cattr_accessor :net, :config, :token
  
  class ConnectError < StandardError; end
  class UpdateError  < StandardError; end
  class SubmitError  < StandardError; end
  
  observe :play
  
  def after_create(play)
    if play.playable.kind_of?(Album)
      handshake if @@token.blank?
      scrobble(play, play.created_at)
    end
  end
  
protected
  
  def track_params(play)
    case play.playable
    when Album
      {
        'a' => play.playable.artist,
        't' => play,
        'b' => play.playable,
        'l' => play.duration,
        'n' => '', 
        'm' => ''
      }
    end
  end

  def handshake
    @timestamp = Time.now.utc.to_i
    params = {
      'hs' => 'true',
      'p' => '1.2',
      'c' => 'tst',
      'v' => '1.0',
      'u' => @@config[:username],
      'a' => auth(@@config[:password], @timestamp),
      't' => @timestamp
    }
    response = @@net.get("/?#{encode_params(params)}")
    if response.code.to_i == 200
      info = response.body.split("\n")
      code = info.shift
      if code == "OK"
        @@token, np_url, submit_url = info
        @@submit = URI.parse(submit_url)
      else
        raise ConnectError, "Handshake response: #{code}" 
      end
    else
      raise ConnectError, "Handshake failed: #{response.code}"
    end
    # puts "Connection OK"
    # puts "submit: #{@submit_url}"
  end
  
  def scrobble(play, played_at)
    params = {}
    track_params(play).merge('o' => 'P', 'r' => '', 'i' => played_at.to_s).collect { |k,v| params["#{k}[0]"] = v.to_s }
    post_request(@@submit, params)
  end

  def encode_params(params)
    params.collect { |kv| kv.join('=') }.join('&')
  end
  
  def post_request(url, params)
    submit_params = params.merge('s' => @@token) # encode_params?
    r = Net::HTTP.post_form(url, submit_params)
    if r.body.chomp == 'BADSESSION'
      handshake
      r = Net::HTTP.post_form(url, submit_params)
    end
    return r.body
  rescue Errno => e
    # puts "error: #{e}, retrying"
    # puts "url: #{url}"
    r = Net::HTTP.post_form(url, submit_params)
    return r.body
  end

  def auth(password, timestamp)
    Digest::MD5.hexdigest(Digest::MD5.hexdigest(password)+timestamp.to_s)
  end
end
