// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

interface ITriKittyFactory {
    function admin() external view returns (address);

    function future_admin() external view returns (address);

    function fee_receiver() external view returns (address);

    function pool_implementations(
        uint256 _index
    ) external view returns (address);

    function gauge_implementation() external view returns (address);

    function views_implementation() external view returns (address);

    function math_implementation() external view returns (address);

    function pool_count() external view returns (uint256);

    // pool_list: public(address[4294967296])   # master list of pools
    function pool_list(uint256 _index) external view returns (address);

    function deploy_pool(
        string calldata _name,
        string calldata _symbol,
        address[3] calldata _coins,
        address _weth,
        uint256 implementation_id,
        uint256 A,
        uint256 gamma,
        uint256 mid_fee,
        uint256 out_fee,
        uint256 fee_gamma,
        uint256 allowed_extra_profit,
        uint256 adjustment_step,
        uint256 ma_exp_time,
        uint256[2] calldata initial_prices
    ) external returns (address);

    /**
     * @notice Deploy a liquidity gauge for a factory pool
     * @param _pool Factory pool address to deploy a gauge for
     * @return Address of the deployed gauge
     */
    function deploy_gauge(address _pool) external returns (address);

    function set_fee_receiver(address _fee_receiver) external;

    /**
     * @notice Set pool implementation
     * @dev Set to empty(address) to prevent deployment of new pools
     * @param _pool_implementation Address of the new pool implementation
     * @param _implementation_index Index of the pool implementation
     */
    function set_pool_implementation(
        address _pool_implementation,
        uint256 _implementation_index
    ) external;

    /**
     * @notice Set gauge implementation
     * @dev Set to empty(address) to prevent deployment of new gauges
     * @param _gauge_implementation Address of the new token implementation
     */
    function set_gauge_implementation(address _gauge_implementation) external;

    function set_views_implementation(address _views_implementation) external;

    function set_math_implementation(address _math_implementation) external;

    function commit_transfer_ownership(address _addr) external;

    function accept_transfer_ownership() external;

    /**
     * @notice Find an available pool for exchanging two coins
     * @param _from Address of coin to be sent
     * @param _to Address of coin to be received
     * @return Pool address
     */
    function find_pool_for_coins(
        address _from,
        address _to
    ) external view returns (address);

    /**
     * @notice Find an available pool for exchanging two coins
     * @param _from Address of coin to be sent
     * @param _to Address of coin to be received
     * @param i Index value. When multiple pools are available this value is used to return the n'th address.
     * @return Pool address
     */
    function find_pool_for_coins(
        address _from,
        address _to,
        uint256 i
    ) external view returns (address);

    function get_coins(address _pool) external view returns (address[3] memory);

    function get_decimals(
        address _pool
    ) external view returns (uint256[3] memory);

    function get_balances(
        address _pool
    ) external view returns (uint256[3] memory);

    /**
     * @notice Convert coin addresses to indices for use with pool methods
     * @param _pool Pool address
     * @param _from Coin address to be used as `i` within a pool
     * @param _to Coin address to be used as `j` within a pool
     * @return uint256 `i`, uint256 `j`
     */
    function get_coin_indices(
        address _pool,
        address _from,
        address _to
    ) external view returns (uint256, uint256);

    function get_gauge(address _pool) external view returns (address);

    function get_market_counts(
        address _coin_a,
        address _coin_b
    ) external view returns (uint256);
}
