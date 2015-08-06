class QualificationsController < ApplicationController
  def index
    uri = URI 'https://api.gojimo.net/api/v4/qualifications'
    http = Net::HTTP.new uri.hostname
    http.open_timeout = 20.seconds
    http.read_timeout = 20.seconds
    begin
      response = http.get uri.path
      if response.is_a? Net::HTTPOK
        record = Cache.find_or_create_by url: uri.to_s
        @qualifications = record.value = response.body.force_encoding('UTF-8')
        record.save
      else
        logger.debug "QualificationsController@#{__LINE__}#index #{response.class}" if logger.debug?
        @qualifications = Cache.find_by(url: uri.to_s).value
      end
    rescue => e
      logger.debug "QualificationsController@#{__LINE__}#index #{e.inspect}" if logger.debug?
      @qualifications = Cache.find_by(url: uri.to_s).value
    end
    @qualifications = JSON.parse @qualifications
  rescue
    render text: t('qualifications.index.parse_error')
  end
end
