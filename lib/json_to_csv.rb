require 'json_to_csv/version'
require 'csv'
require 'json'

module JsonToCsv
  class Error < StandardError; end
  # Your code goes here...

  class Convert
    def initialize(filepath)
      @filepath = filepath
      convert
    end

    private

    def convert
      read_and_parse_json_file
      build_headers
      generate_csv_filepath
      write_into_csv_file
    end

    def read_and_parse_json_file
      response = File.read(@filepath)
      @path = File.basename(@filepath, ".*")
      @parsed_json = JSON.parse(response)
    end

    def build_headers
      object = @parsed_json.first
      @headers = retrieve_object_keys(object)
    end

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

    def generate_csv_filepath
      @csv_filepath = "#{@path}.csv"
    end

    def write_into_csv_file
      csv_options = { col_sep: ',', quote_char: '"' }
      CSV.open(@csv_filepath, 'w+', csv_options) do |csv|
        csv << @headers
        @parsed_json.each do |object|
          csv << build_object_csv_row(object)
        end
      end
    end

    def build_object_csv_row(object)
      values = @headers.map do |path|
        retrieve_value(object, path)
      end
    end

    def retrieve_value(object, header)
      path_keys = header.split('.')
      path_keys.each do |path_key|
        return nil if object.nil?
        object = object[path_key]
      end
      value = compute_value(object)
    end

    def compute_value(value)
      return value unless value.is_a?(Array)

      value.join(",")
    end
  end
end
