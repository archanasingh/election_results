class ElectionResultsController < ApplicationController
  include ActionController::MimeResponds
  # TODO authenticate request
  before_action :load_result_data
  OVERALL = 'Overall'
  def index
    # TODO: Confirm if requirement is to find overall winner per party or overall winner across parties?
    # Assumption for this implementation is to get overall winner across parties
    # TODO: validate params
    @winners = winners_by_state_and_overall

    render json: @winners
  end

  private

  def load_result_data
    begin
      @data = JSON.parse(File.read('./election_result.json'))
    rescue StandardError => e
      # log error and return generic response
      puts "Failed to parse results file, #{e.message}"
      render json: {}
    end
  end

  def winners_by_state_and_overall
    state_total = {}
    overall_total = {}
    winners = {}

    # total by candidates
    @data.each do |state, counties|
      state_total[state] = {}
      counties.each do |_, parties|
        parties.each do |party, candidates|
          state_total[state][party] ||= {}
          overall_total[party] ||= {}

          candidates.each do |candidate, votes|
            state_total[state][party][candidate] ||= 0
            state_total[state][party][candidate] += votes

            overall_total[party][candidate] ||= 0
            overall_total[party][candidate] += votes
          end
        end
      end
    end

    # Max votes
    state_total.each do |state, parties|
      winners[state] = {}
      parties.each do |party, candidates|
        winners[state][party] = candidates.max_by {|candidate, votes| votes }
      end
    end

    winners['Overall'] = {}
    overall_total.each do |party, candidates|
      winners['Overall'][party] = candidates.max_by {|candidate, votes| votes }
    end

    winners
  end

end