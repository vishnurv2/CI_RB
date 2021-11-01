# frozen_string_literal: true

class TFSClient
  include HTTParty_with_cookies
  base_uri 'http://tfs:8080/tfs/centralteamprojects/'
  http_proxy('localhost', '8888') if Nenv.use_fiddler?
  headers 'Content-Type' => 'application/json; charset=UTF-8'

  def initialize(password)
    @nltm_password = password
  end

  def get(url, opts = {})
    resp = super(url, opts.merge(ntlm_auth: { password: @nltm_password }))

    raise "Invalid response (#{resp.code}) from server when getting #{url}" unless resp.code == 200

    JSON.parse(resp.body)
  end

  def projects
    get('/projects?api-version=4.0')
  end

  def test
    get('/JarusScrum/_apis/release/releases')
  end

  def changesets(query = {})
    get('/JarusScrum/_apis/tfvc/changesets', query: query)
  end

  def changeset(id)
    get("/JarusScrum/_apis/tfvc/changesets/#{id}")
  end

  def changeset_changes(id)
    get("/_apis/tfvc/changesets/#{id}/changes")
  end

  def changeset_ids(query = {})
    changesets(query)['value'].map { |c| c['changesetId'] }
  end

  def changeset_ids_with_authors(query = {})
    changesets(query)['value'].map { |c| { 'id' => c['changesetId'], 'author' => c['author']['uniqueName'] } }
  end

  def changes(query = {})
    # For all changes listed, grab the detailed changes which included the files modified
    changeset_ids_with_authors(query).map { |item| changeset_changes(item['id']).merge('changeset_id' => item['id'], 'author' => item['author']) }
  end

  def changed_files(query = {})
    # Turn a list of changeset changes, into a list of hashes containing the changed files, type of changes
    # and the changeset ID.
    changes(query).flat_map { |c| { 'id' => c['changeset_id'], 'author' => c['author'], 'files' => c['value'].map { |i| { 'path' => i['item']['path'], 'type' => i['changeType'] } } } }
  end
end
