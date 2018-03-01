class GitSummaryController < ApplicationController
  def show
    @git_data = File.open( 'data/git_data.json', 'r' ).read
    @git_repositories = JSON.parse( @git_data ).keys
  end
end
