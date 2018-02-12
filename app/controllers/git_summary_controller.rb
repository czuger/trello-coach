class GitSummaryController < ApplicationController
  def show
    @git_repositories = YAML.load( File.open( 'credentials/git.yml' ).read )[ :repositories_names ]
    @git_repositories_json = @git_repositories.to_json
  end
end
