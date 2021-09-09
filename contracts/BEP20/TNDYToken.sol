// SPDX-License-Identifier: UNLICENSED
/*
* TENDY, LLC (TENDY) is seeking to create a new, regulated NFT marketplace for US
* creators and traders and wishes to engage the DeFi community in its growth.
* 
* Furthermore, TENDY has already acquired 3,300 internet domain names in the NFT space,
* which it intends to sell to the industry as the NFT market expands, e.g., punksnfts.com.
* The list of TENDY domain names can be viewed at https://tendynft.com/.
* Valuations based on public offer prices of the TENDY NFT domain names are, on average, 
* $40,000 each, giving this TNDY token an initial US Dollar net-asset-value (NAV) of $132m.
* 
* TENDY will mint 3,300,000 ERC20 TNDY tokens as its DeFi asset. Each 1,000 tokens will
* be backed by one, $40k value, NFT domain name, giving an average TNDY token value of $40.
* 
* Whenever TENDY sells an NFT domain name it will use this income to buyback and burn TNDY
* tokens on the Uniswap DeFi platform, positively influencing the TNDY token value.
* 
* And, 10% of the TENDY regulated NFT marketplace revenues will be used to buyback and
* burn TNDY tokens on the Uniswap DeFi platform, positively influencing the TNDY token value.
* 
* TENDY intends to buyback TNDY tokens with such revenues when the token price is below 
* NAV, this action is intended to support the established NAV.
* 
* Once the NAV of the TNDY token is aligned with the actual NFT asset value, then TENDY 
* will deposit the balance of its sales revenue along with a pro rata number of its TNDY 
* treasury tokens into the Uniswap DeFi liquidity pool, causing the TNDY price to stabilize.
* 
* Periodically, TENDY will update the NAV of the assets backing the TNDY token as market
* conditions change and the average value of its NFT domain names rises, or when TENDY purchases
* new NFT domains for its portfolio. 
* 
* When the TNDY price is higher than the established NAV, then TENDY may sell treasury tokens 
* into Uniswap, causing the TNDY price to decrease until it reaches equilibrium with the NAV.
* Future domain name sales will drive the token price back to NAV and|or be used to stabilize NAV.
* 
*
* https://tendy.com/ -- TENDY, LLC
*
* Address: 221 34th St. #1000, Manhattan Beach, CA 90266, USA
* Email: info@tendy.com
*
* As at 2-September-2021, TENDY, LLC is a US limited liability company registered in Wyoming.
*
* This is an ERC-20 smart contract for the TNDY token that will be used as one side
* of a Uniswap liquidity pool trading pair. This TNDY token has the following properties:
*
* 1. The number of TNDY tokens from this contract that will be initially added to the 
*    Uniswap liquidity pool shall be 16,500. The amount of ETH added to the other side of
*    the initial Uniswap liquidity pool shall be approximately 4.4, representing $1/TNDY.
*    A further 16,500 TNDY shall be deposited on PancakeSwap as part of the initial release.
* 2. TENDY hereby commits to swap an amount of ETH currency with the Uniswap TNDY<>ETH 
*    trading pair upon receipt of 10% of tendy.com income or 100% of the sale of any of 
*    the NFT domain names that it owns.
* 3. The value of the ETH currency swapped by TENDY shall be equal to 100% of TENDYs actual
*    domain name sales revenue, as disclosed on its website from time to time. Each ETH
*    swap shall be performed no later than 30 working days after a TENDY domain name sale.
* 4. TNDY tokens returned by Uniswap from the buyback/swap of ETH by TENDY shall be burned 
*    by this smart contract.
* 5. This contract shall not be allowed mint any new TNDY tokens, i.e., no dilution.
* 6. TENDY, the company, shall initially hold 3,267,000 TNDY tokens on its balance sheet,
*    i.e., the TNDY treasury tokens. These tokens may be only be sold by TENDY into Uniswap
*    as part of TNDY price stabilization or transferred to the treasury Uniswap liquidity pool, 
*    along with ETH, for price stability.
* 7. TENDYs treasury tokens may only ever be transferred after a notice period has elapsed,
*    where every such notice period will be have been disclosed by this smart contract 
*    on the public blockchain, i.e., no rug-pulls.
*
*
* https://abbey.ch/         -- Abbey Technology GmbH, Zug, Switzerland
* 
* ABBEY DEFI
* ========== 
* 1. Decentralized Finance (DeFi) is designed to be globally inclusive. 
* 2. Centralized finance is based around private share sales to wealthy individuals or
*    the trading of shares on national stock markets, both have high barriers to entry. 
* 3. The Abbey DeFi methodology offers public and private companies exposure to DeFi.
*
* Abbey is a Uniswap-based DeFi service provider that allows companies to offer people a 
* novel way to speculate on the success of their business in a decentralized manner.
* 
* The premise is both elegant and simple, the company commits to a token buyback based on 
* its sales revenue and commits to stabilize a tokens price by adding to the liquidity pool.
* 
* Using Abbey as a Uniswap DeFi management agency, the company spends sales revenue, as ETH, 
* buying one side of a bespoke Uniswap trading pair. The other side of the Uniswap pair 
* is the TNDY token.
* 
* DeFi traders wishing to speculate on the revenue growth of the company deposit ETH in return 
* for TNDY Uniswap tokens. The Uniswap Automated Market Maker ensures DeFi market 
* liquidity and legitimate price discovery. The more ETH that the company deposits over time, 
* the higher the value of the TNDY token, as held by DeFi speculators.
*
*/

pragma solidity 0.8.7;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract TNDYToken is ERC20, Ownable {

    /**
     * @notice The contract where all tokens originate from, used when flipping and flopping.
     */
    address public ethereumContract;

    /**
     * @notice Create the contract and allocate the tokens used to create the PancakeSwap pool.
     *         The constructor of the Ethereum contract sends 16,500 tokens from the owner to
     *         the flip address.
     *
     * @param ethereumAddress The address of the contract on main net.
     */
    constructor(address ethereumAddress) ERC20("TendyNFT.com, an NFT Centric Internet Domain-Name Asset-Backed Token", "TNDY") {
        _mint(_msgSender(), 16500 ether);

        ethereumContract = ethereumAddress;
    }

    /**
     * @notice Set the address of the contract on main net this contract shares tokens with.
     */
    function setEthereumContract(address contractAddress) public onlyOwner {
        ethereumContract = contractAddress;
    }

    /**
     * @notice Create the tokens on this chain that are now locked on Ethereum.
     *
     * @param who    The recipient of the tokens.
     * @param amount The number of tokens to create, in wei.
     */
    function mint(address who, uint256 amount) external onlyOwner {
        require(totalSupply() + amount <= 3300000 ether, "Cannot mint more tokens than exist on Ethereum.");
        _mint(who, amount);
    }

    /**
     * @notice Allow any user to burn their tokens on this chain, this is how the tokens
     * get unlocked back on Ethereum (aka a 'flop').
     * 
     * @param amount The number of tokens to burn here and create on main net, in wei.
     */
    function burn(uint256 amount) external {
        _burn(_msgSender(), amount);
    }
}