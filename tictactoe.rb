class Player
    attr_reader :name, :position
    def initialize(name, sign)
        @name = name
        @sign = sign
    end
    def get_sign()
        return @sign
    end
    def saying()
        return "It is #{@name}'s turn, #{@sign}\n"
    end
end
class Game
    attr_reader :current_turn, :placements, :switch, :up_coords

    def initialize()
        @current_turn = 1
        @placements = ["0","1","2","3","4","5","6","7","8","9",]
        @switch = 1
        @up_coords = 0
    end
    def board_formatted
        return "#{placements[0]} | #{placements[1]} | #{placements[2]}\n#{placements[3]} | #{placements[4]} | #{placements[5]}\n#{placements[6]} | #{placements[7]} | #{placements[8]}\n"
    end
    def place_sign(coord, sign)
        if @placements[coord] == "X" or @placements[coord] == "O" or coord > 8
            print "Invalid placement, turn forfeited.\n"
        else
            @placements[coord] = sign
        end
        print board_formatted
    end
    def check_won(current_sign)
        winning_combos = 
        [["#{current_sign}","#{current_sign}","#{current_sign}","-","-","-","-","-","-"],
        ["-","-","-","#{current_sign}","#{current_sign}","#{current_sign}","-","-","-"],
        ["-","-","-","-","-","-","#{current_sign}","#{current_sign}","#{current_sign}"],
        ["#{current_sign}","-","-","#{current_sign}","-","-","#{current_sign}","-","-"],
        ["-","#{current_sign}","-","-","#{current_sign}","-","-","#{current_sign}","-"],
        ["-","-","#{current_sign}","-","-","#{current_sign}","-","-","#{current_sign}"],
        ["#{current_sign}","-","-","-","#{current_sign}","-","-","-","#{current_sign}"],
        ["-","-","#{current_sign}","-","#{current_sign}","-","#{current_sign}","-","-"],]
        
        winning_signs = 0
        winning_combos.each do |combo|
            winning_signs = 0
            combo.each_with_index do |area, index|
                if @placements[index] == combo[index]
                    winning_signs += 1
                end 
            end
            if winning_signs >= 3
                print "#{current_sign} won!\n"
                return true
            end 
        end
        return false
    end
    def switch_turn()
        if @switch == 2
            @switch = 1
        elsif @switch == 1
            @switch = 2
        end
    end
    def which_turn()
        return @switch
    end
end

def game_prompt
    print "Player 1 username: "
    username = gets.chomp
    player1 = Player.new(username, "X")
    print "Player 2 username: "
    username = gets.chomp
    player2 = Player.new(username, "O")
    current_game = Game.new()

    print current_game.board_formatted

    while current_game.check_won("X") == false and current_game.check_won("O") == false
        if current_game.which_turn() == 1
            print player1.saying()
            game_input = gets.chomp.to_i
            current_game.place_sign(game_input, player1.get_sign)
        elsif current_game.which_turn() == 2
            print player2.saying()
            game_input = gets.chomp.to_i
            current_game.place_sign(game_input, player2.get_sign)
        end
        current_game.switch_turn()
        break if game_input == 11
    end
end

game_prompt()