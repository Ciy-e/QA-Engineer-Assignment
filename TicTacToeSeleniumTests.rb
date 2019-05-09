require 'test/unit'
require 'selenium-webdriver'


# Test case where X wins.
class TicTacToeXWinsTest < Test::Unit::TestCase

    def setup
        @driver=Selenium::WebDriver.for :chrome
        @driver.manage.window.maximize
        @driver.navigate.to "https://codepen.io/jshlfts32/full/bjambP/"
        wait = Selenium::WebDriver::Wait.new(:timeout => 10)
        wait.until { @driver.find_element(:id,'result') }
    end

    def test_x_wins
        @driver.switch_to.frame @driver.find_element(:class, 'result-iframe')

        gameSizeField = @driver.find_element(:id,'number')
        gameStartButton = @driver.find_element(:id,'start')

        gameSizeField.send_keys(3)
        gameStartButton.click()

        gameBoard = @driver.find_elements(:tag_name, 'td')

        # Tic Tac Toe moves for this board
        # X X X
        # O O
        #
        gameBoard[0].click()
        gameBoard[3].click()
        gameBoard[1].click()
        gameBoard[4].click()
        gameBoard[2].click()

        gameOverMessage = @driver.find_element(:id, 'endgame').text
        assert(gameOverMessage.include? "Congratulations player X! You've won. Refresh to play again!")


    end

    def teardown
        @driver.quit
    end
end

# Test case where O wins.
class TicTacToeOWinsTest < Test::Unit::TestCase

    def setup
        @driver=Selenium::WebDriver.for :chrome
        @driver.manage.window.maximize
        @driver.navigate.to "https://codepen.io/jshlfts32/full/bjambP/"
        wait = Selenium::WebDriver::Wait.new(:timeout => 10)
        wait.until { @driver.find_element(:id,'result') }
    end

    def test_o_wins
        @driver.switch_to.frame @driver.find_element(:class, 'result-iframe')

        gameSizeField = @driver.find_element(:id,'number')
        gameStartButton = @driver.find_element(:id,'start')

        gameSizeField.send_keys(3)
        gameStartButton.click()

        gameBoard = @driver.find_elements(:tag_name, 'td')

        # Tic Tac Toe moves for this board
        # X X 
        # O O O
        # X

        gameBoard[0].click()
        gameBoard[3].click()
        gameBoard[1].click()
        gameBoard[4].click()
        gameBoard[6].click()
        gameBoard[5].click()

        gameOverMessage = @driver.find_element(:id, 'endgame').text
        assert(gameOverMessage.include? "Congratulations player O! You've won. Refresh to play again!")

    end



    def teardown
        @driver.quit
    end
end


# Test that the board is cleared away when page is refreshed.
class GameBoardIsClearedOutOnRefreshTest < Test::Unit::TestCase

    def setup
        @driver=Selenium::WebDriver.for :chrome
        @driver.manage.window.maximize
        @driver.navigate.to "https://codepen.io/jshlfts32/full/bjambP/"
        wait = Selenium::WebDriver::Wait.new(:timeout => 10)
        wait.until { @driver.find_element(:id,'result') }
    end

    def test_board_clears_on_refresh
        @driver.switch_to.frame @driver.find_element(:class, 'result-iframe')

        gameSizeField = @driver.find_element(:id,'number')
        gameStartButton = @driver.find_element(:id,'start')

        gameSizeField.send_keys(3)
        gameStartButton.click()

        beforeRefresh = @driver.find_elements(:tag_name, 'td')
        @driver.navigate.refresh
        wait = Selenium::WebDriver::Wait.new(:timeout => 10)
        wait.until { @driver.find_element(:id,'result') }
        @driver.switch_to.frame @driver.find_element(:class, 'result-iframe')

        afterRefresh = @driver.find_elements(:tag_name, 'td')

        assert(beforeRefresh.any?)
        assert(afterRefresh.any? == false)

    end


    def teardown
        @driver.quit
    end
end

# Test that the board is created by the play button, uses a default of 3 and asserts that there are 9 cells on the game board.
class TestPlayButtonCreatesBoard < Test::Unit::TestCase

    def setup
        @driver=Selenium::WebDriver.for :chrome
        @driver.manage.window.maximize
        @driver.navigate.to "https://codepen.io/jshlfts32/full/bjambP/"
        wait = Selenium::WebDriver::Wait.new(:timeout => 10)
        wait.until { @driver.find_element(:id,'result') }
    end

    def test_play_button_creates_board
        @driver.switch_to.frame @driver.find_element(:class, 'result-iframe')

        gameSizeField = @driver.find_element(:id,'number')
        gameStartButton = @driver.find_element(:id,'start')

        gameSizeField.send_keys(3)
        gameStartButton.click()

        gameBoard = @driver.find_elements(:tag_name, 'td')
        assert(gameBoard.any?)
        assert(gameBoard.count == 9)

        
    end

    def teardown
        @driver.quit
    end
end