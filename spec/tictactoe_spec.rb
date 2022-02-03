require './tictactoe'
describe Game do
    describe "#Xwin" do
        it "x wins" do
            game = Game.new()
            game.place_sign(0, "X")
            game.place_sign(1, "X")
            game.place_sign(2, "X")
            expect(game.check_won("X")).to eql(true)
        end
    end
    describe "#Owin" do
        it "o wins" do
            game = Game.new()
            game.place_sign(0, "O")
            game.place_sign(1, "O")
            game.place_sign(2, "O")
            expect(game.check_won("O")).to eql(true)
        end
    end
end