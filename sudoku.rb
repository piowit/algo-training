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
sudoku_str_easy = '230415068080236519160987234317094025458120697926058301000500102000842903592371486'

# each_slice
# str: 0 -> [0][0]
# str: 8 -> [0][8]
# str: 9 -> [1][0]
# str: 21 -> [2][4]
# y = row
# x = col
# arr = str.scan /.{1,9}/ https://stackoverflow.com/questions/21081955/how-can-i-split-a-string-into-chunks

# possible_values = [1,2,3,4,5,6]
# possible_values - check_column
# check_column_w - [1,2,3,4,5,6]
# check_row_w - [1,4,5,7,8,9]
# check_square_w - [2,4,5,6,7,8]
# check_column & check_row & check_square

class SudokuSolver
  def initialize(sudoku_str)
    @sudoku_arr = sudoku_str.split('').map(&:to_i).each_slice(9).to_a
  end

  def display
    (0...@sudoku_arr.size).each do |row|
      (0...@sudoku_arr[row].length).each do |col|
        print @sudoku_arr[row][col]
      end
      puts
    end
  end

  def display_nicely
    puts '---+---+---'
    (0...@sudoku_arr.size).each do |row|
      (0...@sudoku_arr[row].length).each do |col|
        if col != 0 && (col % 3).zero?
          print "|#{@sudoku_arr[row][col]}"
        else
          print @sudoku_arr[row][col]
        end
      end
      puts
      puts '---+---+---' if [2, 5, 8].include?(row)
    end
  end

  def row_valid?(row_index)
    @sudoku[row_index].sort == [1, 2, 3, 4, 5, 6, 7, 8, 9]
  end

  def check_row_w(row)
    result = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    @sudoku_arr[row].each do |number|
      result.delete(number)
    end
    result
  end

  def check_column_w(col)
    result = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    (0..8).each do |i|
      result.delete(@sudoku_arr[i][col])
      return result if result.size == 1
    end
    result
  end

  def check_block_w(row, col)
    result = [1, 2, 3, 4, 5, 6, 7, 8, 9]

    start_row = row / 3 * 3
    start_col = col / 3 * 3
    (start_row..start_row + 2).each do |y|
      (start_col..+2).each do |x|
        result.delete(@sudoku_arr[y][x])
        return result if result.size == 1
      end
    end
    result
  end

  def solve_sudoku_w
    until solved?
      (0..8).each do |row|
        (0..8).each do |col|
          next unless @sudoku_arr[row][col].zero?

          common_numbers_check = check_row_w(row) &
                                 check_column_w(col) &
                                 check_block_w(row, col)

          puts "row:#{row},col:#{col},#{common_numbers_check}"
          @sudoku_arr[row][col] = common_numbers_check[0] if common_numbers_check.length == 1
        end
      end
    end
  end

  def solved?
    (0..8).each do |row|
      (0..8).each do |col|
        return false if @sudoku_arr[row][col].zero?
      end
    end
    true
  end
end

sudoku_solver = SudokuSolver.new(sudoku_str_easy)
puts
sudoku_solver.display_nicely
sudoku_solver.solve_sudoku_w
sudoku_solver.display_nicely
