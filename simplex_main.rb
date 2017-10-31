load 'simplex_functions.rb'

# case ARGV[0]
#    when '1'
#       input = [[-5,-2,0],[1,0,3], [0,1,4], [1,2,9]] #EXERCICIO 01
#    when '2'
#       input = [[-1,-2,0], [-1,3,6], [1,-1,2]] #EXERCICIO 02
#    when '3'
#       input  = [[2,-4,0],[-1,2,2],[1,1,7]] # EXERCICIO 03
#    when '4'
#       input = [[-4,-5,-9,-11,0],[1,1,1,1,15],[7,5,3,2,120],[3,5,10,15,100]] #EXERCICIO 04
#    when '5'
#       input = [[-5,-4,-3,0],[2,3,1,5],[4,2,2,11],[3,2,2,8]] #EXERCICIO 05
#    else
#    input = get_input
# end

# mi = create_matrix_identity(input.size)
# mr = join_matrix(input, mi)

# print "\nMontar tabela".italic.blue
# print_matrix(mr)

#      w,z,   x1   ,x2   ,x3   ,x4   ,x5   ,x6   ,x7  ,x8  ,x9  ,x10    ,x11 ,x12  ,x13 ,x14 ,x8',x10',x12',x14',C
 mr = [['w',  -1     ,-1   ,-1   ,-1   ,-1   ,-1    ,0   ,1    ,0   ,1   ,0   ,1    ,0   ,1   ,0    ,0 ,0    ,0   , -0.95  ],
       ['z',  0.3   ,0.2  ,0.28 ,0.5  ,0.2   ,0.25  ,0   ,0    ,0   ,0   ,0   ,0    ,0   ,0   ,0    ,0 ,0    ,0   ,0   ],
       ['x7',  1    ,0    ,0    ,0    ,0.6   ,0.7   ,1   ,0    ,0   ,0   ,0   ,0    ,0   ,0   ,0    ,0 ,0    ,0   ,0.65 ],
       ['x8',  1    ,0    ,0    ,0    ,0.6   ,0.7   ,0   ,-1   ,0   ,0   ,0   ,0    ,0   ,0   ,1    ,0 ,0    ,0   ,0.6  ],
       ['x9',  0    ,1    ,0    ,0    ,0.2   ,0.2   ,0   ,0    ,1   ,0   ,0   ,0    ,0   ,0   ,0    ,0 ,0    ,0   ,0.2  ],
       ['x10',  0   ,1    ,0    ,0    ,0.2   ,0.2   ,0   ,0    ,0   ,-1  ,0   ,0    ,0   ,0   ,0    ,1 ,0    ,0   ,0.15 ],
       ['x11',  0   ,0    ,1    ,0    ,0.2   ,0.05  ,0   ,0    ,0   ,0   ,1   ,0    ,0   ,0   ,0    ,0 ,0    ,0   ,0.2  ],
       ['xx2',  0   ,0    ,1    ,0    ,0.2   ,0.05  ,0   ,0    ,0   ,0   ,0   ,-1   ,0   ,0   ,0    ,0 ,1    ,0   ,0.15 ],
       ['x13',  0   ,0    ,0    ,1    ,0     ,0.05  ,0   ,0    ,0   ,0   ,0   ,0    ,1   ,0   ,0    ,0 ,0    ,0   ,0.08 ],
       ['x14',  0   ,0    ,0    ,1    ,0     ,0.05  ,0   ,0    ,0   ,0   ,0   ,0    ,0   ,-1  ,0    ,0 ,0    ,1   ,0.05 ]]



def simplex(mr)
      col = find_lower_negative(mr)
      while col != -1
            row = find_pivot(col, mr)
            print_matrix(mr,row,col)
            if mr[row][col] != 1.00      
            mr = divide_line_by(row,mr[row][col], mr) 
            print_matrix(mr,row,col, row)
            end
            mr = execute(mr,row,col)
            col = find_lower_negative(mr)
      end
      print "Tabela Final".italic.blue
      print_matrix(mr)
end

#mr = [[ 'w',-3,-2,1,1,0,0,-12], ['z',3,2,0,0,0,0,0], ['x5',1,1,-1,0,1,0,5], ['x6',2,1,0,-1,0,1,7]]

simplex(mr)

mr.delete_at 0
mr.each do |row|
      for j in 1..4
            row.delete_at row.size-2
      end
end

simplex(mr)

show_solution(mr)

