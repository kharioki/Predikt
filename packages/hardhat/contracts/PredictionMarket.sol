//SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

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
    // struct for possible options for a market event - e.g. for a market event "Who will win the 2021 NBA Championship?", the options would be "Lakers", "Nets", "Clippers", etc.
    // struct option {
    //     string name;
    //     uint256 totalBets;
    //     mapping(address => uint256) bets;
    // }
    address internal cUsdTokenAddress =
        0x874069Fa1Eb16D44d622F2e0Ca25eeA172369bC1;
    uint internal marketEventsLength = 0;

    // struct for a market event
    struct MarketEvent {
        string title;
        string description;
        string image;
        uint256 createdAt;
        string category;
        address payable creator;
        string[] options;
        bool isOpen;
        uint256 totalBets;
        uint256 totalCreditsRedeemed;
        uint256 totalBettors;
        uint256 totalWinners;
        uint256 totalCreditsRetired;
    }

    // event for when a market event is created
    event MarketEventCreated(
        string title,
        string description,
        string image,
        uint256 createdAt,
        string category,
        address creator
    );

    // struct for a bet
    struct Bet {
        uint256 amount;
        uint256 optionIndex;
        uint256 createdAt;
        address bettor;
        uint256 creditsRedeemed;
    }

    // event for when a bet is placed
    event BetPlaced(
        uint256 amount,
        uint256 optionIndex,
        uint256 createdAt,
        address bettor,
        uint256 creditsRedeemed
    );

    mapping(uint => MarketEvent) internal marketEvents;

    // map of bets for a market event
    mapping(uint => Bet[]) internal bets;

    // map of credits redeemed for a market event
    mapping(uint => uint256) internal _creditsRedeemed;

    function getMarketEventsLength() public view returns (uint) {
        return marketEventsLength;
    }

    // function to calculate the credits to be redeemed for a bet, with a minimum of 1 credit
    function calculateCreditsToBeRedeemed(
        uint256 marketEventId,
        uint256 betId
    ) public view returns (uint256) {
        uint256 creditsRedeemed = (bets[marketEventId][betId].amount * 100) /
            marketEvents[marketEventId].totalBets;
        if (creditsRedeemed == 0) {
            return 1;
        }
        return creditsRedeemed;
    }

    // function to calculate the odds for a market event
    function calculateOdds(
        uint256 marketEventId
    ) public view returns (uint256[] memory) {
        uint256[] memory odds = new uint256[](
            marketEvents[marketEventId].options.length
        );
        for (
            uint256 i = 0;
            i < marketEvents[marketEventId].options.length;
            i++
        ) {
            odds[i] =
                (marketEvents[marketEventId].totalBets * 100) /
                marketEvents[marketEventId].totalBets;
        }
        return odds;
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
        string memory description,
        string memory image,
        string memory category,
        string[] memory options
    ) public {
        require(validateData(title, category, options), "Invalid data");
        uint256 createdAt = block.timestamp;
        marketEvents[marketEventsLength] = MarketEvent(
            title,
            description,
            image,
            createdAt,
            category,
            payable(msg.sender),
            options,
            true,
            0,
            0,
            0,
            0,
            0
        );
        emit MarketEventCreated(
            title,
            description,
            image,
            createdAt,
            category,
            msg.sender
        );
        marketEventsLength++;
    }

    // function to get a market event
    function getMarketEvent(
        uint256 marketEventId
    ) public view returns (MarketEvent memory) {
        return marketEvents[marketEventId];
    }

    // function to get all market events
    function getMarketEvents() public view returns (MarketEvent[] memory) {
        MarketEvent[] memory _marketEvents = new MarketEvent[](
            marketEventsLength
        );
        for (uint256 i = 0; i < marketEventsLength; i++) {
            _marketEvents[i] = marketEvents[i];
        }
        return _marketEvents;
    }

    // function to get all bets for a market event
    function getBets(uint256 marketEventId) public view returns (Bet[] memory) {
        return bets[marketEventId];
    }

    // function to place a bet - requires a market event id, the amount to bet, and the option index to bet on
    function placeBet(
        uint256 marketEventId,
        uint256 amount,
        uint256 optionIndex
    ) public payable {
        require(marketEvents[marketEventId].isOpen, "Market event is closed");
        require(
            optionIndex < marketEvents[marketEventId].options.length,
            "Invalid option"
        );
        require(amount > 0, "Amount must be greater than 0");
        require(msg.value == amount, "Amount must be equal to value sent");

        MarketEvent storage marketEvent = marketEvents[marketEventId];

        // transfer cUSD from sender to contract
        require(
            IERC20Token(cUsdTokenAddress).transferFrom(
                msg.sender,
                marketEvent.creator,
                amount
            ),
            "Transfer failed"
        );

        uint256 createdAt = block.timestamp;
        address bettor = msg.sender;
        uint256 creditsRedeemed = calculateCreditsToBeRedeemed(
            marketEventId,
            bets[marketEventId].length
        );
        bets[marketEventId].push(
            Bet(amount, optionIndex, createdAt, bettor, creditsRedeemed)
        );
        marketEvents[marketEventId].totalBets += amount;
        marketEvents[marketEventId].totalBettors++;
        marketEvents[marketEventId].totalCreditsRedeemed += creditsRedeemed;
        emit BetPlaced(amount, optionIndex, createdAt, bettor, creditsRedeemed);
    }

    // function to complete event - calculate winners and transfer cUSD to winners
    // function completeEvent(uint256 marketEventId, uint256 optionIndex)
    //     public
    //     payable
    // {
    //     require(marketEvents[marketEventId].isOpen, "Market event is closed");
    //     require(optionIndex < marketEvents[marketEventId].options.length, "Invalid option");
    //     MarketEvent storage marketEvent = marketEvents[marketEventId];
    //     marketEvent.isOpen = false;
    //     uint256 totalCreditsRedeemed = marketEvent.totalCreditsRedeemed;
    //     uint256 totalBets = marketEvent.totalBets;
    //     uint256 totalWinners = 0;
    //     uint256 totalCreditsRetired = 0;
    //     for (uint256 i = 0; i < bets[marketEventId].length; i++) {
    //         if (bets[marketEventId][i].optionIndex == optionIndex) {
    //             totalWinners++;
    //             totalCreditsRetired += bets[marketEventId][i].creditsRedeemed;
    //         }
    //     }
    //     uint256 creditsPerWinner = totalCreditsRedeemed / totalWinners;
    //     for (uint256 i = 0; i < bets[marketEventId].length; i++) {
    //         if (bets[marketEventId][i].optionIndex == optionIndex) {
    //             // transfer cUSD from contract to winner
    //             require(
    //                 IERC20Token(cUsdTokenAddress).transferFrom(
    //                     marketEvent.creator,
    //                     bets[marketEventId][i].bettor,
    //                     creditsPerWinner
    //                 ),
    //                 "Transfer failed"
    //             );
    //         }
    //     }
    //     marketEvent.totalWinners = totalWinners;
    //     marketEvent.totalCreditsRetired = totalCreditsRetired;
    // }
}
