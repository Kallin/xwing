# frozen_string_literal: true

require 'rails_helper'
require './lib/catalog/importer'

RSpec.describe Catalog::Importer do
  let(:importer) { described_class.new }

  it 'is able to refresh without erroring out' do
    expect { importer.refresh_all }.not_to raise_error
  end
end
