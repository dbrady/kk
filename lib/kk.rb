# main include/bootup/loadup file

require 'sequel'
require 'sqlite3'

DB = Sequel.connect('sqlite://' + File.expand_path("~/.kk-journal.db"))

require_relative './kk/entry'
