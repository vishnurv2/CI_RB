# frozen_string_literal: true
#

# frozen_string_literal: true

# Database Helper module 6/10/2020
module DatabaseHelper
  require 'pg'

  # Database class
  class Database
    attr_accessor :database, :stmt

    def initialize(args)
      @database = args[:database]
      @stmt = args[:stmt]
    end

    def db_exec

      host = 'vsqvwcucumber01.central-insurance.com'
      port = '5432'
      db = 'policy_data'
      schema = 'public'
      user = 'postgres'
      pass = 'password'

      con = PG.connect(dbname: db, host: host, user: user, password: pass)
      con.exec stmt
    rescue PG::Error => e
      warn "Unable to write to database, exception: #{e}"
    ensure
      con.close
    end

    def self.execute(database:, stmt:, method: :db_exec)
      Database.new(database: database, stmt: stmt).send(method)
    end

  end
end
