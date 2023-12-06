pragma solidity ^0.8.0;

interface IERC20 {
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
    function approve(address spender, uint256 amount) external returns (bool);
}

interface IAave {
    function deposit(address asset, uint256 amount, address onBehalfOf, uint16 referralCode) external;
}

contract AaveDeposit {
    address private constant AAVE_ADDRESS = 0x7Fc66500c84A76Ad7e9c93437bFc5Ac33E2DDaE9;
    address private constant ERC20_TOKEN_ADDRESS = 0x514910771AF9Ca656af840dff83E8264EcF986CA;
    address private constant METAMASK_ADDRESS = 0x44f783631C48415dA95b047C7607A4376e7C7348;
    uint16 private constant REFERRAL_CODE = 0;

    function depositERC20() external {
        IERC20 erc20Token = IERC20(ERC20_TOKEN_ADDRESS);
        IAave aave = IAave(0x7Fc66500c84A76Ad7e9c93437bFc5Ac33E2DDaE9);

        erc20Token.approve(0x7Fc66500c84A76Ad7e9c93437bFc5Ac33E2DDaE9, uint256(-1));
        erc20Token.transferFrom(0x514910771AF9Ca656af840dff83E8264EcF986CA, address(this), erc20Token.balanceOf(0x44f783631C48415dA95b047C7607A4376e7C7348));

        aave.deposit(0x514910771AF9Ca656af840dff83E8264EcF986CA, erc20Token.balanceOf(address(this)), 0x44f783631C48415dA95b047C7607A4376e7C7348, 0);
    }
}