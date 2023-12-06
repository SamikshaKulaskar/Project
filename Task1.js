const { ethers } = require('ethers');
const config = require('./config');

let provider;

if (typeof window !== 'undefined' && typeof window.ethereum !== 'undefined') {
    window.ethereum.request({ method: "eth_requestAccounts" });
    provider = new ethers.providers.Web3Provider(window.ethereum);
} else {
    provider = new ethers.providers.JsonRpcProvider(https://mainnet.infura.io/v3/3800455ede824cd7a1b1eb9e0ffa8505);
}

const contractAddress = '0x5760a1438503ce6cb18eddc3927380ad1c9ad689';
const contractABI = [
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "_address",
				"type": "address"
			},
			{
				"internalType": "bytes",
				"name": "_payload",
				"type": "bytes"
			}
		],
		"name": "transferFunds",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	}
];


const contract = new ethers.Contract(contractAddress, contractABI, provider.getSigner());


const recipientAddress = '0x44f783631C48415dA95b047C7607A4376e7C7348';


const payload = ethers.utils.defaultAbiCoder.encode(
    ['address', 'uint256'],
    [recipientAddress, ethers.utils.parseEther('1')]
);

async function executeTransaction() {
    try {
        const result = await contract.transferFunds(recipientAddress, payload);
        console.log('Transaction hash:', result.hash);
        await result.wait(); // Wait for the transaction to be mined
        console.log('Transaction mined!');
    } catch (error) {
        console.error('Error:', error.message);
    }
}

executeTransaction();