require 'rails_helper'

RSpec.describe QualificationsController, :type => :controller do

  describe "GET index" do
    let(:uri) {URI 'https://api.gojimo.net/api/v4/qualifications'}
    let(:http) {double}
    let(:repsonze) {double is_a?: true}

    before :each do
      allow(Net::HTTP).to receive(:new).with(uri.hostname).and_return(http)
      allow(http).to receive(:open_timeout=).with 20.seconds
      allow(http).to receive(:read_timeout=).with 20.seconds
      allow(http).to receive(:get).with(uri.path).and_return(repsonze)
      allow(repsonze).to receive(:body).and_return('[]')
    end

    it 'makes a request to "https://api.gojimo.net/api/v4/qualifications"' do
      expect(Net::HTTP).to receive(:new).with(uri.hostname).and_return(http)
      expect(http).to receive(:get).with(uri.path).and_return(repsonze)
      get :index
    end

    it 'sets open_timeout to 20' do
      expect(http).to receive(:open_timeout=).with 20.seconds
      get :index
    end

    it 'sets read_timeout to 20' do
      expect(http).to receive(:read_timeout=).with 20.seconds
      get :index
    end

    it 'parses the response and assigns it to @qualifications' do
      expect(repsonze).to receive(:body).and_return sample_json
      get :index
      expect(assigns :qualifications).to eq JSON.parse sample_json
    end

    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    context 'when response is not Net::HTTPOK' do
      let(:repsonze) {double is_a?: false}

      it 'loads the data from Cache and assigns it to @qualifications' do
        expect(Cache).to receive(:find_by).with(url: uri.to_s)
            .and_return Cache.new value: '[{"a": "b"}]'
        get :index
        expect(assigns :qualifications).to eq [{"a"=>"b"}]
      end
    end   # when response is not Net::HTTPOK

    context 'when an error occured during request to "https://api.gojimo.net/api/v4/qualifications"' do

      it 'loads the data from Cache and assigns it to @qualifications' do
        expect(http).to receive(:get).with(uri.path).and_raise
        expect(Cache).to receive(:find_by).with(url: uri.to_s)
            .and_return Cache.new value: '[{"a": "b"}]'
        get :index
        expect(assigns :qualifications).to eq [{"a"=>"b"}]
      end
    end   # when an error occured during request

    context 'when the wrong data comes' do
      it 'renders text "Parse error occured"' do
        expect(repsonze).to receive(:body).and_return 'wrong data'
        get :index
        expect(response.body).to eq 'Parse error occured'
      end
    end   # when the wrong data comes
  end   # GET index

end
