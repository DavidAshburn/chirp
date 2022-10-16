class TweetsController < ApplicationController
	before_action :require_user_logged_in!
	before_action :set_tweets, only: [:index]

	def index
	end
	
	def new
		@tweet = Tweet.new
	end

	def create
		@tweet = Current.user.tweets.create(tweet_params)
		if @tweet.save
			redirect_to tweets_path, notice: "Scheduled"
		else
			render :new, status: :unprocessable_entity
		end
	end

	def edit
	end

	private
	def set_tweets
		@tweets = Current.user.tweets
	end

	def tweet_params
		params.require(:tweet).permit(:body, :publish_at, :twitter_account_id)
	end
end