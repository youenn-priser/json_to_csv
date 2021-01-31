require 'json_to_csv/version'
require 'csv'
require 'json'

module JsonToCsv
  class Error < StandardError; end
  # Your code goes here...

  # 1 - Read and parse the JSON file
  def read_and_parse_json_file
    response = File.read(@filepath)
    @path = File.basename(@filepath, ".*")
    @parsed_json = JSON.parse(response)
  end
  # 2 - Retrieve and dig JSON object keys to build headers (Object have the same schema)
  def retrieve_object_keys(object, path = nil)
    response = object.map do |key, value|
      if value.is_a?(Hash)
        full_path = path ? "#{path}.#{key}" : key
        retrieve_object_keys(value, full_path)
      else
        if path && !path.nil?
          "#{path}.#{key}"
        else
          key
        end
      end
    end
    response.compact.flatten
  end
  # 3 - Header acts as path to lookup into object and retrieve value (specific computation for array values)
  def retrieve_value(object, header)
    path_keys = header.split('.')
    path_keys.each do |path_key|
      return nil if object.nil?
      object = object[path_key]
    end
    value = compute_value(object)
  end

  # - Specific computation of Array values
  def compute_value(value)
    return value unless value.is_a?(Array)

    value.join(",")
  end

  # 4 - Build the row to be inserted into the CSV file
  def build_object_csv_row(object)
    values = @headers.map do |path|
      retrieve_value(object, path)
    end
  end

  # 5 - Create the receiving CSV file
  def generate_csv_filepath
    @csv_filepath = "#{@path}.csv"
  end

  # 6 - Write into that CSV file
  def write_into_csv_file
    csv_options = { col_sep: ',', quote_char: '"' }
    CSV.open(@csv_filepath, 'w+', csv_options) do |csv|
      csv << @headers
      @parsed_json.each do |object|
        csv << build_object_csv_row(object)
      end
    end
  end
end
