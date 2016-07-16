require 'rubygems'
require 'mongo'
require 'twitter'

require_relative 'config'

class TweetArchiver
  # TweetArchiver Initializer
  def initialize(tag)
    connection = Mongo::Client.new(['127.0.0.1:27017'], :database => DATABASE_NAME)
    @tweets = connection[COLLECTION_NAME]

    @tweets.indexes.create_one({ :id => 1 }, :unique => true)
    @tweets.indexes.create_many([
      { :key => { tags: 1 }},
      { :key => { id: -1 }}
      ])

    @tag = tag
    @tweets_found = 0

    # Twitter API 1.1 requires consumer key.
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key    = YOUR_CONSUMER_KEY
      config.consumer_secret = YOUR_CONSUMER_SECRET
    end
  end

  def update
    puts "Starting Twitter search for '#{@tag}'..."
    save_tweets_for(@tag)
    print "#{@tweets_found} tweets saved.\n\n"
  end

  private

  def save_tweets_for(term)
    @client.search(term).each do |tweet|
      @tweets_found += 1
      tweet_with_tag = tweet.to_hash.merge!({"tags" => [term]})
      @tweets.insert_one(tweet_with_tag)
    end
  end

end
