# frozen_string_literal: true

require 'erb'

class TFSAuditor
  attr_reader :client, :highest_changeset

  def initialize(client_object)
    @client = client_object
  end

  def untested_changes(query = {})
    files = client.changed_files(query)
    @highest_changeset = files.map { |f| f['id'] }.max
    # binding.pry;2
    _extract_change_types(files.select { |c| _has_untested_code?(c) })
  end

  def _remove_domain(str)
    str.split('\\').last
  end

  def untested_change_report(query = {})
    files = untested_changes(query)
    by_team = _map_files_to_teams(files)
    template = ERB.new(File.open('tfs_audit_report.html.erb', 'r').read)
    File.open('untested_change_report.html', 'w') { |f| f.write(template.result(binding)) }
  end

  def _pat_teams_map
    @teams_map ||= File.open('pat_teams.yml', 'r') { |f| YAML.safe_load(f.read) }
  end

  def _empty_teams_hash
    by_team = {}
    _pat_teams_map.values.uniq.each { |t| by_team[t] = {} }
    by_team
  end

  def _map_files_to_teams(files)
    by_author = {}
    by_team = _empty_teams_hash
    files.each { |f| by_author[_remove_domain(f['author'])] = by_author.fetch(_remove_domain(f['author']), []) << f }
    by_author.each { |k, v| puts k; by_team[_pat_teams_map[k]][k] = v }
    by_team
  end

  private

  def _extract_change_types(changes)
    changes.each do |change|
      change['change_types'] = change['files'].map { |x| x['type'].delete(',') }.join(' ').split(' ').uniq
      change['change_score'] = change['change_types'].include?('add') ? 10 : 0
    end
    changes.sort { |a, b| b['change_score'] <=> a['change_score'] }
  end

  # Warning:  This method has side effects, it will reduce change['files'] down to just C# files
  def _has_untested_code?(change)
    # binding.pry if change['id'] == 132087
    change['files'] = change['files'].select do |file|
      _should_keep_file?(file['path'])
    end
    return false unless change['files'].count.positive?

    change['file_count'] = change['files'].count
    change['files'].none? { |file| file['path'] =~ /test(s?)/i }
  end

  def _should_keep_file?(path)
    path =~ /\.cs$/ && # only .cs files
      # Weed out files in folders we don't care about by looking at the path, but don't eliminate something with tests
      path !~ /(generated|codevalue|branch|model|assemblyinfo)(?!.*test)/i &&
      # Don't look at interfaces, found by lookfing for path/ISomeName
      path !~ /\/I[A-Z]/
  end
end
