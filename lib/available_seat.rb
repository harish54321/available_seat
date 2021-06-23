require 'json'
require 'byebug'

class AvailableSeat
  attr_accessor :input, :number_of_seats

  def initialize(input, number_of_seats)
    @available_seats = JSON.parse(input)
    @number_of_seats = number_of_seats
  end

  def number_of_available_seats
    # Getting Number of rows and columns from input json
    number_of_rows = @available_seats["venue"]["layout"]["rows"]
    number_of_columns = @available_seats["venue"]["layout"]["columns"]
    # Create an array of Hashes of total seating capacity
    arrangment_hash = []
    array_rows = 'a'.upto('j').to_a
    number_of_rows.times do |r|
      rows_hash = {}
      alphabet = array_rows[r]
      number_of_columns.times do |c|
        rows_hash[alphabet+(c + 1).to_s] = "A"
      end
      arrangment_hash << rows_hash
    end
    # update seat availability/Occupied status from input json
    @available_seats["seats"].keys.each do |l|
      key = @available_seats["seats"].select {|n| n[l]}
      arrangment_hash.select{|m| m[l] }.first[l] = key[l]["status"]
    end if @available_seats["seats"].keys.any?
    @result = []
    # Find and Assign best possible seats
    @result << find_best_seats(arrangment_hash, number_of_columns)
    @result.compact
  end
  # To find best seats from row and from center position.
  def find_best_seats(arrangment_hash, columns)
    center_seat = columns/2
    alloted_seat = nil
    arrangment_hash.each do |l|
      row = l.keys.first.split("", 2)
      @number_of_seats.times do |m|
        # If row has eeven single unavailable seat
        if l.values.include? ("O")
          # Loop trough seats
          loop_through_center(l, center_seat)
          break if @number_of_seats == 0
        else
          # If all the seats in row is available then allot center seat
          l[row.first + center_seat.to_s] = "O"
          @number_of_seats -= 1
          @result << "Alloted seat is #{row.first + center_seat.to_s}"
          break if @number_of_seats == 0
        end
      end
    end
    puts arrangment_hash
  end
  # Allotement of seats from center
  def loop_through_center(r, seat)
    add = 0
    delete = 0
    row = r.keys.first.split("", 2)[0]
    r.length.times.each do |l|
      if l%2 == 0
        add = add + 1
        if r[row+(seat + add ).to_s] == "A"
          r[row+(seat + add ).to_s] = "O"
          @result << "Alloted seat is #{row+(seat + add ).to_s}"
          @number_of_seats -= 1
          break if @number_of_seats == 0
        end
      else
        delete = delete - 1
        if r[row+(seat + delete ).to_s] == "A"
          r[row+(seat + delete ).to_s] = "O"
          @result << "Alloted seat is #{row+(seat + delete ).to_s}"
          @number_of_seats -= 1
          break if @number_of_seats == 0
        end
      end
    end
  end
end
