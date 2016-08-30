require_relative 'spec_helper.rb'
require_relative '../quicksort.rb'

require 'json'

describe QuickSort do
  # arrays for known count tests
  before :each do
    @inputs = JSON.parse(File.read("#{File.dirname(__FILE__)}/arrays.json"))
    @qs = QuickSort.new
  end

  it 'determines max correctly' do
    expect(@qs.max(1, 2)).to eq(2)
    expect(@qs.max(2, 2)).to eq(2)
    expect(@qs.max(2, 1)).to eq(2)
  end

  it 'determines min correctly' do
    expect(@qs.min(1, 2)).to eq(1)
    expect(@qs.min(2, 2)).to eq(2)
    expect(@qs.min(2, 1)).to eq(1)
  end

  # a few of the problem medians during dev
  it 'determines median correctly' do
    @qs.array = @inputs['10']
    expect(@qs.get_median(8, 8, 9)).to eq(8)
    @qs.array = [995, 998, 996]
    expect(@qs.get_median(0, 1, 2)).to eq(2)
    @qs.array = [57, 55, 29]
    expect(@qs.get_median(0, 1, 2)).to eq(1)
  end

  it 'defaults to an empty array' do
    @qs.sort
    expect(@qs.array).to eq([])
  end

  it 'sets an array' do
    @qs.array = [0, 1, 2]
    expect(@qs.array).to eq([0, 1, 2])
  end

  %w{first last median random}.each do |t|
    it 'sets pivot type of #{t}' do
      @qs.pivot_type = t
      expect(@qs.pivot_type).to eq(t)
    end
  end

  %w{first last median random}.each do |t|
    it 'sorts an array with pivot type of #{t}' do
      @qs.pivot_type = t
      @qs.array = [3,2,5,4]
      @qs.sort
      expect(@qs.array).to eq([2,3,4,5])
    end
  end

  # default
  it 'returns empty array if array is empty' do
    @qs.sort
    expect(@qs.array).to eq([])
  end

  it 'returns nil if array is nil' do
    @qs.array = nil
    @qs.sort
    expect(@qs.array).to eq(nil)
  end

  it 'sorts an array' do
    @qs.array = [3,2,5,4]
    @qs.sort
    expect(@qs.array).to eq([2,3,4,5])
  end

  it 'counts the comparisons while sorting an array' do
    @qs.array = [3,2,5,4]
    @qs.sort
    expect(@qs.count).to eq(4)
  end

  # Test a bunch of array sorts with known comparison counts
  it 'counts comparisons in sorting an array of 10 with first pivot' do
    @qs.array = @inputs['10']
    @qs.pivot_type = 'first'
    @qs.sort
    expect(@qs.count).to eq(25)
  end

  it 'counts comparisons in sorting an array of 100 with first pivot' do
    @qs.array = @inputs['100']
    @qs.pivot_type = 'first'
    @qs.sort
    expect(@qs.count).to eq(615)
  end

  it 'counts comparisons in sorting an array of 1000 with first pivot' do
    @qs.array = @inputs['1000']
    @qs.pivot_type = 'first'
    @qs.sort
    expect(@qs.count).to eq(10297)
  end

  it 'counts comparisons in sorting an array of 10 with last pivot' do
    @qs.array = @inputs['10']
    @qs.pivot_type = 'last'
    @qs.sort
    expect(@qs.count).to eq(29)
  end

  it 'counts comparisons in sorting an array of 100 with last pivot' do
    @qs.array = @inputs['100']
    @qs.pivot_type = 'last'
    @qs.sort
    expect(@qs.count).to eq(587)
  end

  it 'counts comparisons in sorting an array of 1000 with last pivot' do
    @qs.array = @inputs['1000']
    @qs.pivot_type = 'last'
    @qs.sort
    expect(@qs.count).to eq(10184)
  end

  it 'counts comparisons in sorting an array of 10 with median pivot' do
    @qs.array = @inputs['10']
    @qs.pivot_type = 'median'
    @qs.sort
    expect(@qs.count).to eq(21)
  end

  it 'counts comparisons in sorting an array of 100 with median pivot' do
    @qs.array = @inputs['100']
    @qs.pivot_type = 'median'
    @qs.sort
    expect(@qs.count).to eq(518)
  end

  it 'counts comparisons in sorting an array of 1000 with median pivot' do
    @qs.array = @inputs['1000']
    @qs.pivot_type = 'median'
    @qs.sort
    expect(@qs.count).to eq(8921)
  end
end
