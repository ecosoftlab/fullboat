class TwitterObserver < ActiveRecord::Observer
  require 'twitter'

  @@twitter =  Twitter::Base.new('ism@wrct.org', 'rNGpwilH4xing') # TODO put in config
  
  observe :play
  
  def after_create(play)
    tag = case play.playable
          when Album
            "#nowplaying"
          when Comment
            "#comment"
          end  
    
    @@twitter.update("#{play.to_s.truncate(140 - (tag.length + 1))} #{tag}") if tag
  end
end
