//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// remember to remove unnecessary imports and its use when deploying your smart contract
import "hardhat/console.sol";

interface IERC20Token {
    function transfer(address, uint256) external returns (bool);

    function approve(address, uint256) external returns (bool);

    function transferFrom(address, address, uint256) external returns (bool);

    function totalSupply() external view returns (uint256);

    function balanceOf(address) external view returns (uint256);

    function allowance(address, address) external view returns (uint256);

    event Transfer(address indexed from, address indexed to, uint256 value);

    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );
}

/**
 * @title PredictionMarket
 * @dev Implements the main logic of the prediction market
 * has struct MarketEvent which is the object that bettors will bet on
 * has struct Bet which is the object that bettors will use to bet
 * has methods to create a market event, bet on a market event, and close a market event
 * has methods to get the total amount of bets, get the total amount of bets for a market event, and get the total amount of bets for a market event and a bettor
 * has methods to calculate odds for a market event, calculate odds for a market event and a bettor, and calculate the payout for a market event and a bettor
 */

contract PredictionMarket {
    address internal cUsdTokenAddress = 0x874069Fa1Eb16D44d622F2e0Ca25eeA172369bC1;

    uint internal marketEventsLength = 0;
    uint internal betsLength = 0;

    // struct for a market event
    struct MarketEvent {
        string title;
        uint256 createdAt;
        string category;
        address payable creator;
        Option[] options;
        bool isOpen;
        uint volume;
        uint totalBets;
        uint totalCreditsRedeemed;
        string outcome;
    }

    // struct for options for a market event - should have name, odds, and total bets
    struct Option {
        string name;
        uint odds;
        uint totalBets;
        uint volume;
    }

    // event for when a market event is created
    event MarketEventCreated(
        string title,
        uint256 createdAt,
        string category,
        address creator
    );

    // struct for a bet
    struct Bet {
        uint amount;
        uint optionIndex;
        uint256 createdAt;
        address payable bettor;
        uint creditsRedeemed;
        uint marketEventId;
    }

    // event for when a bet is placed
    event BetPlaced(
        uint amount,
        uint optionIndex,
        uint256 createdAt,
        address bettor,
        uint creditsRedeemed,
        uint marketEventId
    );

    mapping(uint => MarketEvent) public marketEvents;
    // MarketEvent[] public marketEvents;

    mapping(uint => Bet) public bets;

    function getMarketEventsLength() public view returns (uint) {
        return marketEventsLength;
    }

    function getBetsLength() public view returns (uint) {
        return betsLength;
    }

    // validate when creating a market event
    function validateData(
        string memory title,
        string memory category,
        string[] memory options
    ) internal pure returns (bool) {
        require(bytes(title).length > 0, "Title is required");
        require(bytes(category).length > 0, "Category is required");
        require(options.length > 0, "Options are required");
        return true;
    }

    // create a market event
    function createMarketEvent(
        string memory title,
        string memory category,
        string[] memory _options
    ) public {
        require(validateData(title, category, _options), "Invalid data");
        uint256 createdAt = block.timestamp;

        MarketEvent storage marketEvent = marketEvents[marketEventsLength];

        marketEvent.title = title;
        marketEvent.createdAt = createdAt;
        marketEvent.category = category;
        marketEvent.creator = payable(msg.sender);
        marketEvent.isOpen = true;
        marketEvent.volume = 0;
        marketEvent.totalBets = 0;
        marketEvent.totalCreditsRedeemed = 0;
        marketEvent.outcome = "";

        // Add options to the market event
        for (uint256 i = 0; i < _options.length; i++) {
            Option memory option = Option(_options[i], 0, 0, 0);
            marketEvent.options.push(option);
        }

        emit MarketEventCreated(title, createdAt, category, msg.sender);

        marketEventsLength++;
    }

    // function to get a market event
    function getMarketEvent(
        uint marketEventId
    ) public view returns (MarketEvent memory) {
        return marketEvents[marketEventId];
    }

    // function to get all market events
    function getMarketEvents() public view returns (MarketEvent[] memory) {
        MarketEvent[] memory _marketEvents = new MarketEvent[](
            marketEventsLength
        );
        for (uint i = 0; i < marketEventsLength; i++) {
            _marketEvents[i] = marketEvents[i];
        }
        return _marketEvents;
    }

    // function to get all bets for a market event

    // function to place a bet - requires a market event id, the amount to bet, and the option index to bet on
    function placeBet(
        uint marketEventId,
        uint amount,
        uint optionIndex,
        uint creditsRedeemed
    ) public payable {
        // first check if the market event is open
        require(marketEvents[marketEventId].isOpen, "Market event is closed");
        // check if the option index is valid
        require(
            optionIndex < marketEvents[marketEventId].options.length,
            "Invalid option"
        );
        // check if the amount is greater than 0
        require(amount > 0, "Amount must be greater than 0");
        // check if the amount is less than or equal to the balance of the bettor
        require(
            IERC20Token(cUsdTokenAddress).balanceOf(msg.sender) >= amount,
            "Insufficient balance"
        );
        // check that the bettor is not the creator of the market event
        require(
            msg.sender != marketEvents[marketEventId].creator,
            "Creator cannot bet"
        );

        // transfer the amount from the bettor to the contract
        require(
            IERC20Token(cUsdTokenAddress).transferFrom(
                msg.sender,
                address(this),
                amount
            ),
            "Transfer failed"
        );

        // update the market event
        MarketEvent storage marketEvent = marketEvents[marketEventId];
        marketEvent.volume += amount;
        marketEvent.totalBets += 1;
        marketEvent.options[optionIndex].totalBets += 1;
        marketEvent.options[optionIndex].volume += amount;

        // create the bet
        Bet storage bet = bets[betsLength];
        bet.amount = amount;
        bet.optionIndex = optionIndex;
        bet.createdAt = block.timestamp;
        bet.bettor = payable(msg.sender);
        bet.creditsRedeemed = creditsRedeemed;
        bet.marketEventId = marketEventId;

        emit BetPlaced(
            amount,
            optionIndex,
            block.timestamp,
            msg.sender,
            creditsRedeemed,
            marketEventId
        );

        betsLength++;
    }

    // function to complete event - calculate winners and transfer cUSD to winners
    function completeEvent(uint marketEventId, uint outcome) public payable {
        require(marketEvents[marketEventId].isOpen, "Market event is closed");
        // outcome should be the index of the winning option
        require(
            outcome < marketEvents[marketEventId].options.length,
            "Invalid outcome"
        );

        MarketEvent storage marketEvent = marketEvents[marketEventId];

        marketEvent.isOpen = false;

        // first find the total bets for the winning option
        // loop through bets and find the bets where marketEventId = marketEventId and optionIndex = outcome
        // for each bet, calculate the percentage of amount to transfer to the bettor based on the odds

        for (uint i = 0; i < betsLength; i++) {
            if (
                bets[i].optionIndex == outcome &&
                bets[i].marketEventId == marketEventId
            ) {
                // calculate the amount to transfer to the bettor - deduct 1% for the house
                uint amountToTransfer = (((bets[i].amount /
                    marketEvent.options[outcome].volume) * marketEvent.volume) *
                    99) / 100;

                // transfer the amount to the bettor
                require(
                    IERC20Token(cUsdTokenAddress).transferFrom(
                        marketEvent.creator,
                        bets[i].bettor,
                        amountToTransfer
                    ),
                    "Transfer failed"
                );
            }
        }

        // update the market event
        marketEvent.outcome = marketEvent.options[outcome].name;
    }
}

0xdC70764360Ad6c50756059b840B24a86923ae545

0xb4161ebf8f170c033fb75b426e660520d48850df