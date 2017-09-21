load 'simplex_functions.rb'

#show_instructions
#input = gets.chomp.split(';').collect{|x|x.split(',').collect{|x| x.to_i}}
#input = [[-5,-2,0],[1,0,3], [0,1,4], [1,2,9]]
input = [[-100,-150,0],[2,3,120],[1,0,40], [0,1,30]]
mi = create_matrix_identity(input.size)
mr = join_matrix(input, mi)
print_matrix(input)
print_matrix(mi)
print_matrix(mr)

print "\nMontar tabela".italic.blue
print_matrix(mr)

col = find_lower_negative(mr)
while col != -1
   row = find_pivot(col, mr)
   print_matrix(mr,row,col)
   if mr[row][col] > 1      
      mr = divide_line_by(row,mr[row][col], mr) 
      print_matrix(mr,row,col, row)
   end
   mr = execute(mr,row,col)
   col = find_lower_negative(mr)
end
print "Tabela Final".italic.blue
print_matrix(mr)
show_solution(mr)