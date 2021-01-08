require 'rails_helper'

RSpec.describe FilesController, type: :controller do

  describe "POST /compare" do
    context "input identical files" do
      it "returns an empty discrepancies array" do
        post :compare, params: { files: [fixture_file_upload('CSV1.csv'), fixture_file_upload('CSV1.csv')] }
        expect(JSON.parse(response.body)['data']).to eq([])
      end
    end

    context "input different files" do
      it "returns a discrepancies array" do
        post :compare,
          params: {
            files: [
              fixture_file_upload('CSV1.csv'),
              fixture_file_upload('CSV2.csv')
              ]
            }
        not_empty = JSON.parse(response.body)['data'].size > 0
        expect(not_empty).to eq(true)
      end
    end

    context "input more than 2 files containing differences" do
      it "returns a discrepancies array" do
        post :compare,
          params: {
            files: [
              fixture_file_upload('CSV1.csv'),
              fixture_file_upload('CSV2.csv'),
              fixture_file_upload('CSV3.csv')
              ]
            }
        not_empty = JSON.parse(response.body)['data'].size > 0
        expect(not_empty).to eq(true)
      end
    end

    it 'formats strings and returns true' do
      @files = FilesController.new
      result = @files.instance_eval{
        equal_values?(
          :channel_ownership,
          "http://www.youtube.com/channel/UCe09gaA8UCiamw0RQaHuHJw",
          "UCe09gaA8UCiamw0RQaHuHJw"
          )
        }
      expect(result).to eq(true)
    end

    it 'formats strings and returns false' do
      @files = FilesController.new
      result = @files.instance_eval{
        equal_values?(
          :channel_ownership,
          "http://www.youtube.com/channel/UCe09gaA8UCiamw0RQaHuHJw123",
          "UCe09gaA8UCiamw0RQaHuHJw"
          )
        }
      expect(result).to eq(false)
    end

    it 'formats numbers and returns true' do
      @files = FilesController.new
      result = @files.instance_eval{
        equal_values?(
          :subscriber_count,
          "1,922",
          1922
          )
        }
      expect(result).to eq(true)
    end

    it 'formats numbers and returns false' do
      @files = FilesController.new
      result = @files.instance_eval{
        equal_values?(
          :subscriber_count,
          "1,922",
          2291
          )
        }
      expect(result).to eq(false)
    end
  end
end
