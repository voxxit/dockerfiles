#!/usr/bin/env ruby

require 'csv'

CSV do |out| # Send to STDOUT
  CSV.foreach("/in") do |line| # for each line in the given file, if ...
    next unless line[3] == 'true'     # not a current version
    next unless line[4] == 'false'    # doesn't have a delete marker
    next unless line[8] == 'STANDARD' # only include STANDARD class files

    out << [ line[1] ] # S3 key
  end
end
