#!/usr/bin/env ruby
require 'csv'
require 'yaml'

countries = Hash.new {|hash,key| hash[key] = nil }

CSV.foreach("countries.tsv", { :col_sep => "\t" }) do | row |

  alpha2 = row[0].nil? ? nil : row[0].strip
  alpha3 = row[1].nil? ? nil : row[1].strip
  numeric = row[2].nil? ? nil : row[2].strip
  name = row[3].nil? ? nil : row[3].strip
  altnames = row[4].nil? ? nil : row[4].split(',').map(&:lstrip)
  adjectivals = row[5].nil? ? nil : row[5].split(',').map(&:lstrip)
  demonyms = row[6].nil? ? nil : row[6].split(',').map(&:lstrip)

  countries[alpha2] = {
    :name => name,
    :aplha3 => alpha3,
    :numeric => numeric,
    :altnames => altnames,
    :adjectivals => adjectivals,
    :demonyms => demonyms
  } unless name == 'name'

end

puts countries.inspect

open("../yaml/countries.yml", 'w') {|f| YAML.dump(countries, f)}
