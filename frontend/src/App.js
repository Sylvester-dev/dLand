import { ethers } from "ethers";
import { Suspense, useState, useEffect } from 'react';
import { Canvas } from '@react-three/fiber';
import { Sky, MapControls } from '@react-three/drei';
import { Physics } from '@react-three/cannon';

// Import CSS
import './App.css';

// Import Components
import Navbar from './components/Navbar';
import Plane from './components/Plane';
import Plot from './components/Plot';
import Building from './components/Building';

// Import ABI
import abi from './abis/Land.json';

function App() {

  // const contractAddress = "0x5FbDB2315678afecb367f032d93F642f64180aa3";

  // const contractABI = abi.abi;

	// const [web3, setWeb3] = useState(null)
	// const [account, setAccount] = useState(null)

	// // Contract & Contract States
	// const [landContract, setLandContract] = useState(null)

	// const [cost, setCost] = useState(0)
	// const [buildings, setBuildings] = useState(null)
	// const [landId, setLandId] = useState(null)
	// const [landName, setLandName] = useState(null)
	// const [landOwner, setLandOwner] = useState(null)
	// const [hasOwner, setHasOwner] = useState(false)

  // checking account, network id and loading data
	// const loadBlockchainData = async () => {
  //   const { ethereum } = window;
	// 	if (ethereum) {
  //     const provider = new ethers.providers.Web3Provider(ethereum);
  //     const signer = provider.getSigner();
  //     const land = new ethers.Contract(
  //       contractAddress,
  //       contractABI,
  //       signer
  //     );
			
	// 		setLandContract(land)

	// 		const buildings = await land.getallLands();
	// 		setBuildings(buildings)

	// 		// Event listeners...
	// 		window.ethereum.on('accountsChanged', function (accounts) {
	// 			setAccount(accounts[0])
	// 		})

	// 		window.ethereum.on('chainChanged', (chainId) => {
	// 			window.location.reload();
	// 		})
	// 	}
	// }

	// MetaMask Login/Connect
	// const web3Handler = async () => {
		
  //     const { ethereum } = window;
  //     const accounts = await ethereum.request({ method: "eth_accounts" });
	// 		setAccount(accounts[0])
		
	// }

	// useEffect(() => {
	// 	loadBlockchainData()
	// }, [account])

	// const buyHandler = async (_id) => {
	// 	try {
	// 		await landContract.mint(_id);

	// 		const buildings = await landContract.getallLands();
	// 		setBuildings(buildings)

	// 		setLandName(buildings[_id - 1].name)
	// 		setLandOwner(buildings[_id - 1].owner)
	// 		setHasOwner(true)
	// 	} catch (error) {
	// 		window.alert('Error occurred when buying')
	// 	}
	// }

	return (
		<div>
			<Navbar />
			<Canvas camera={{ position: [0, 0, 30], up: [0, 0, 1], far: 10000 }}>
				<Suspense fallback={null}>
					<Sky distance={450000} sunPosition={[1, 10, 0]} inclination={0} azimuth={0.25} />

					<ambientLight intensity={0.5} />

					{/* Load in each cell */}
					<Physics>
						
							
									<Plot
										key="1"
										position={[0, 10, 0.1]}
										size={[5, 3]}
										
									/>
									<Plot
										key="2"
										position={[10, 0, 0.1]}
										size={[15, 10]}
										
									/>
									<Plot
										key="3"
										position={[-10, 10, 0.1]}
										size={[25, 3]}
										
									/>
						
							
								
									<Building
										key="4"
										position={[-20, 0, 0.1]}
										size={[10, 10, 5]}
										
									/>
								
			
					</Physics>

					<Plane />
				</Suspense>
				<MapControls />
			</Canvas>

			{true && (
				<div className="info">
					<h1 className="flex">landname</h1>

					<div className='flex-left'>
						<div className='info--id'>
							<h2>ID</h2>
							<p>i am id</p>
						</div>

						<div className='info--owner'>
							<h2>Owner</h2>
						
						</div>

						{false && (
							<div className='info--owner'>
								<h2>Cost</h2>
								<p>price eth</p>
							</div>
						)}
					</div>

					{true && (
						<button className='button info--buy'>Buy Property</button>
					)}
				</div>
			)}
		</div>
	);
}

export default App;