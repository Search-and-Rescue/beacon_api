require 'csv'

task import: :environment do
  CSV.foreach('db/csv_data/sar.csv', headers: true) do |row|
    SearchAndRescue.create!(row.to_hash)
  end
end
