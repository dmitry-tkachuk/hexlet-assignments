# frozen_string_literal: true

class RepositoryLoaderJob < ApplicationJob
  queue_as :default

  def perform(repository_id) # rubocop:disable Metrics/AbcSize
    repository = Repository.find repository_id

    return if repository.blank?

    repository.fetch!

    octokit_repo = Octokit::Repository.from_url(repository.link)

    github_data = Octokit::Client.new.repository(octokit_repo)

    repository.update!(
      repo_name: github_data[:name],
      owner_name: github_data[:owner][:login],
      description: github_data[:description],
      default_branch: github_data[:default_branch],
      watchers_count: github_data[:watchers_count],
      language: github_data[:language],
      repo_created_at: github_data[:created_at],
      repo_updated_at: github_data[:updated_at]
    )

    repository.done! if repository.may_done?
  rescue StandardError
    repository.fail! if repository.may_fail?
  end
end
