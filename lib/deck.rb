class Deck
  attr_accessor :cards
  def initialize(*cards)
    @cards = cards
  end

  def count
    cards.count
  end

  ## ==========
  # bubble sort and helper methods
  ## ==========

  def sort(sort_direction = {reverse: false})
    sorted = false
    until sorted
      cards_duplicate = cards.dup
      n = cards.length
      (n-1).times do |i|
        if sort_direction[:reverse]
          check_for_swap(i, true)
        else
          check_for_swap(i)
        end
      end
      sorted = true if cards_duplicate == cards
    end
  end

  def check_for_swap(i, reverse = false)
    if reverse
      if cards[i] < cards[i+1]
        cards[i], cards[i+1] = cards[i+1], cards[i]
      end
    else
      if cards[i+1] < cards[i]
        cards[i], cards[i+1] = cards[i+1], cards[i]
      end
    end
  end

  ## ==========
  # merge sort and helper methods
  ## ==========

  def merge_sort(direction = {reverse: false})
    return "Use another method" if @cards.length < 3
    array_a, array_b, sorted = [], [], []

    until @cards.empty?
      n = @cards.length
      if n >= 4
        array_a, array_b = split_array(@cards, direction)
        sorted = push_or_merge_to_sorted(sorted, array_a, array_b, direction)
      elsif n == 3
        array_a = sort_array(@cards.slice!(0, 2), direction)
        array_b = @cards[0]
        sorted = push_or_merge_to_sorted(sorted, array_a, array_b, direction)
      elsif n == 2
        array_a = sort_array(@cards, direction)
        sorted = sort_into_one(sorted.flatten, array_a, direction)
      else
        sorted = sort_into_one(sorted.flatten, @cards, direction)
      end
    end

    @cards = sorted.flatten
  end

  def push_or_merge_to_sorted(sorted, array_a, array_b, direction)
    if sorted.empty?
      sorted << sort_into_one(array_a, array_b, direction)
    else
      new_sorted = sort_into_one(array_a, array_b, direction)
      sorted = sort_into_one(sorted.flatten, new_sorted.flatten, direction)
    end
    sorted
  end

  def sort_into_one(array_a, array_b, direction)
    sorted = []

    until array_a.empty? || array_b.empty?
      if direction[:reverse]
        if array_a[0] >= array_b[0]
          sorted.push(array_a.slice!(0,1))
        else
          sorted.push(array_b.slice!(0,1))
        end
      else
        if array_a[0] <= array_b[0]
          sorted.push(array_a.slice!(0,1))
        else
          sorted.push(array_b.slice!(0,1))
        end
      end
    end

    remaining_array = array_a.empty? ? array_b : array_a


    if remaining_array.length > 2
      sorted.push(merge_sort(remaining_array, direction))
    elsif remaining_array.length == 2
      sorted.push(sort_array(remaining_array, direction))
    elsif remaining_array.length == 1
      sorted.push(remaining_array.slice!(0,1))
    end


    sorted.flatten
  end

  def split_array(array, direction)
    array_a = sort_array(array.slice!(0,2), direction)
    array_b = sort_array(array.slice!(0,2), direction)
    return array_a, array_b
  end

  def sort_array(array, direction)
    sorted = []
    if direction[:reverse]
      if array[0] >= array[1]
        sorted[0], sorted[1] = array[0], array[1]
      else
        sorted[0], sorted[1] = array[1], array[0]
      end
    else
      if array[0] <= array[1]
        sorted[0], sorted[1] = array[0], array[1]
      else
        sorted[0], sorted[1] = array[1], array[0]
      end
    end
    sorted
  end
end
