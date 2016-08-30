# Implement a class for the quicksort algorithm, rather than monkey patching Array
class QuickSort
  attr_accessor :array
  attr_reader :count
  attr_accessor :pivot_type

  def initialize
    @array = []
    @pivot_type = 'first'
    @count = 0
  end

  def max(a, b)
    a >= b ? a : b
  end

  def min(a, b)
    a <= b ? a : b
  end

  # get median of values from 3 array indices
  def get_median(l, m, r)
    # kind of a shitty way to get the index back from the greatest of the values
    med_vals = Hash.new
    med_vals[@array[l]] = l
    med_vals[@array[m]] = m
    med_vals[@array[r]] = r

    # has to be sorted first
    med_qs = QuickSort.new
    med_qs.array = [@array[l], @array[m], @array[r]]
    med_qs.sort
    val = max(min(med_qs.array[0], med_qs.array[1]), max(min(med_qs.array[1], med_qs.array[2]), med_qs.array[0]));
    return med_vals[val]
  end

  def choose_pivot(l, r)
    if @pivot_type == 'first'
      l
    elsif @pivot_type == 'last'
      r
    elsif @pivot_type == 'random'
      rand(l..r)
    elsif @pivot_type == 'median' # median of three method
      length = (r - l) + 1
      if length % 2 == 1
        m = l + (length / 2)
      else
        m = l + (length / 2) - 1
      end
      med = get_median(l, m, r)
      return med
    else
      raise "Invalid pivot type: #{@pivot_type}"
    end
  end

  def partition(l, r)
    p = choose_pivot(l, r)
    pval = @array[p]
    if p > l
      # We use first for pivot location, so swap to that setup now
      @array[p] = @array[l]
      @array[l] = pval
    end
    i = l + 1
    (i..r).each do |j|
      if @array[j] < pval
        tempval = @array[i]
        @array[i] = @array[j]
        @array[j] = tempval
        i += 1
      end
    end
    # move pivot to it's location
    @array[l] = @array[i - 1]
    @array[i - 1] = pval
    return i - 1
  end

  def quicksort(l, r)
    if l < r
      @count += r - l
      p = partition(l, r)
      quicksort(l, p - 1)
      quicksort(p + 1, r)
    end
  end

  def sort()
    if !@array or @array == []
      return @array
    end
    quicksort(0, @array.length - 1)
  end
end
