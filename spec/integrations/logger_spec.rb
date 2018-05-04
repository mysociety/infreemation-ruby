# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'logger' do
  it 'must output log message to logger' do
    expect do
      Infreemation.logger = Logger.new($stdout)
      Infreemation.log(:info, 'TEST LOG')
    end.to output(/TEST LOG/).to_stdout
  end
end
