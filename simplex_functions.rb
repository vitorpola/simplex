#cria uma matrix identidade 
def create_matrix_identity(size)
   m = Array.new #inicializar um array
   for i in 0..size-1 do
      m[i] = Array.new #inicializar um array dentro de um array
      for j in 0..size-1 do
         m[i].push(i == j ? 1.0 : 0.0)
      end   
   end
   m
end

#printar matrix com destaque nos parametros passados
def print_matrix(m, row = nil, col = nil, rbold = nil)
   print "\n"
   for i in 0..m.size-1
      print "|\t"
      for j in 0..m[i].size-1
         n = m[i][j]
         if n.is_a? Numeric
            n = n.round(2)
            #n = n.to_r.rationalize(Rational('0.005')) #printar em fração
            #n = n.numerator if n.denominator == 1

            if row==i&&col==j
               print n.to_s.reverse_color
            elsif rbold == i
               print n.to_s.bold.bg_blue
            else
               print n
            end
         else
            print n
         end
         print "\t" 
      end
      puts "|"
   end
   print "\n"
end

# une as matrizes de entrada e a identidade
def join_matrix(m_input, m_id)
   m_result = Array.new
   n_cols = m_input[0].size
   nc_id = m_id[0].size
   for i in 0..nc_id-1
      m_result[i] = Array.new
      m_result[i][0] = m_id[i][0]
   end
   for i in 0..m_input.size-1
      for j in 0..m_input[0].size - 2
         m_result[i][j+1] = m_input[i][j]
      end
      m_result[i][n_cols+nc_id-1] = m_input[i][n_cols-1]
   end
   for i in 0..m_id.size-1
      for j in 1..m_id[0].size - 1
         m_result[i][j+n_cols-1] = m_id[i][j]
      end
   end
   for i in 0..nc_id-1

      m_result[i].unshift( i==0? 'Z' : 'X'+ (i+n_cols-1).to_s)
   end
   m_result

end

#encontra o menor da primeira linha da matriz, retorna [menor num, indice coluna]
def find_lower_negative(m)
   lower = 0
   col = -1
   for j in 1..m[0].size-2
      if lower > m[0][j] #|| (lower == m[0][j] && lower != 0)
         lower = m[0][j]
         col = j 
      end
   end  
   col
end

# encontra o pivo e retorna a linha onde esta localizado
def find_pivot(col, m)
   aux = 999999
   row = 0
   num_cols = m[0].size
   init = m[0][0] == 'z' ? 1:2
   for i in init..m.size-1
      div = (m[i][col] != 0) ? (m[i][num_cols-1] / m[i][col]) : -1
      if div < aux && div >= 0
         aux = div
         row = i 
      end
   end
   m[row][0] = 'X' + (col).to_s
   print "Encontrar o pívot =>  m[#{row}][#{col}] = #{m[row][col]}".italic.blue
   row
end

# dividir todas celulas da linha pelo valor do pivot
def divide_line_by(i,pivot, m)
   for j in 1..m[0].size-1
      m[i][j] /= pivot.to_f
   end
   print "Dividir L#{i} por #{pivot}".italic.blue   
   m
end

# executa o escalonamento na linhas diferentes a do pivot
def execute(m,row,col)
   for i in 0..m.size-1
      aux = m[i][col] 
      if aux != 0
         for j in 1..m[0].size-1
            if i != row 
               m[i][j] -= (aux * m[row][j]).to_f
               m[i][j] = 0 if m[i][j] > -0.001 && m[i][j] < 0.001
            end            
         end
         if i != row 
            print "L#{i} = L#{i}-#{aux<0 ? '('+aux.to_s+')': aux}L#{row} \n".italic.blue
            #print_matrix(m,row,col, i)
         end            
      end
   end
   m
end

#encontra a solução e imprime
def show_solution(m)
   n_rows = m.size
   n_vars = m[0].size - n_rows
   print "\nMELHOR SOLUÇÃO:\n".bold
   puts "Z = #{m[0][m[0].size-1].abs.round(2).to_s}".bold.green
   for v in 1..n_vars-1
      for i in 1..n_rows-1
         if m[i][0] == 'X'+v.to_s
            puts "X#{v} = #{m[i][m[0].size-1].round(4).to_s}".bold.green
            i=0
            break
         end
      end
      puts "X#{v} = 0.0".bold.green if i == n_rows-1            
   end
   print "\n"
end

# captura a entrada digitada pelo usuario
def get_input
   print "                                                    \n"
   print "Para inserir a entrada, siga este exemplo:          \n".bold
   print " __________________________________________________ \n".italic
   print "| SISTEMA            | ENTRADA                     |\n".italic
   print "|  Z: -5x - 2y =  0  |                             |\n".italic
   print "|      1x      <= 3  |  -5,-2,0;1,0,3;0,1,4;1,2,9  |\n".italic
   print "|           1y <= 4  |                             |\n".italic
   print "|      1x + 2y <= 9  |                             |\n".italic
   print " ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾ \n".italic
   print "\nAgora insira a sua entrada:".bold.underline
   input = gets.chomp.split(';').collect{|x|x.split(',').collect{|x| x.to_i}}
   input
end

#Alterar cores no console
class String
   def green;          "\e[32m#{self}\e[0m" end
   def blue;           "\e[34m#{self}\e[0m" end
   def gray;           "\e[37m#{self}\e[0m" end
   def bg_blue;        "\e[44m#{self}\e[0m" end
   def bold;           "\e[1m#{self}\e[22m" end
   def italic;         "\e[3m#{self}\e[23m" end
   def underline;      "\e[4m#{self}\e[24m" end
   def reverse_color;  "\e[7m#{self}\e[27m" end
end