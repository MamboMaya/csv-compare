class FilesController < ApplicationController
  skip_before_action :verify_authenticity_token
  require 'csv'

  def index
  end

  def compare
    discrepancy_indexes = []
    discrepancy_emails  = []

    custom_headers = {
      'Account Email' => :account_email,
      'YouTube Channel' => :channel_ownership,
      'Subscriber Count' => :subscriber_count
    }

    concerns = [:channel_ownership, :subscriber_count]
    if params[:concern]
      concerns = concerns.select { |item| item === params[:concern].to_sym }
    end

    base_file = params[:files].shift
    base_table = CSV.table(base_file, headers: true, header_converters: lambda { |name| custom_headers[name.strip]})

    files_array = params[:files].map { |file| CSV.table(file, headers: true, header_converters: lambda { |name| custom_headers[name.strip] } ) }

    base_table.each_with_index do |base_row, base_index|
      files_array.each do |compare_file|
        if !discrepancy_indexes.include?(base_index)
          concerns.each do |field|
            if equal_values?(field, base_row[field], compare_file[base_index][field])
              next
            else
              discrepancy_indexes << base_index
              discrepancy_emails  << base_row[:account_email]
              break
            end
          end
        end
      end
    end
    render json: { data: discrepancy_emails  }
  end

  private

  def equal_values?(field, left, right)
    if field === :channel_ownership
      clean_url(left) == clean_url(right)
    else
      clean_int(left) == clean_int(right)
    end
  end

  def clean_url(str)
    channel_id = str.split('/').last
    if channel_id.start_with?('UC')
      channel_id[2..-1]
    else
      channel_id
    end
  end

  def clean_int(val)
    if val.is_a? String
      val.tr('^0-9', '').to_i
    else
      val
    end
  end

end
