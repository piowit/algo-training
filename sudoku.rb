# 003|020|600
# 900|305|001
# 001|806|400
# --- --- ---
# 008|102|900
# 700|000|008
# 006|708|200
# --- --- ---
# 002|609|500
# 800|203|009
# 005|010|300

sudoku_str = '003020600900305001001806400008102900700000008006708200002609500800203009005010300'
# each_slice
# str: 0 -> [0][0]
# str: 8 -> [0][8]
# str: 9 -> [1][0]
# str: 21 -> [2][4]

#arr = str.scan /.{1,9}/ https://stackoverflow.com/questions/21081955/how-can-i-split-a-string-into-chunks

class SudokuSolver
  
  def initialize(sudoku_str)
    @sudoku_arr = sudoku_str.split('').map(&:to_i).each_slice(9).to_a
    # print @sudoku_arr
  end

  def display
    (0...@sudoku_arr.size).each do |y|
        (0...@sudoku_arr[y].length).each do |x|
            # print @sudoku_arr[y][x]
            print "[#{x+1}#{y+1}]"
        end
        puts
    end
  end

  def display_nicely
    (0...@sudoku_arr.size).each do |y|
      (0...@sudoku_arr[y].length).each do |x|
        if x != 0 && x%3 == 0
          print "|#{@sudoku_arr[y][x]}"
        else 
          print @sudoku_arr[y][x]
        end
      end
      if y == 2 || y == 5
        puts
        puts '---+---+---'
      else
        puts
      end
    end
  end
  
  def row_valid?(row_index)
      @sudoku[row_index].sort == [1,2,3,4,5,6,7,8,9]
  end

  def check_row_w(y)
    result = [1,2,3,4,5,6,7,8,9]
    @sudoku_arr[y].each do |number|
        if number != 0 
            result.delete(number)
        end
    end
    result
  end

  def check_column_w(x)
    result = [1,2,3,4,5,6,7,8,9]
    (0..8).each do |y|
      result.delete(@sudoku_arr[y][x])
    end
    result
  end

  def check_block_w(x,y)
    result = [1,2,3,4,5,6,7,8,9]
    if x.between?(0,2) && y.between?(0,2)
      (0..2).each do |y|
        (0..2).each do |x|
          result.delete(@sudoku_arr[y][x])
        end
      end
    end
    if x.between?(3,5) && y.between?(0,2)
      (0..2).each do |y|
        (3..5).each do |x|
          result.delete(@sudoku_arr[y][x])
        end
      end
    end
    if x.between?(6,8) && y.between?(0,2)
      (0..2).each do |y|
        (6..8).each do |x|
          result.delete(@sudoku_arr[y][x])
        end
      end
    end
    if x.between?(0,2) && y.between?(3,5)
      (3..5).each do |y|
        (0..2).each do |x|
          result.delete(@sudoku_arr[y][x])
        end
      end
    end
    if x.between?(3,5) && y.between?(3,5)
      
    end
    if x.between?(6,8) && y.between?(3,5)
      
    end
    if x.between?(0,2) && y.between?(6,8)
      (6..8).each do |y|
        (0..2).each do |x|
          result.delete(@sudoku_arr[y][x])
        end
      end
    end
    if x.between?(3,5) && y.between?(6,8)
      
    end
    if x.between?(6,8) && y.between?(6,8)
      
    end

    result
  end

end

# possible_values = [1,2,3,4,5,6]
# possible_values - check_column
# check_column_w - [1,2,3,4,5,6]
# check_row_w - [1,4,5,7,8,9]
# check_square_w - [2,4,5,6,7,8]
# check_column & check_row & check_square

sudoku_solver = SudokuSolver.new(sudoku_str)
puts
sudoku_solver.display_nicely
sudoku_solver.display
print sudoku_solver.check_row_w(0)
print sudoku_solver.check_column_w(3)
print sudoku_solver.check_block_w(3,0)
puts
(0..8).each do |y|
  (0..8).each do |x|
puts "x:#{x},y:#{y},#{sudoku_solver.check_row_w(y) & sudoku_solver.check_column_w(x) & sudoku_solver.check_block_w(x,y)}"
  end
end
print sudoku_solver.check_row_w(6) & sudoku_solver.check_column_w(3) & sudoku_solver.check_block_w(3,6)
