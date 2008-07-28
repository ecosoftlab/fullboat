atom_feed(:url => formatted_reviews_url(:atom)) do |feed|
  feed.title("Latest Album Reviews")
  feed.updated(@reviews.any? ? @reviews.first.created_at.utc  : Time.now.utc)

  @reviews.each do |review|
    feed.entry(review) do |entry|
      entry.title(review)
      entry.content(review.body, :type => 'html')
      
      entry.author do |author|
        author.name(review.user)
        author.url(user_url(review.user))
      end
    end
  end
end